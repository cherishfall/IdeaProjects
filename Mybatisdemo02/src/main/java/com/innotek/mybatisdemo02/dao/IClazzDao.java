package com.innotek.mybatisdemo02.dao;

import com.innotek.mybatisdemo02.entity.Clazz;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface IClazzDao {
    Clazz selectClazzById(int id);
}
