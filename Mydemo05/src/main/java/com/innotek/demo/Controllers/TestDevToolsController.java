package com.innotek.demo.Controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/testdevtools")
public class TestDevToolsController {

    @GetMapping
    public String testDevTools(){
        return "222";
    }
}
