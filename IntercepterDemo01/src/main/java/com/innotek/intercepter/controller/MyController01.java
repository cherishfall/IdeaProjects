package com.innotek.intercepter.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@RestController
public class MyController01 {

    @RequestMapping("/mycontroller01")
    String mycontroller01(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse){
        HttpSession session = httpServletRequest.getSession(true);

        String str = "this is mycontroller01";
        session.setAttribute("str", str);

        return str;
    }
}
