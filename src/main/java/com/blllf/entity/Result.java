package com.blllf.entity;

import java.io.Serializable;

/**
 * 便于将页面操作结果和提示信息一起响应给页面
 * 定义一个类，将页面操作结果和提示信息作为该类的属性
 * Controller层需要向页面传递信息时，将内容封装到该类对象中
 * */

//T 是一个泛型类型参数，它代表任意类型。
public class Result<T> implements Serializable {
    private boolean success; //标识是否成功操作
    private String message; //需要传递的信息
    private T data; //需要传递的数据

    public Result() {
    }

    public Result(boolean success, String message) {
        this.success = success;
        this.message = message;
    }

    public Result(boolean success, String message, T data) {
        this.success = success;
        this.message = message;
        this.data = data;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
