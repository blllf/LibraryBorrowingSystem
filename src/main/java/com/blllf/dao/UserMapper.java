package com.blllf.dao;

import com.blllf.pojo.User;
import org.apache.ibatis.annotations.*;

public interface UserMapper {

    @Select("select * from user where user_email = #{email} and user_password = #{password} and user_status != '1'")
    @Results(id = "userMap" , value = {
            @Result(id = true , column = "user_id" , property = "id"),
            @Result(column = "user_name" , property = "name"),
            @Result(column = "user_email" , property = "email"),
            @Result(column = "user_password" , property = "password"),
            @Result(column = "user_status" , property = "status" ),
            @Result(column = "user_role" , property = "role")
    })
    User login(User user);


    @Insert("insert into user(user_name, user_password, user_email, user_role, user_status) " +
            "values (#{name} , #{password} , #{email} ,#{role} , #{status})  ")
    @ResultMap("userMap")
    Integer register(User user);




}
