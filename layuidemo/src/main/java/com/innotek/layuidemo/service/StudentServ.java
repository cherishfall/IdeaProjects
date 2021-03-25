package com.innotek.layuidemo.service;

import com.innotek.layuidemo.dao.IStudentDao;
import com.innotek.layuidemo.entity.Student;
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
