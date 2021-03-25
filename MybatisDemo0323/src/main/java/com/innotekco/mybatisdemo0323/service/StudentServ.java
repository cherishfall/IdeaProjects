package com.innotekco.mybatisdemo0323.service;

import com.innotekco.mybatisdemo0323.dao.IStudentDao;
import com.innotekco.mybatisdemo0323.entity.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudentServ {
    @Autowired
    IStudentDao iStudentDao;

    public List<Student> findAllStudent(){
        return iStudentDao.findAllStudent();
    }
}
