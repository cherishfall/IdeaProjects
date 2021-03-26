package com.innotek.mybatisdemo03.serv;

import com.innotek.mybatisdemo03.dao.IUserDao;
import com.innotek.mybatisdemo03.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServ {
    @Autowired
    IUserDao iUserDao;

    public User selectUserById(int id){
        return iUserDao.selectUserById(id);
    }
}
