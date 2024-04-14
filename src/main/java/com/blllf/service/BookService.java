package com.blllf.service;

import com.blllf.entity.PageResult;
import com.blllf.pojo.Book;

import java.text.ParseException;
import java.util.List;

public interface BookService {
    public Book findBookById(Integer id);

    //查询最新上架的图书
    public PageResult selectNewBooks(Integer pageNum , Integer pageSize);

    public PageResult selectByStatus(Integer pageNum , Integer pageSize);

    //根据Id查询信息
    Book findById(Integer id);

    //借阅图书
    Integer borrowBook(Book book) throws ParseException;

    List<Book> selectBooks();

    //分页查询 页数 和 一页中有多少数量
    PageResult selectBooks(Integer pageNum , Integer pageSize);


    //分页条件查询
    public List<Book> selectBookByCondition(Book book);


    //新增书本
    Integer insertBook(Book book);


    //管理员工修改书本
    Integer updateBook(Book book);


    //归还图书
    Boolean returnTheBook(Book book);

    //管理员确认归还图书
    Boolean adminReturnBook(Book book);


    //管理员下架图书单本
    Integer takenOffBook(int[] ids);



}
