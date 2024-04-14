package com.blllf.service.impl;

import com.blllf.dao.UserMapper;
import com.blllf.pojo.User;
import com.blllf.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    //注入UserMapper对象
    @Autowired
    private UserMapper userMapper;
    @Override
    public User login(User user) {
        return userMapper.login(user);
    }

    @Override
    public Integer register(User user) {

        String role = user.getRole();
        role = "USER";

        String status = user.getStatus();
        status = "0";

        user.setRole(role);
        user.setStatus(status);

        Integer register = userMapper.register(user);

        return register;
    }
}
