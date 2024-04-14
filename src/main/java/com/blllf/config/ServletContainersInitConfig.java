package com.blllf.config;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

//AACDSI 类是Spring提供的一个抽象类，任意继承该类的类都会在项目启动的时候自动配置DispatcherServlet,初始化Spring容器和SpringMVC容器
public class ServletContainersInitConfig
        extends AbstractAnnotationConfigDispatcherServletInitializer {

    /**
     * 加载Spring配置类中的信息，
     * 初始化Spring容器
     * */
    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class[]{SpringConfig.class};
    }

    /**
     * 加载Spring MVC配置类中的信息，
     * 初始化Spring MVC容器
     * */

    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[]{SpringMvcConfig.class};
    }


    //配置DispatcherServlet的映射路径
    @Override
    protected String[] getServletMappings() {
        return new String[]{"/"};
    }
}
