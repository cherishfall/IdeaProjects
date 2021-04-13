package com.innotek.intercepter.filter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

//过滤器的生命周期和spirng容器是一样的
//@WebFilter(filterName = "myfilter01", urlPatterns = {"/*"})
public class MyFilter01 implements Filter {
    Logger logger = LoggerFactory.getLogger(MyFilter01.class);

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        logger.info("log 过滤器 初始化");
        System.out.println("----------------- 过滤器 初始化 -----------------");
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,
                         FilterChain chain) throws IOException, ServletException{
        logger.info("log 过滤器 请求处理");
        System.out.println("----------------- 过滤器 请求处理 -----------------");

        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        if(request.getCookies() != null){//这里可以换成session校验，当没有cookie的时候，返回的是null，不是空数组对象
            chain.doFilter(request, response);
        } else {
//            response.setStatus(302);
//            response.setHeader("Location", "http://www.baidu.com");

            response.sendRedirect("http://www.baidu.com");

        }
    }


    @Override
    public void destroy() {
        logger.info("log 过滤器 销毁");
        System.out.println("----------------- 过滤器 销毁 -----------------");

    }


}
