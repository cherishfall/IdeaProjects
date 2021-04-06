package com.innotek.innotekdemo02.controller;

import com.innotek.innotekdemo02.entity.Department;
import com.innotek.innotekdemo02.entity.DepartmentExt;
import com.innotek.innotekdemo02.entity.Employee;
import com.innotek.innotekdemo02.entity.EmployeeExt;
import com.innotek.innotekdemo02.service.DepartmentServ;
import com.innotek.innotekdemo02.service.EmploymentServ;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class TestMybatis {

    //以下为测试Department部分
    @Autowired
    DepartmentServ deptServ;

    //ok
    @GetMapping("/selectDepartmentById")
    Department selectDepartmentById(Integer id){
        return deptServ.selectDepartmentById(id);
    }

    //ok
    @GetMapping("/selectDepartmentExtById")
    DepartmentExt selectDepartmentExtById(Integer id){
        return deptServ.selectDepartmentExtById(id);
    }

    //ok
    @GetMapping("/selectAllDepartment")
    List<Department> selectAllDepartment(){
        return deptServ.selectAllDepartment();
    }

    //ok
    @GetMapping("/selectAllCode")
    List<String> selectAllCode(){
        return deptServ.selectAllCode();
    }

    //ok
    @GetMapping("/selectAllId")
    List<Integer> selectAllId(){
        return deptServ.selectAllId();
    }

    //ok
    //有级联删除
    @GetMapping("/deleteDepartmentById")
    int deleteDepartmentById(Integer id){
        return deptServ.deleteDepartmentById(id);
    }


    //ok
    //返回部门id，返回0表示插入失败
    @GetMapping("/insertDepartment")
    int insertDepartment(Department dept){
        deptServ.insertDepartment(dept);
        return dept.getId();
    }

    //ok
    //有级联插入
    //返回部门id，返回0表示插入失败
    @GetMapping("/insertDeptAndEE")
    int insertDeptAndEE(Department dept, List<Employee> ees){
        return deptServ.insertDeptAndEE(dept, ees);
    }

    //ok
    @PostMapping ("/insertDeptAndEEV2")
    int insertDeptAndEEV2(@RequestBody DepartmentExt deptExt){
        return deptServ.insertDeptAndEEV2(deptExt);
    }

    //ok
    @GetMapping("/updateDepartment")
    int updateDepartment(Department dept){
        int tmp = deptServ.updateDepartment(dept);
        System.out.println('1');
        return tmp;
//        return deptServ.updateDepartment(dept);
    }




    //以下测试ee
    @Autowired
    EmploymentServ eeServ;

    //ok
    @GetMapping("/selectEmployeeById")
    Employee selectEmployeeById(Integer id){
        Employee ee = eeServ.selectEmployeeById(id);
        return ee;

//        return eeServ.selectEmployeeById(id);
    }

    //ok
    @GetMapping("/selectEmployeeExtById")
    EmployeeExt selectEmployeeExtById(Integer id){
        return eeServ.selectEmployeeExtById(id);
    }
    //ok
    @GetMapping("/selectEmployeeByDeptId")
    List<Employee> selectEmployeeByDeptId(Integer deptId){
        return eeServ.selectEmployeeByDeptId(deptId);
    }

    //ok
    @GetMapping("/selectEmployeeExtByDeptId")
    List<EmployeeExt> selectEmployeeExtByDeptId(Integer deptId){
        return eeServ.selectEmployeeExtByDeptId(deptId);
    }

    //ok
    @GetMapping("/selectAllEmployee")
    List<Employee> selectAllEmployee(){
        return eeServ.selectAllEmployee();
    }

    //ok
    @GetMapping("/selectAllEmployeeExt")
    List<EmployeeExt> selectAllEmployeeExt(){
        return eeServ.selectAllEmployeeExt();
    }

    //ok
    @GetMapping("/selectAllAccount")
    List<String> selectAllAccount(){
        return eeServ.selectAllAccount();
    }

    //ok
    @GetMapping("/deleteEmployeeById")
    int deleteEmployeeById(Integer id){
        return eeServ.deleteEmployeeById(id);
    }

    //0k
    @GetMapping("/deleteEmployeeByDeptId")
    int deleteEmployeeByDeptId(Integer deptId){
        return eeServ.deleteEmployeeByDeptId(deptId);
    }

    //ok
    @GetMapping("/updateEmployee")
    int updateEmployee(Employee ee){
        return eeServ.updateEmployee(ee);
    }


    //ok
    //返回员工id，返回0插入失败
    @GetMapping("/insertEmployee")
    int insertEmployee(Employee ee){
        return eeServ.insertEmployee(ee);
    }




}
