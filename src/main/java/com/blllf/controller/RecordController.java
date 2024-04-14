package com.blllf.controller;


import com.blllf.dao.RecordMapper;
import com.blllf.entity.PageResult;
import com.blllf.pojo.Record;
import com.blllf.service.RecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Controller
public class RecordController {

    @Autowired
    private RecordService recordService;

    @Autowired
    private RecordMapper recordMapper;


    @ResponseBody
    @RequestMapping("/selectRecord")
    public PageResult selectRecord(Integer pageNum , Integer pageSize){

        PageResult pageResult = recordService.selectRecord(pageNum, pageSize);

        return pageResult;

    }


    @ResponseBody
    @RequestMapping("/selectByBorrower")
    public List<Record> selectByBorrower(@RequestBody Record record){

        List<Record> records = recordMapper.selectByBorrower(record);

        return records;

    }

    //删除一条数据
    @ResponseBody
    @RequestMapping("/deleteById")
    public void deleteById(int id , HttpServletResponse response) throws IOException {

        Integer i = recordMapper.deleteById(id);

        if (i > 0){

            response.getWriter().write("success");

            System.out.println("成功");
        }else {
            System.out.println("失败");
        }
    }



}
