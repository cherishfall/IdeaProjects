package com.innotek.demo.Controllers;

import com.innotek.demo.Department;
import com.innotek.demo.Employee;
import com.innotek.demo.Services.DepartmentService;
import com.innotek.demo.Services.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
//@RestController
//@RequestMapping("/ee")
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;
    @Autowired
    DepartmentService departmentService;

    @GetMapping("/ee")
    String ee(Model model, String dept_name, Integer dept_id){
        List<Employee> ees = employeeService.findByDeptId(dept_id);
        model.addAttribute("ees", ees);
        model.addAttribute("dept_id", dept_id);
        model.addAttribute("dept_name", dept_name);
        return "/ee";
    }

    @PostMapping("/ee")
    String ee(Model model){

        Employee ee = (Employee) model.getAttribute("ee");
        Integer dept_id = ee.getDept_id();
        Department dept = departmentService.findById(dept_id);
        String dept_name = dept.getName();

        List<Employee> ees = employeeService.findByDeptId(dept_id);
        model.addAttribute("ees", ees);
        model.addAttribute("dept_id", dept_id);
        model.addAttribute("dept_name", dept_name);
        return "/ee";
    }

    
}
