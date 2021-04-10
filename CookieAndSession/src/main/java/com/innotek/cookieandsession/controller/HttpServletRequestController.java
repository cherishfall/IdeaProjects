package com.innotek.cookieandsession.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Vector;

@Controller
public class HttpServletRequestController {



    @GetMapping("/httpservletrequest00")
    @ResponseBody
    String httpServletRequest(HttpServletRequest req, HttpServletResponse rep, Model model){

        String uri = req.getRequestURI();
        StringBuffer url = req.getRequestURL();
        String remoteAddr = req.getRemoteAddr();
        String remoteHost = req.getRemoteHost();

        return "uri:" + uri +
                "&url: "+url +
                "&remoteAddr: " + remoteAddr +
                "&remoteHost: " + remoteHost;

    }

    @GetMapping("/httpservletrequest01")
    @ResponseBody
    String httpservletrequest01(HttpServletRequest req, HttpServletResponse rep, Model model){
        String userAgent = req.getHeader("User-Agent");
        String connection = req.getHeader("Connection");
        String lifan = req.getHeader("lifan");



        return "User-Agent: " + userAgent+
                " & Connection: " + connection+
                " & lifan: " + lifan;
    }

    @GetMapping("httpservletrequest02")
    @ResponseBody
    String httpservletrequest02(HttpServletRequest req, HttpServletResponse rep, Model model){
        String name = req.getParameter("name");
        String age = req.getParameter("age");
        String sex = req.getParameter("sex");

        return "get: "+name + age + sex;

    }

    @PostMapping("/httpservletrequest02")
    @ResponseBody String httpservletrequest02post(HttpServletRequest req, HttpServletResponse rep, Model model){
        String name = req.getParameter("name");
        String age = req.getParameter("age");
        String sex = req.getParameter("sex");

        return "post: "+name + age + sex;
    }

    @GetMapping("/httpservletrequest03")
    String httpservletrequest03(HttpServletRequest req, HttpServletResponse rep){
        List<String> mylist = new ArrayList<>();
        mylist.add("lifan");
        mylist.add("lilifan");
        mylist.add("lifanfan");
        req.setAttribute("mylist", mylist);
        return "forward:/httpservletrequest03_1";
    }

    @GetMapping("/httpservletrequest03_1")
    @ResponseBody String httpservletrequest03_1(HttpServletRequest req, HttpServletResponse rep){
        List<String> mylist= (List<String>)req.getAttribute("mylist");

        return mylist.toString();
    }

    @GetMapping("/httpservletrequest04")
    String httpservletrequest04(HttpServletRequest req, HttpServletResponse rep){
        Cookie[] cookies = req.getCookies();
        if(cookies != null){
            for (Cookie cookie: cookies){
                String key = cookie.getName();
                String value = cookie.getValue();
                System.out.println( key + ":" + value);
                cookie.setValue("1");
                rep.addCookie(cookie);
            }
        }


        Cookie c1 = new Cookie("lifan", "woshilifan");
        rep.addCookie(c1);

        Cookie c2 = new Cookie("httponly", "yeshttponly");
        c2.setHttpOnly(true);
        rep.addCookie(c2);

        Cookie c3 = new Cookie("nohttponly", "nohttponly");
        c3.setHttpOnly(false);
        rep.addCookie(c3);

        return "/httpservletrequest04";
    }

    @GetMapping("httpservletrequest05")
    String httpservletrequest05(HttpServletRequest req, HttpServletResponse rep){
        HttpSession se1 = req.getSession(false);
        if(se1 != null){
            System.out.println(se1.getId());
        }

        return "httpservletrequest05";
    }

    @GetMapping("/httpservletrequest06")
    @ResponseBody
    String httpservletrequest06(HttpServletRequest req, HttpServletResponse rep){
        HttpSession hs = req.getSession();
        List<String> list = new ArrayList<>();
        list.add("lifan");
        list.add("lilifan");
        list.add("lifanfan");
        hs.setAttribute("list", list);
        Cookie cc = new Cookie("httpservletrequest06", "lilili");
        rep.addCookie(cc);
        return list.toString();
    }

    @GetMapping("/httpservletrequest07")
    @ResponseBody
    String httpservletrequest07(HttpServletRequest req, HttpServletResponse rep){
        HttpSession hs = req.getSession(false);
        List<String> list = new ArrayList<>();
        if(hs != null){
            list = (List<String>) hs.getAttribute("list");
        }
        return list.toString();
    }

    @GetMapping("/httpservletrequest08")
    @ResponseBody
    void httpservletrequest08(HttpServletRequest req, HttpServletResponse rep){
        rep.setHeader("Location","http://www.baidu.com" );
        rep.setStatus(302);


    }

    @GetMapping("/httpservletrequest09")
    @ResponseBody
    void httpservletrequest09(HttpServletRequest req, HttpServletResponse rep){
        try {
            rep.sendRedirect("http://www.sina.com.cn");
        }catch (Exception e){
            e.printStackTrace();
        }

    }












}
