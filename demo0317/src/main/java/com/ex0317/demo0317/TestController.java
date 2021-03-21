package com.ex0317.demo0317;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class TestController {
    @GetMapping("/test/test01")
    String test01(){
        return "/test/test01";
    }

    @PostMapping("/test/test01")
    void post_test01(String name, String sex, Integer age){
        String savename=name;
    }

}
