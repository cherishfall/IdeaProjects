package com.innotek.demo.Controllers;

import com.innotek.demo.Department;
import com.innotek.demo.Services.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Controller
//@RestController
//@RequestMapping("/dept")
public class DepartmentController {

    @Autowired
    DepartmentService departmentService;

    @GetMapping("/dept")
    public String dept(Model model){
        List<Department> depts = departmentService.findAll();
        model.addAttribute("depts",depts);
        return "/dept";
    }
}
