package com.innotek.mybatisdemo03.controller;

import com.innotek.mybatisdemo03.entity.User;
import com.innotek.mybatisdemo03.serv.UserServ;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserController {
    @Autowired
    UserServ userServ;

    @GetMapping("/user")
    public User user(int id){
        return userServ.selectUserById(id);
    }

}
