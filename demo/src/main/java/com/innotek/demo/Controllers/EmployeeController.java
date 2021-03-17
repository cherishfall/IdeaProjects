package com.innotek.demo.Controllers;

import com.innotek.demo.Employee;
import com.innotek.demo.Services.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

//@Controller
@RestController
@RequestMapping("/ee")
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    @GetMapping
    List<Employee> ee(){
        return employeeService.findAll();
    }

    
}
