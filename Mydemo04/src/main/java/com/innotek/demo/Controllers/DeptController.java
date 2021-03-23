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

import javax.persistence.criteria.CriteriaBuilder;
import java.util.List;

@Controller
@RequestMapping("/Dept")
public class DeptController {
    @Autowired
    DepartmentService departmentService;

    @GetMapping("/addDept")
    String addDept(){
        return "/Dept/addDept";
    }

    @PostMapping("/addDept")
//    @ResponseBody
    String reponseAddDept(Department dept){
        departmentService.saveDepartment(dept);
//        return departmentService.findByName(dept.getName());
        return "redirect:/dept";
    }

    @GetMapping("/findDept")
    String findDept(){
        return "/Dept/findDept";
    }

    @PostMapping("/findDept")
//    @ResponseBody
    String responseFindDept(Model model, String name){
        Department dept = departmentService.findByName(name);
        model.addAttribute("dept", dept);
        return "/Dept/findDeptResult";
    }

    @PostMapping("/findDeptJson")
//    @GetMapping("/findDeptJson")
    @ResponseBody
    Department responseFindDeptJson(String name){
        Department dept = null;
        dept = departmentService.findByName(name);
        return dept;
    }


    @GetMapping("/deleteDept")
    String deleteDept(){
        return "Dept/deleteDept";
    }

    @PostMapping("/deleteDept")
//    @ResponseBody
    String responseDeleteDept(Integer id){
        departmentService.deleteDepartment(id);
        return "redirect:/dept";
    }

//    @GetMapping("/deleteDeptJson")
    @PostMapping("/deleteDeptJson")
    @ResponseBody
    Integer responseDeleteDeptJson(Integer id){
//        Integer pid = Integer.valueOf(id);
        Integer fid = id;
        return departmentService.deleteDepartment(id);
    }

    @GetMapping("/updateDept")
    String updateDept(Model model, Integer id, Integer page_number, Integer per_page_number){
//        <input hidden type="number" name="page_number">
//        <input hidden type="number" name="per_page_number">
        Department dept = departmentService.findById(id);
        model.addAttribute("dept", dept);
        model.addAttribute("page_number", page_number);
        model.addAttribute("per_page_number", per_page_number);

        return "Dept/updateDept";
    }

    @PostMapping("/updateDept")
//    @ResponseBody
    String responseUpdateDept(Model model,Department dept, Integer page_number, Integer per_page_number){
        departmentService.updateDepartment(dept);
        Integer page_flag = 1;
        model.addAttribute("page_flag",page_flag);
        model.addAttribute("page_number", page_number);
        model.addAttribute("per_page_number", per_page_number);
        return "forward:/dept";
    }

}
