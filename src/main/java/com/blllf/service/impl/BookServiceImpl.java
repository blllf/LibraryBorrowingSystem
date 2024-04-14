package com.blllf.service.impl;

import com.blllf.dao.BookMapper;
import com.blllf.entity.PageResult;
import com.blllf.pojo.Book;
import com.blllf.service.BookService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class BookServiceImpl implements BookService {

    @Autowired
    private BookMapper bookMapper;
    @Override
    public Book findBookById(Integer id) {

        return bookMapper.findBookById2(id);
    }


    /**
     * 这个方法的目的是 获得PageResult类型中所写的属性值 总数 和 返回的数据集合
     *
     * */
    @Override
    public PageResult selectNewBooks(Integer pageNum, Integer pageSize) {
        //在使用 PageHelper 进行分页时，必须保证 PageHelper.startPage() 方法在 MyBatis 的查询方法之前被调用。
        PageHelper.startPage(pageNum , pageSize);

        Page<Book> books = bookMapper.selectNewBooks();

        System.out.println(books.getTotal());
        System.out.println(books.getResult());

        return new PageResult(books.getTotal() , books.getResult());
    }

    //根据状态查询书本
    @Override
    public PageResult selectByStatus(Integer pageNum, Integer pageSize) {

        PageHelper.startPage(pageNum , pageSize);

        Page<Book> books = bookMapper.selectByStatus();


        return new PageResult(books.getTotal() , books.getResult());
    }

    //根据id查询图书信息
    @Override
    public Book findById(Integer id) {
        return bookMapper.findById(id);
    }

    //借阅图书
    //book 申请借阅的图书
    @Override
    public Integer borrowBook(Book book) throws ParseException {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        String uploadTime = book.getReturnTime();
        if (uploadTime != null) {
            //2024-04-09T16:00:00.000Z
            // 创建 SimpleDateFormat 对象，用于解析日期字符串
            SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");

            Date data = inputFormat.parse(uploadTime);
            String formatTime = sdf.format(data);

            //将归还书本时间做一个格式化为 "yyyy-MM-dd"
            book.setReturnTime(formatTime);

            //设置借阅时间为当前天
            book.setBorrowTime(sdf.format(new Date()));
        }

        //设置借阅人
        /*book.setBorrower(book.getName());*/

        book.setStatus("1");

        return bookMapper.editBook(book);
    }




    //查询所有课本
    @Override
    public List<Book> selectBooks() {

        List<Book> books = bookMapper.selectBooks();

        return books;
    }

    @Override
    public PageResult selectBooks(Integer pageNum, Integer pageSize) {

        PageHelper.startPage(pageNum , pageSize);

        Page<Book> books = bookMapper.selectNewBooks();

        return new PageResult(books.getTotal() , books.getResult());
    }

    //根据条件查询
    @Override
    public List<Book> selectBookByCondition(Book book) {

        List<Book> books = bookMapper.selectBookB(book);


        return books;
    }


    //根据条件查询并且分页
    //暂时具体实现方法不在service层写了，在控制层中


    //新增书本
    @Override
    public Integer insertBook(Book book) {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        //当前时间为书本上传时间
        book.setUploadTime(sdf.format(new Date()));

        return bookMapper.insertBook(book);
    }

    @Override
    public Integer updateBook(Book book) {

        String status = book.getStatus();

        int num = Integer.parseInt(status);

        return bookMapper.editBook(book);

        /*if (num != 0){

            return 0;

        }else {

            return bookMapper.editBook(book);

        }*/

    }

    //普通人归还图书
    @Override
    public Boolean returnTheBook(Book book) {
        String status = book.getStatus();

        int num = Integer.parseInt(status);

        num = 2;

        book.setStatus(String.valueOf(num));

        Integer i = bookMapper.returnBook(book);

        if (i > 0){
            return true;
        }else {
            return false;
        }

    }

    //管理员确认归还图书
    @Override
    public Boolean adminReturnBook(Book book) {

        String status = book.getStatus();
        int num = Integer.parseInt(status);
        num = 0;
        book.setStatus(String.valueOf(num));
        book.setBorrower(null);
        book.setBorrowTime(null);
        book.setReturnTime(null);

        Integer i = bookMapper.adminReturn(book);

        if (i > 0){
            return true;
        }else {
            return false;
        }
    }


    //管理员下架图书单本
    @Override
    public Integer takenOffBook(int[] ids) {

        Integer i = bookMapper.takenOffBooks(ids);

        return i;
    }




}
