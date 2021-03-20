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
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/EE")
public class EEController {
    @Autowired
    EmployeeService employeeService;

    @Autowired
    DepartmentService departmentService;

    @GetMapping("/addEE")
    String addEE(Model model, Integer dept_id, String dept_name ){
        model.addAttribute("dept_id", dept_id);
        model.addAttribute("dept_name", dept_name);
        return "/EE/addEE";
    }

    @PostMapping("/addEE")
//    @ResponseBody
    String responseAddEE(Model model, String dept_name, Employee ee){
        employeeService.saveEmployee(ee);

        Integer dept_id = ee.getDept_id();

//        Department dept = departmentService.findById(dept_id);
//        String dept_name = dept.getName();
        List<Employee> ees = employeeService.findByDeptId(dept_id);
        model.addAttribute("ees", ees);
        model.addAttribute("dept_id", dept_id);
        model.addAttribute("dept_name", dept_name);
        return "/ee";
    }


    @GetMapping("/findEE")
    String findEE(){
        return "EE/findEE";
    }

    @PostMapping("/findEE")
//    @ResponseBody
    String responseFindEE(Model model, String name){
        List<Employee> ees = employeeService.findByName(name);
        model.addAttribute("ees", ees);
        return "/EE/findEEResult";
    }



    @GetMapping("/deleteEE")
    String deleteEE(){
        return "EE/deleteEE";
    }

    @PostMapping("/deleteEE")
//    @ResponseBody
    String responseDeleteEE(Model model, String dept_name, Integer dept_id, Integer id){
        employeeService.deleteEmployee(id);
        List<Employee> ees = employeeService.findByDeptId(dept_id);
        model.addAttribute("ees", ees);
        model.addAttribute("dept_id", dept_id);
        model.addAttribute("dept_name", dept_name);
        return "/ee";
    }

    @GetMapping("/updateEE")
    String updateEE(Model model, String dept_name, Integer dept_id, Integer id){
        Employee ee = employeeService.findById(id);
        model.addAttribute("EE", ee);
        model.addAttribute("dept_name", dept_name);
        model.addAttribute("dept_id", dept_id);
        return "EE/updateEE";
    }

    @PostMapping("/updateEE")
//    @ResponseBody
    String reposnseUpdateEE(Model model, String dept_name,Employee ee){
        employeeService.updateEmployee(ee);
        Integer dept_id = ee.getDept_id();

//        Department dept = departmentService.findById(dept_id);
//        String dept_name = dept.getName();
        List<Employee> ees = employeeService.findByDeptId(dept_id);
        model.addAttribute("ees", ees);
        model.addAttribute("dept_id", dept_id);
        model.addAttribute("dept_name", dept_name);
        return "/ee";
    }


}
