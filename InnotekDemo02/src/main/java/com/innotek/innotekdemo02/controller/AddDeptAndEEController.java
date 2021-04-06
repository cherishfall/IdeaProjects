package com.innotek.innotekdemo02.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AddDeptAndEEController {
    @GetMapping("addDeptAndEE")
    String addDeptAndEE(){
        return "/addDeptAndEE";
    }
}
