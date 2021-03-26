package com.innotek.mybatisdemo02.dao;

import com.innotek.mybatisdemo02.entity.Clazz;
import com.innotek.mybatisdemo02.entity.Student;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface IStudentDao {
    Student selectStudentById(int id);
    List<Student> selectStudentByClazzId(int clazz_id);
}
