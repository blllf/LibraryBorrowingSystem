package com.blllf.service;

import com.blllf.pojo.User;

public interface UserService {

    /**
     *用户登录接口
     */
    public User login(User user);


    public Integer register(User user);
}
