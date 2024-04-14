package com.blllf.config;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;

//@Configuration注解表示这是基于Java的配置方式。
@Configuration
//使用了@Import注解，用于导入其他配置类。
//这意味着MybatisConfig和JdbcConfig中定义的Bean将会被合并到当前配置类中，从而统一配置到同一个Spring容器中。
@Import({MybatisConfig.class, JdbcConfig.class})
	/*
	等同于<context:component-scan base-package="com.blllf.service">
	 */
@ComponentScan(value = "com.blllf.service")

/**
 * 开启事务注解
 * 相当于<tx:annotation-driven transaction-manager="transactionManager"/>
 * 用于开启事务管理的配置
 * */
@EnableTransactionManagement
/*将MyBatisConfig类和JdbcConfig类交给Spring管理 */
//这个配置类的作用是定义了Spring容器的配置信息，包括导入其他配置类、扫描指定包路径下的组件，并将它们注册到Spring容器中。
public class SpringConfig {

    //将事务管理器注册到Spring容器中
    @Bean("transactionManager")
    public DataSourceTransactionManager getDataSourceTxManager(@Autowired DataSource dataSource){
        DataSourceTransactionManager dtm = new DataSourceTransactionManager();
        //等同于<property name="dataSource" ref="dataSource"/>
        dtm.setDataSource(dataSource);
        return dtm;
    }
}
