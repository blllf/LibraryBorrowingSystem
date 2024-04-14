package com.blllf.service.impl;

import com.blllf.dao.RecordMapper;
import com.blllf.entity.PageResult;
import com.blllf.pojo.Book;
import com.blllf.pojo.Record;
import com.blllf.service.RecordService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class RecordServiceImpl implements RecordService {


    @Autowired
    private RecordMapper recordMapper;

    @Override
    public Integer insertRecord(Record record , Book book) {
        return null;
    }

    //查询归还记录的书本
    @Override
    public PageResult selectRecord(Integer pageNum, Integer pageSize) {

        PageHelper.startPage(pageNum , pageSize);

        Page<Record> records = recordMapper.selectRecord();


        return new PageResult(records.getTotal() , records.getResult());
    }
}
