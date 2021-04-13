package com.innotek.intercepter.config;

import com.innotek.intercepter.filter.MyFilter01;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class FilterConfig {

    @Bean
    public FilterRegistrationBean myFilter01(){
        FilterRegistrationBean registrationBean = new FilterRegistrationBean(new MyFilter01());
        registrationBean.addUrlPatterns("/*");
        return registrationBean;
    }

}
