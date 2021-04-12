package com.innotek.cookieandsessiondemo01.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class LogoutController {

    @GetMapping("/logout")
    String logoutGet(HttpServletRequest req, HttpServletResponse rep){
        return "logout";
    }

    @ResponseBody
    @PostMapping("/logout")
    String logout(HttpServletRequest req, HttpServletResponse rep){
        HttpSession session = req.getSession(false);
        if(session == null){
            ;
        }else {
            session.invalidate();
        }

        return "success";
    }
}
