package com.innotek.demo.Controllers;

import com.innotek.demo.Department;
import com.innotek.demo.Services.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

//@Controller
@RestController
@RequestMapping("/dept")
public class DepartmentController {

    @Autowired
    DepartmentService departmentService;

    @GetMapping
    public List<Department> dept(){
//        return new String[]{"lifan", "lijiaojiao"};
        return departmentService.findAll();
    }
}
