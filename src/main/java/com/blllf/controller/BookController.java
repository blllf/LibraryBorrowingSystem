package com.blllf.controller;

import com.alibaba.druid.support.json.JSONParser;
import com.alibaba.fastjson.JSON;
import com.blllf.dao.BookMapper;
import com.blllf.dao.RecordMapper;
import com.blllf.entity.PageBean;
import com.blllf.entity.PageResult;
import com.blllf.entity.Result;
import com.blllf.pojo.Book;
import com.blllf.pojo.Record;
import com.blllf.pojo.SelectIdsWrapper;
import com.blllf.pojo.User;
import com.blllf.service.BookService;
import com.blllf.service.RecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;


/**
 * 图书信息
 * */


@Controller
public class BookController {

    @Autowired
    private BookService bookService ;

    @Autowired
    private BookMapper bookMapper;

    @Autowired
    private RecordService recordService;

    @Autowired
    private RecordMapper recordMapper;

    /**
     * 查询新上架的书籍
     * */


    @RequestMapping("/selectNewBooks")
    public ModelAndView selectNewBooks(){
        //暂且把这个方法当作一个跳转新页面的功能
        //查询新上架的5个图书信息
        /*int pageNum = 1;
        int pageSize = 5;
        PageResult pageResult = bookService.selectNewBooks(pageNum, pageSize);*/
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/books_new");
        //modelAndView.addObject("pageResult",pageResult);
        return modelAndView;
    }

    @RequestMapping("/searchBorrowed")
    public ModelAndView searchBorrowed(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/books_borrow");
        return modelAndView;
    }


    //推荐书本功能，分页一次展现5个
    @ResponseBody
    @RequestMapping("/testJson")
    public PageResult testJson(){

        int pageSize = 6;

        //数据在这个范围内随机抽选
        Random random = new Random();
        int pageNum = random.nextInt(3) + 1;

        PageResult pageResult = bookService.selectBooks(pageNum, pageSize);

        System.out.println(pageResult);

        return pageResult;
    }

    @ResponseBody
    @RequestMapping("/paginatedQueries")
    //图书借阅中分页
    public PageResult paginatedQueries(Integer pageNum , Integer pageSize){

        PageResult pageResult = bookService.selectBooks(pageNum, pageSize);


        return pageResult;
    }


    @ResponseBody
    @RequestMapping("/selectByStatus")
    public PageResult selectByStatus(Integer pageNum , Integer pageSize){

        PageResult pageResult = bookService.selectByStatus(pageNum, pageSize);

        System.out.println("status: " + pageResult);

        return pageResult;

    }


    /**
     * 此方法与findBookByCondition方法相同
     * 根据条件查询不分页
     * */
    @ResponseBody
    @RequestMapping("/selectByCondition")
    public List<Book> selectByCondition(@RequestBody Book book ){

        String name = book.getName();
        String author = book.getAuthor();
        String press = book.getPress();

        if (name != null && name.length() > 0){
            book.setName("%"+name+"%");
        }

        if (author != null && author.length() > 0){
            book.setAuthor("%"+author+"%");
        }

        if (press != null && press.length() > 0){
            book.setPress("%"+press+"%");
        }

        List<Book> books = bookService.selectBookByCondition(book);

        return books;
    }



    //根据条件查询分页
    //有个小Bug现在先不用
    @ResponseBody
    @RequestMapping("/findBookByCondition")
    public PageBean<Book> findBookByCondition(@RequestBody Book book , Integer pageNum , Integer pageSize){

        int begin = (pageNum - 1) * pageSize;
        int size = pageSize;

        System.out.println("book " + book);

        String name = book.getName();
        String author = book.getAuthor();
        String press = book.getPress();

        System.out.println("name " + name);
        System.out.println("author " + author);
        System.out.println("book " + book);

        if (name != null && name.length() > 0){
            book.setName("%"+name+"%");
        }

        if (author != null && author.length() > 0){
            book.setAuthor("%"+author+"%");
        }

        if (press != null && press.length() > 0){
            book.setPress("%"+press+"%");
        }

        List<Book> books = bookMapper.findBookByCondition(begin, size, book);

        System.out.println("books " + book);

        int total = bookMapper.selectTotalByCount(book);

        System.out.println("total " + total);

        return new PageBean<>(total , books);

    }



    @ResponseBody
    @RequestMapping("/selectAll")
    public List<Book> selectAll(){

        List<Book> books = bookService.selectBooks();

        return books;
    }




    //展现了所有的书，book转换JSON
    @ResponseBody
    @RequestMapping("/book")
    public List<Book> findBookJson(){
        List<Book> books = bookService.selectBooks();

        System.out.println(books);

        return books;
    }



    /**
     * 根据id查询图书信息
     * @ResponseBody
     * 用于指示方法返回的对象应该直接写入 HTTP 响应体中，而不是通过视图解析器渲染为视图。
     * 将方法返回的数据以 JSON、XML 等格式直接返回给客户端。
     * 将方法返回的对象转换为指定的格式，如 JSON 或 XML。
     * */

    @ResponseBody
    @RequestMapping("/findBookById")
    public Result<Book> findBookById(Integer id){
        Book book = bookService.findById(id);

        System.out.println(book);

        if (book == null){
           return new Result(false,"查询失败");
        }

        return new Result<>(true , "查询图书成功" , book);
    }

    /**
     * 借阅图书
     * 参数 book ： 借阅的图书
     * */

    @RequestMapping("/borrowBooks")
    public void borrowBooks(@RequestBody Book book , HttpSession session , HttpServletResponse response)
            throws IOException, ParseException {
        String name = ((User) session.getAttribute("user_session")).getName();
        //借书人
        //book.setBorrower(name);
        if (book.getReturnTime() == null || book.getReturnTime().length() == 0){

            response.getWriter().write("fail");

        }else {

            Integer i = bookService.borrowBook(book);

            response.getWriter().write("success");
        }

    }


    /**
     * 新增书本
     * @RequestBody 客户端发送的是JSON格式的数据，处理器无法直接使用方法的形参接收数据，以及自动完成数据绑定
     * @RequestBody注解可以将JSON数据绑定到形参中
     * */

    @RequestMapping("/addBook")
    public void addBook(@RequestBody Book book , HttpServletResponse response) throws IOException {

        String status = book.getStatus();

        int num = Integer.parseInt(status);

        if (num != 0){
            response.getWriter().write("fail");
            return;
        }

        Integer i = bookService.insertBook(book);

        if (i > 0){
            System.out.println("成功");
            response.getWriter().write("success");
        }else {
            System.out.println("失败");
        }
    }


    @ResponseBody
    @RequestMapping("/updateBook")
    public void updateBook(@RequestBody Book book , HttpServletResponse response ) throws IOException {

        Integer i = bookService.updateBook(book);

        if (i > 0){
            System.out.println("修改成功");
            response.getWriter().write("success");
        }else {
            response.getWriter().write("fail");
        }

    }




    @ResponseBody
    @RequestMapping("/returnTheBook")
    //归还图书
    public void returnTheBook(@RequestBody Book book){

        Boolean flag = bookService.returnTheBook(book);

        System.out.println(flag);


    }

    @ResponseBody
    @RequestMapping("/adminReturn")
    //管理员确认归还图书
    public void adminReturn(@RequestBody Book book , HttpServletResponse response) throws IOException {

        String returnTimeDate = book.getReturnTime();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String format = sdf.format(new Date());

        Record record = new Record();

        record.setBookname(book.getName());
        record.setBookisbn(book.getIsbn());
        record.setBorrower(book.getBorrower());
        record.setBorrowtime(book.getBorrowTime());
        record.setRemandtime(format);

        recordMapper.insertRecord(record);

        System.out.println("record" + record);

        Boolean flag = bookService.adminReturnBook(book);

        if (flag){
            response.getWriter().write("success");
        }else {
            response.getWriter().write("fail");
        }

    }

    @ResponseBody
    @RequestMapping("/takenOffBook")
    //管理员下架图书单本
    public void takenOffBook(@RequestBody int[] ids , HttpServletResponse response) throws IOException {

        for (int id : ids) {
            System.out.println(id);
        }

        Integer i = bookService.takenOffBook(ids);

        if (i > 0){
            response.getWriter().write("success");
        }else {
            response.getWriter().write("fail");
        }


    }


















}
