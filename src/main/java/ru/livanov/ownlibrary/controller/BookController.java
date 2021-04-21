package ru.livanov.ownlibrary.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import ru.livanov.ownlibrary.model.Book;
import ru.livanov.ownlibrary.service.BookService;

import java.util.List;

@Controller
public class BookController {
    private int page;

    private BookService bookService;

    @Autowired
    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView allBooks(@RequestParam(defaultValue = "1") int page) {
        List<Book> books = bookService.allBooks(page);
        int booksCount = bookService.booksCount();
        int pagesCount = (booksCount + 9) / 10;
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("books");
        modelAndView.addObject("page", page);
        modelAndView.addObject("booksList", books);
        modelAndView.addObject("booksCount", booksCount);
        modelAndView.addObject("pagesCount", pagesCount);
        this.page = page;
        return modelAndView;
    }

    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public ModelAndView addPage(@ModelAttribute("message") String message) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("editPage");
        return modelAndView;
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public ModelAndView addBook(@ModelAttribute("book") Book book) {
        ModelAndView modelAndView = new ModelAndView();
        if (bookService.checkTitle(book.getTitle())) {
            modelAndView.setViewName("redirect:/");
            modelAndView.addObject("page", page);
            bookService.add(book);
        } else {
            modelAndView.addObject("message", "Book with title \"" + book.getTitle() + "\" already exists!");
            modelAndView.setViewName("redirect:/add");
        }
        return modelAndView;
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public ModelAndView editPage(@PathVariable("id") int id,
                                 @ModelAttribute("message") String message) {
        Book book = bookService.getById(id);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("editPage");
        modelAndView.addObject("book", book);
        return modelAndView;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    public ModelAndView editBook(@ModelAttribute("book") Book book) {
        ModelAndView modelAndView = new ModelAndView();
        if (bookService.checkTitle(book.getTitle()) || bookService.getById(book.getId()).getTitle().equals(book.getTitle())) {
            modelAndView.setViewName("redirect:/");
            modelAndView.addObject("page", page);
            bookService.edit(book);
        } else {
            modelAndView.addObject("message", "Book with title \"" + book.getTitle() + "\" already exists!");
            modelAndView.setViewName("redirect:/edit/" + +book.getId());
        }
        return modelAndView;
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public ModelAndView deleteBook(@PathVariable("id") int id) {
        ModelAndView modelAndView = new ModelAndView();
        int booksCount = bookService.booksCount();
        int page = ((booksCount - 1) % 10 == 0 && booksCount > 10 && this.page == (booksCount + 9) / 10) ?
                this.page - 1 : this.page;
        modelAndView.setViewName("redirect:/");
        modelAndView.addObject("page", page);
        Book book = bookService.getById(id);
        bookService.delete(book);
        return modelAndView;
    }
}
