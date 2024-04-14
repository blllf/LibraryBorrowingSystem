package com.blllf.config;


import com.blllf.interceptor.ResourcesInterceptor;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.*;

@Configuration
//等同于<context:component-scan base-package="com.blllf.controller"/>
@ComponentScan("com.blllf.controller")
//等同于<mvc:annotation-driven/> 数据绑定，还不完全相同
//<mvc:annotation-driven/> 注解方式的类型转换依赖注解驱动的支持，配置文件必须显示定义这个元素
@EnableWebMvc
public class SpringMvcConfig implements WebMvcConfigurer {

    //等同于<mvc:resources mapping="/js/**" location="/js/"/>
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/js/**")
                .addResourceLocations("/js/");
    }

    //开启静态资源访问
    //放行与RequestMapping无关的静态资源
    @Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }

    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {

        registry.jsp("/admin",".jsp");
    }


    /**
     * 配置拦截器
     * 拦截器只针对Spring MVC的请求进行拦截
     * Filter 会对所有的请求进行拦截
     * */

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new ResourcesInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns("/css/**" , "/js/**", "/img/**");
    }
}
