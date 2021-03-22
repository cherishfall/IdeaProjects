package com.innotek.demo.Controllers;

import com.innotek.demo.Entity.DeptEE;
import com.innotek.demo.Services.DeptEESev;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class DeptEEController {
    @Autowired
    DeptEESev deptEESev;

    @PostMapping("/findEEByEEName")
    @GetMapping("/findEEByEEName")
    List<DeptEE> findEEByEEName(String name){
       return deptEESev.findEEByEEName(name);
    }

    @PostMapping("/findEEByEENameAndDeptName")
    @GetMapping("/findEEByEENameAndDeptName")
    List<DeptEE> findEEByEENameAndDeptName(String name, String dept_name){
        return deptEESev.findEEByEENameAndDeptName(name, dept_name);
    }

}
