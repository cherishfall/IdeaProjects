package com.innotek.mybatisdemo01.dao;

import com.innotek.mybatisdemo01.entity.Person;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface IPersonDao {
    Person selectPersonById(int id);
}
