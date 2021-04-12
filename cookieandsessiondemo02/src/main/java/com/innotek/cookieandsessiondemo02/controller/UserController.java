package com.innotek.cookieandsessiondemo02.controller;

import com.innotek.cookieandsessiondemo02.entity.User;
import com.innotek.cookieandsessiondemo02.service.UserServ;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserController {
    @Autowired
    UserServ userServ;

    @GetMapping("/user")
    User user(){
        return userServ.selectUserById(1);
    }
}
