import org.hibernate.*;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.criterion.Restrictions;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

public class TD03 extends HttpServlet
{
    public static List<Client> rechercherClient(String name)
    {
        Configuration configuration = new Configuration().configure();
        StandardServiceRegistryBuilder builder = new StandardServiceRegistryBuilder().applySettings(configuration.getProperties());
        SessionFactory factory = configuration.buildSessionFactory(builder.build());
        Session session = factory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            Criteria criteriaClient = session.createCriteria(Client.class);
            criteriaClient.add(Restrictions.eq("clientName", name));
            List<Client> clients = criteriaClient.list();
            for (Iterator<Client> iterator = clients.iterator(); iterator.hasNext();)
            {
                Client client = iterator.next();
                System.out.println(client.getClientId() + "-" + client.getClientName());
            }
            transaction.commit();
            return clients;
        } catch (HibernateException e) {
            transaction.rollback();
            e.printStackTrace();
            return null;
        } finally {
            session.close();
        }
    }
    public static List<Client> listClient()
    {
        Configuration configuration = new Configuration().configure();
        StandardServiceRegistryBuilder builder = new StandardServiceRegistryBuilder().applySettings(configuration.getProperties());
        SessionFactory factory = configuration.buildSessionFactory(builder.build());
        Session session = factory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            Criteria criteriaClient = session.createCriteria(Client.class);
            List<Client> clients = criteriaClient.list();
            for (Iterator<Client> iterator = clients.iterator(); iterator.hasNext();)
            {
                Client client = iterator.next();
                System.out.println(client.getClientId() + "-" + client.getClientName());
            }
            transaction.commit();
            return clients;
        } catch (HibernateException e) {
            transaction.rollback();
            e.printStackTrace();
            return null;
        } finally {
            session.close();
        }
    }

    public void insert(String name) {
        Configuration configuration = new Configuration().configure();
        StandardServiceRegistryBuilder builder = new StandardServiceRegistryBuilder().applySettings(configuration.getProperties());
        SessionFactory factory = configuration.buildSessionFactory(builder.build());
        Session session = factory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            Client client = new Client();
            client.setClientName(name);
            session.save(client);
            transaction.commit();
        } catch (HibernateException e) {
            transaction.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String forward="/index.jsp";
        String type = request.getParameter("type");
        if (type.equals("insert")) {
            System.out.println("Mode insert");
            String name = request.getParameter("name");
            if (name.isEmpty()==false) {
                insert(name);
            }
        } else if (type.equals("rechercher")) {
            System.out.println("Mode recherche");
            String name = request.getParameter("name");
            request.setAttribute("rechercherClient", rechercherClient(name));
        } else {
            System.out.println("Mode liste");
            request.setAttribute("listClient", listClient());
        }
        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
    }
}