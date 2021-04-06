package com.innotek.innotekdemo02.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    String index(){
        return "index";
    }

    @GetMapping("/home")
    String home(){
        return "home";
    }
}
