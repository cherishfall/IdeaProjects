package com.innotek.cookieandsessiondemo02.service;

import com.innotek.cookieandsessiondemo02.dao.UserDao;
import com.innotek.cookieandsessiondemo02.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServ {
    @Autowired
    UserDao userDao;

    public User selectUserById(Integer id){
        return userDao.selectUserById(id);
    }
}
