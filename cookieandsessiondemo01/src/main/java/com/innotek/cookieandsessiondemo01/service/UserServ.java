package com.innotek.cookieandsessiondemo01.service;

import com.innotek.cookieandsessiondemo01.entity.User;
import org.springframework.stereotype.Service;

public interface UserServ {
    User selectById(Integer id);

    User selectUserByAccount(String accout);
}
