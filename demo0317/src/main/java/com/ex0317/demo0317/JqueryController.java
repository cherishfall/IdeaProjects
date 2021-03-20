package com.ex0317.demo0317;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class JqueryController {

    @GetMapping("/jqueryhome")
    String jqueryhome(Model model){
        model.addAttribute("str", "thymeleaf 已经启用");
        return "/jqueryhome";
    }

    @GetMapping("jquery/jq01")
    String jq01(Model model){
        model.addAttribute("str", "thymeleaf 启用");
        return "/jquery/jq01";
    }

    @GetMapping("jquery/jq02")
    String jq02(){
        return "/jquery/jq02";
    }
}
