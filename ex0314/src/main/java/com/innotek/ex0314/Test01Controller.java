package com.innotek.ex0314;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Controller
@RequestMapping("/test01")
public class Test01Controller {
    @GetMapping
    public String test01Index(){
        return "test01";
    }
    @GetMapping("/myname")
    public String getMyName(){
        return "lifan";
    }
}
