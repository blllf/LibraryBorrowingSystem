package com.blllf.config;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

//该注解会在容器启动的时候会将EncodingFilter.java 过滤器加载到程序中
@WebFilter(filterName = "encodingFilter",urlPatterns = "/*")
public class EncodingFilter  implements Filter {
    @Override
    public void init(FilterConfig filterConfig) {}
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        servletRequest.setCharacterEncoding("UTF-8");
        servletResponse.setCharacterEncoding("UTF-8");
        filterChain.doFilter(servletRequest,servletResponse);
    }
    @Override
    public void destroy() {}
}
