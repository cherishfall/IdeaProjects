package com.innotekco.mybatisdemo0323.dao;

import com.innotekco.mybatisdemo0323.entity.Student;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface IStudentDao {

    List<Student> findAllStudent();

}
