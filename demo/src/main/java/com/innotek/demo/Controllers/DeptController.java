package com.innotek.demo.Controllers;

import com.innotek.demo.Department;
import com.innotek.demo.Services.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/Dept")
public class DeptController {
    @Autowired
    DepartmentService departmentService;

    @GetMapping("/findDept")
    String findDept(){
        return "/Dept/findDept";
    }

    @PostMapping("/findDept")
    @ResponseBody
    Department responseFindDept(String name){
       return departmentService.findByName(name);
    }

    @GetMapping("/addDept")
    String addDept(){
        return "Dept/addDept";
    }

    @PostMapping("addDept")
    @ResponseBody
    Department reponseAddDept(Department dept){
        departmentService.saveDepartment(dept);
        return departmentService.findByName(dept.getName());
    }

    @GetMapping("/deleteDept")
    String deleteDept(){
        return "Dept/deleteDept";
    }

    @PostMapping("/deleteDept")
    @ResponseBody
    Department responseDeleteDept(Integer id){
        departmentService.deleteDepartment(id);
        return departmentService.findById(id);
    }

    @GetMapping("/updateDept")
    String updateDept(Model model, Integer id){
        id = 1;
        Department dept = departmentService.findById(id);
        model.addAttribute("dept", dept);
        return "Dept/updateDept";
    }

    @PostMapping("/updateDept")
    @ResponseBody
    Department responseUpdateDept(Department dept){
        departmentService.updateDepartment(dept);
        return departmentService.findById(dept.getId());
    }



}
