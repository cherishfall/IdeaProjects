package com.innotek.demo.Controllers;

import com.innotek.demo.Employee;
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

    @GetMapping("/findEE")
    String findEE(){
        return "EE/findEE";
    }

    @PostMapping("/findEE")
    @ResponseBody
    List<Employee> responseFindEE(String name){
        return employeeService.findByName(name);
    }

    @GetMapping("/addEE")
    String addEE(){
        return "EE/addEE";
    }

    @PostMapping("/addEE")
    @ResponseBody
    List<Employee> responseAddEE(Employee ee){
        employeeService.saveEmployee(ee);
        return employeeService.findByName(ee.getName());
    }

    @GetMapping("/deleteEE")
    String deleteEE(){
        return "EE/deleteEE";
    }

    @PostMapping("/deleteEE")
    @ResponseBody
    Employee responseDeleteEE(Integer id){
        employeeService.deleteEmployee(id);
        return employeeService.findById(id);
    }

    @GetMapping("/updateEE")
    String updateEE(Model model, Integer id){
        id = 2;
        Employee ee = employeeService.findById(id);
        model.addAttribute("EE", ee);
        return "EE/updateEE";
    }

    @PostMapping("/updateEE")
    @ResponseBody
    Employee reposnseUpdateEE(Employee ee){
        employeeService.updateEmployee(ee);
        return employeeService.findById(ee.getId());
    }


}
