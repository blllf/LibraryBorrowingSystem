package com.blllf.interceptor;

import com.blllf.pojo.User;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ResourcesInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        User user = (User) request.getSession().getAttribute("user_session");

        String uri = request.getRequestURI();

        //如果用户是已登录状态放行
        if (user != null){
            return true;
        }

        if (uri.contains("login") || uri.contains("register")){
            return true;
        }

        /*if (!(uri.isEmpty())){
            return true;
        }*/

        //其他情况都直接跳转到登录界面
        request.setAttribute("msg" , "您还没登录，请先登录！");
        request.getRequestDispatcher("/admin/login.jsp").forward(request,response);

        return false;
    }
}
