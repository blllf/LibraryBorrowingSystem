package com.blllf.config;

import com.github.pagehelper.PageInterceptor;
import org.apache.ibatis.plugin.Interceptor;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.mapper.MapperScannerConfigurer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;

import javax.sql.DataSource;
import java.util.Properties;

public class MybatisConfig {
    /*
    定义MyBatis的核心连接工厂bean，
    等同于<bean class="org.mybatis.spring.SqlSessionFactoryBean">
     参数使用自动装配的形式加载dataSource，
    为set注入提供数据源，dataSource来源于JdbcConfig中的配置
     */

    /*配置分页插件*/
    @Bean
    public PageInterceptor getPageInterceptor(){
        PageInterceptor pageInterceptor = new PageInterceptor();
        Properties properties = new Properties();
        //配置分页的合理化数据
        properties.setProperty("value" , "true");
        pageInterceptor.setProperties(properties);


        return pageInterceptor ;
    }


    @Bean
    public SqlSessionFactoryBean getSqlSessionFactoryBean(@Autowired DataSource dataSource,
                                                          @Autowired PageInterceptor pageInterceptor){

        SqlSessionFactoryBean ssfb = new SqlSessionFactoryBean();
        //等同于<property name="dataSource" ref="dataSource"/>
        ssfb.setDataSource(dataSource);
        Interceptor[] plugins = {pageInterceptor};
        //将拦截器设置到sqlSessionFactroy中
        ssfb.setPlugins(plugins);
        return ssfb;
    }

    /*
    定义MyBatis的映射扫描，
    等同于<bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
     */
    @Bean
    public MapperScannerConfigurer getMapperScannerConfigurer() {
        MapperScannerConfigurer msc = new MapperScannerConfigurer();
        //等同于<property name="basePackage" value="com.blllf.dao"/>
        msc.setBasePackage("com.blllf.dao");
        return msc;
    }
}
