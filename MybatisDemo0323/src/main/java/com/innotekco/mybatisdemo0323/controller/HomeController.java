package com.innotekco.mybatisdemo0323.controller;

import com.innotekco.mybatisdemo0323.entity.Student;
import com.innotekco.mybatisdemo0323.service.StudentServ;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class HomeController {
    @Autowired
    StudentServ studentServ;

    @GetMapping("/")
    List<Student> home(){
        return studentServ.findAllStudent();
    }
}
