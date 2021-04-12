package com.innotek.cookieandsessiondemo02.dao;

import com.innotek.cookieandsessiondemo02.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface UserDao {
    User selectUserById(Integer id);
}
