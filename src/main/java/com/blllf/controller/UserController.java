package com.blllf.controller;

import com.blllf.pojo.User;
import com.blllf.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 用户登录
     * 这个方法用了 数据绑定（绑定一个pojo对象） 返回值为String类型的页面跳转（这种方式需要视图解析器）
     * */

    @RequestMapping("/login")
    public String login(User user , HttpServletRequest request){

        User user1 = userService.login(user);

        if (user1 != null){
            request.getSession().setAttribute("user_session" , user1);
            return "redirect:/admin/main.jsp";
        }

        request.setAttribute("msg" , "用户名或密码错误");

        return "forward:/admin/login.jsp";

    }


    @RequestMapping("/logout")
    public String logout(){


        return "forward:/admin/login.jsp";
    }


    @RequestMapping("/register")
    public void register(@RequestBody User user , HttpServletResponse response) throws IOException {
        Integer register = userService.register(user);

        if (register > 0){
            System.out.println("成功");
            response.getWriter().write("success");
        }else {
            System.out.println("失败");
            response.getWriter().write("fail");
        }
    }
}
