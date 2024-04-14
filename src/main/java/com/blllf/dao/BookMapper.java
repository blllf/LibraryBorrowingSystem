package com.blllf.dao;

import com.blllf.pojo.Book;
import com.blllf.pojo.Record;
import com.github.pagehelper.Page;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface BookMapper {

    public Book findBookById2(Integer id);

    /*
    * 图书接口
    *
    * */


    @Select("select * from book where book_status != '3' ")
    @Results(id = "bookMap" , value = {
            //id字段默认为false，表示不是主键
            //column表示数据库表字段，property表示实体类属性名。
            @Result(id = true,column = "book_id",property = "id"),
            @Result(column = "book_name",property = "name"),
            @Result(column = "book_isbn",property = "isbn"),
            @Result(column = "book_press",property = "press"),
            @Result(column = "book_author",property = "author"),
            @Result(column = "book_pagination",property = "pagination"),
            @Result(column = "book_price",property = "price"),
            @Result(column = "book_uploadtime",property = "uploadTime"),
            @Result(column = "book_status",property = "status"),
            @Result(column = "book_borrower",property = "borrower"),
            @Result(column = "book_borrowtime",property = "borrowTime"),
            @Result(column = "book_returntime",property = "returnTime")
    })
    //返回值是Page类型的，是由PageHelper 分页插件中提供的，
    // Page继承了ArrayList ，可以作为集合存方对象，而且还封装了页码和页数的分页相关内容
    public Page<Book> selectNewBooks();



    @Select("select * from book where book_status in ('1' , '2') ")
    @ResultMap("bookMap")
    //查询status 是 1 的数据 ，该数据是已经被借阅的数据
    public Page<Book> selectByStatus();

    /**
     * 分页条件查询
     *
     * */

    //也是分页查询，不过是用的是分页查询工具，暂时在该查询模块不用
    public List<Book> selectBookB(Book book);


    //分页条件查询
    public List<Book> findBookByCondition(@Param("begin") int begin , @Param("size") int size , @Param("book") Book book);

    //分页条件查询，记录查询到数据所有的总数
    public int selectTotalByCount(Book book);


    /*
    * 2.借阅图书
    *
    * */

    @Select("select * from book where book_id = #{id};")
    @ResultMap("bookMap")
    Book findById(Integer id);

    //借阅图书，也是编辑图书
    Integer editBook(Book book);

    //查询所有课本
    @Select("select * from book")
    @ResultMap("bookMap")
    List<Book> selectBooks();

    //新增课本数据
    Integer insertBook(Book book);


    //归还书本
    @Update("update book set book_status = #{status} where book_id = #{id} ")
    @ResultMap("bookMap")
    Integer returnBook(Book book);


    //管理员确认归还图书
    @Update("update book set book_status = #{status} , book_borrower = #{borrower} , book_borrowtime = #{borrowTime} , book_returntime = #{returnTime}" +
            " where book_id = #{id} ")
    @ResultMap("bookMap")
    Integer adminReturn(Book book);


    //管理员下架图书多本
    Integer takenOffBooks(@Param("ids")int[] ids);









}
