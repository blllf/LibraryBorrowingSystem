package com.blllf.service;

import com.blllf.entity.PageResult;
import com.blllf.pojo.Book;
import com.blllf.pojo.Record;

public interface RecordService {

    public Integer insertRecord(Record record , Book book);

    public PageResult selectRecord(Integer pageNum , Integer pageSize);



}
