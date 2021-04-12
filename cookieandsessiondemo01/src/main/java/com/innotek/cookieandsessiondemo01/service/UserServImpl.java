package com.innotek.cookieandsessiondemo01.service;

import com.innotek.cookieandsessiondemo01.dao.UserDao;
import com.innotek.cookieandsessiondemo01.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServImpl implements UserServ{

    @Autowired
    UserDao userDao;

    @Override
    public User selectById(Integer id){
        return userDao.selectById(id);
    }

    @Override
    public User selectUserByAccount(String accout) {
        return userDao.selectUserByAccount(accout);
    }
}
