package com.innotek.innotekdemo02.controller;

import com.innotek.innotekdemo02.entity.Department;
import com.innotek.innotekdemo02.entity.Employee;
import com.innotek.innotekdemo02.entity.EmployeeExt;
import com.innotek.innotekdemo02.service.DepartmentServ;
import com.innotek.innotekdemo02.service.EmploymentServ;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import javax.websocket.server.PathParam;
import java.util.ArrayList;
import java.util.List;

@Controller
public class EEAdminController {
    @Autowired
    DepartmentServ deptServ;

    @Autowired
    EmploymentServ eeServ;

    @GetMapping("/eeadmin/{deptId}")
    String eeAdmin(Model model, @PathVariable(value =  "deptId") Integer deptId){
        model.addAttribute("deptId", deptId);

        List<Department> deptList = deptServ.selectAllDepartment();
        model.addAttribute("deptList", deptList);

        List<Employee> eeList;
        if(deptId == 0){
            eeList = eeServ.selectAllEmployee();
        }else {
            eeList = eeServ.selectEmployeeByDeptId(deptId);
        }
        model.addAttribute("eeList", eeList);

        return "eeadmin";
    }

}
