package com.blllf.config;


/*
等同于
<context:property-placeholder location="classpath*:jdbc.properties"/>
 */

import com.alibaba.druid.pool.DruidDataSource;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.PropertySource;

@PropertySource("classpath:jdbc.properties")
public class JdbcConfig {

    @Value("${jdbc.driverClassName}")
    private String driver ;
    @Value("${jdbc.url}")
    private String url;
    @Value("${jdbc.username}")
    private String username;
    @Value("${jdbc.password}")
    private String password;

    /*定义dataSource的bean， 等同于
   <bean id="dataSource" class="com.alibaba.druid.pool.DruidDataSource">
    */

    @Bean("dataSource")
    public DruidDataSource getDataSource(){
        DruidDataSource dds = new DruidDataSource();

        //等同于set属性注入<property name="driverClassName" value="driver"/>

        dds.setDriverClassName(driver);
        dds.setUrl(url);
        dds.setUsername(username);
        dds.setPassword(password);

        return dds;
    }
}
