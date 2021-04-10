package com.innotek.securitydemo01;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Controller01 {
    @GetMapping("test01")
    public String test01(){
        return "test01";
    }
}
