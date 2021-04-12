package com.innotek.cookieandsessiondemo01.controller;

import com.innotek.cookieandsessiondemo01.entity.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class HomeController {

//    @GetMapping("/home")
    @RequestMapping(value = "/home", method = {RequestMethod.GET, RequestMethod.POST})
    String home(HttpServletRequest req, HttpServletResponse rep, Model model){
        HttpSession session = req.getSession(false);
        if(session == null) {
            return "login";
        } else{
            User user = (User) session.getAttribute("user");
            model.addAttribute("user", user);
            return "home";
        }



    }
}
