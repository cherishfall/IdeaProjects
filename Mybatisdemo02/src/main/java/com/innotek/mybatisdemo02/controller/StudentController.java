package com.innotek.mybatisdemo02.controller;

import com.innotek.mybatisdemo02.entity.Student;
import com.innotek.mybatisdemo02.serv.StudentServ;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class StudentController {
    @Autowired
    StudentServ studentServ;

    @GetMapping("/student")
    public Student student(int id){
        return studentServ.selectStudentById(id);
    }

    @GetMapping("/studentbyclazzid")
    public List<Student> studentByClazzId(int clazz_id){
        return studentServ.selectStudentByClazzId(clazz_id);
    }
}
