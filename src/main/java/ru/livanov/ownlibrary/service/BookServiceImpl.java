package ru.livanov.ownlibrary.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.livanov.ownlibrary.dao.BookDAO;
import ru.livanov.ownlibrary.model.Book;

import java.util.List;

@Service
public class BookServiceImpl implements BookService {

    private BookDAO bookDAO;

    @Autowired
    public void setBookDAO(BookDAO bookDAO) {
        this.bookDAO = bookDAO;
    }

    @Override
    @Transactional
    public List<Book> allBooks(int page) {
        return bookDAO.allBooks(page);
    }

    @Override
    @Transactional
    public void add(Book book) {
        bookDAO.add(book);
    }

    @Override
    @Transactional
    public void delete(Book book) {
        bookDAO.delete(book);
    }

    @Override
    @Transactional
    public void edit(Book book) {
        bookDAO.edit(book);
    }

    @Override
    @Transactional
    public Book getById(int id) {
        return bookDAO.getById(id);
    }

    @Override
    @Transactional
    public int booksCount() {
        return bookDAO.booksCount();
    }

    @Override
    @Transactional
    public boolean checkTitle(String title) {
        return bookDAO.checkTitle(title);
    }
}
