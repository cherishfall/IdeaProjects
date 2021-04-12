package com.innotek.cookieandsessiondemo01.controller;

import com.innotek.cookieandsessiondemo01.entity.User;
import com.innotek.cookieandsessiondemo01.service.UserServ;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class LoginController {
    @Autowired
    UserServ userServ;

    @GetMapping("/login")
    String login(HttpServletRequest req, HttpServletResponse rep){
        HttpSession session = req.getSession(false);
        if(session == null){
            return "login";
        }else {
            return "redirect:home";
        }
    }

    @PostMapping("/login")
    String loginCheck(HttpServletRequest req, HttpServletResponse rep,
                      String account, String pwd){

            User u1 = userServ.selectUserByAccount(account);
//        String upwd = u1.getPwd();
//        System.out.println(pwd == upwd); 不能这么比， == 比较的是对象的引用实例
            if(u1 != null && u1.getPwd().equals(pwd)){
                HttpSession session = req.getSession(true);
                session.setAttribute("user", u1);
//            req.setAttribute("user", u1);
                return "redirect:home";
            }else {
                return "loginerror";
            }




    }


}
