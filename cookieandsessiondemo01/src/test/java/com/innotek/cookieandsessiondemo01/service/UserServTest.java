package com.innotek.cookieandsessiondemo01.service;

import com.innotek.cookieandsessiondemo01.entity.User;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class UserServTest {
    @Autowired
    UserServ userServ;

    @Test
    void selectById() {
        User u1 = userServ.selectById(1);
        System.out.println(u1);
    }

    void selectUserBy() {}

}