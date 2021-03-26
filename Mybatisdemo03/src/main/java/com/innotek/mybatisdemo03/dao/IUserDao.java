package com.innotek.mybatisdemo03.dao;

import com.innotek.mybatisdemo03.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface IUserDao {
    public User selectUserById(int id);
}
