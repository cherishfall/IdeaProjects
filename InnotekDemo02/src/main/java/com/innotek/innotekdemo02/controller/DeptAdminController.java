package com.innotek.innotekdemo02.controller;

import com.innotek.innotekdemo02.entity.Department;
import com.innotek.innotekdemo02.service.DepartmentServ;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class DeptAdminController {
    @Autowired
    DepartmentServ deptServ;

    @GetMapping("/deptadmin")
    String deptAdmin(Model model){
        List<Department> deptList = deptServ.selectAllDepartment();
        model.addAttribute("deptList",deptList);
        return "deptadmin";
    }
}
