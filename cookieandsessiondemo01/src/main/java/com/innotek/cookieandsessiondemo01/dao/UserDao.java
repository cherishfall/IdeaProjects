package com.innotek.cookieandsessiondemo01.dao;

import com.innotek.cookieandsessiondemo01.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface UserDao {

//    @Select("select * from user where id=#{id}")
    User selectById(Integer id);

    User selectUserByAccount(String accout);


}
