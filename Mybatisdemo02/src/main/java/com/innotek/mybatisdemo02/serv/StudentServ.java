package com.innotek.mybatisdemo02.serv;

import com.innotek.mybatisdemo02.dao.IStudentDao;
import com.innotek.mybatisdemo02.entity.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Service
public class StudentServ {
    @Autowired
    IStudentDao iStudentDao;

    public Student selectStudentById(int id){
        return iStudentDao.selectStudentById(id);
    }

    public List<Student> selectStudentByClazzId(int clazz_id){
        return iStudentDao.selectStudentByClazzId(clazz_id);
    }
}
