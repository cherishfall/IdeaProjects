package com.innotek.intercepter.config;

import com.innotek.intercepter.intercepter.MyInterpreter01;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
    @Autowired
    MyInterpreter01 myInterpreter01;

    @Override
    public void addInterceptors(InterceptorRegistry registry){
        registry.addInterceptor(myInterpreter01).addPathPatterns("/*");

    }
}
