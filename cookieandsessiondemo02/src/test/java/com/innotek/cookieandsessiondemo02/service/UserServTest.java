package com.innotek.cookieandsessiondemo02.service;

import com.innotek.cookieandsessiondemo02.entity.User;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class UserServTest {
    @Autowired
    UserServ userServ;

    @Test
    void selectUserById() {
        Integer id = 1;
        User u1 = userServ.selectUserById(id);

        System.out.println(u1);
    }
}