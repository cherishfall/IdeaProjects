package com.innotek.layuidemo.controller;

import com.innotek.layuidemo.entity.Student;
import com.innotek.layuidemo.service.StudentServ;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class HomeController {
    @Autowired
    StudentServ studentServ;

//    @GetMapping("/")
    @RequestMapping("/")
    String home(){
        return "index";
    }

    @GetMapping("/mybatistest")
    @ResponseBody
    List<Student> mybatisTest(){
        return studentServ.findAllStudent();
    }

}
