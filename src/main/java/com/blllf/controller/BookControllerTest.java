package com.blllf.controller;

import com.blllf.pojo.Book;
import com.blllf.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BookControllerTest {

    @Autowired
    private BookService bookService;

    @RequestMapping("/book2")
    public ModelAndView findBookById(Integer id){

        Book book = bookService.findBookById(id);

        ModelAndView modelAndView = new ModelAndView();

        modelAndView.addObject("book" , book);

        modelAndView.setViewName("/books");

        return modelAndView;
    }
}
