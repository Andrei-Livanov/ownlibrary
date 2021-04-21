package ru.livanov.ownlibrary.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import ru.livanov.ownlibrary.model.Book;

import java.util.List;

@Repository
public class BookDAOImpl implements BookDAO {
    private SessionFactory sessionFactory;

    @Autowired
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Book> allBooks(int page) {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("from Book").setFirstResult(10 * (page - 1)).setMaxResults(10).list();
    }

    @Override
    public void add(Book book) {
        Session session = sessionFactory.getCurrentSession();
        session.persist(book);
    }

    @Override
    public void delete(Book book) {
        Session session = sessionFactory.getCurrentSession();
        session.delete(book);
    }

    @Override
    public void edit(Book book) {
        Session session = sessionFactory.getCurrentSession();
        session.update(book);
    }

    @Override
    public Book getById(int id) {
        Session session = sessionFactory.getCurrentSession();
        return session.get(Book.class, id);
    }

    @Override
    public int booksCount() {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("select count(*) from Book", Number.class).getSingleResult().intValue();
    }

    @Override
    public boolean checkTitle(String title) {
        Session session = sessionFactory.getCurrentSession();
        Query query;
        query = session.createQuery("from Book where title = :title");
        query.setParameter("title", title);
        return query.list().isEmpty();
    }
}
