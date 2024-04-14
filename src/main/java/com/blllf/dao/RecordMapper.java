package com.blllf.dao;

import com.blllf.pojo.Record;
import com.github.pagehelper.Page;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface RecordMapper {


    @Insert("insert into record(record_id, record_bookname, record_bookisbn, record_borrower, record_borrowtime, record_remandtime)" +
            " values(#{id} , #{bookname} , #{bookisbn} , #{borrower} , #{borrowtime} ,#{remandtime} ) ")
    //添加借阅记录
    Integer insertRecord(Record record);


    @Select("select * from record")
    @Results(id = "recordMap" , value={
            @Result(id = true,column = "record_id",property = "id"),
            @Result(column = "record_bookname",property = "bookname"),
            @Result(column = "record_bookisbn",property = "bookisbn"),
            @Result(column = "record_borrower",property = "borrower"),
            @Result(column = "record_borrowtime",property = "borrowtime"),
            @Result(column = "record_remandtime",property = "remandtime")
    })
    Page<Record> selectRecord();


    List<Record> selectByBorrower(Record record);


    //删除记录
    @Delete("delete from record where record_id = #{id}")
    Integer deleteById(Integer id);


}
