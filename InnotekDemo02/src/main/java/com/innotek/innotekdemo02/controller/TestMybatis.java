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
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class TestMybatis {

    //以下为测试Department部分
    @Autowired
    DepartmentServ deptServ;

    //ok
    @GetMapping("selectDepartmentById")
    Department selectDepartmentById(Integer id){
        return deptServ.selectDepartmentById(id);
    }

    //ok
    @GetMapping("selectDepartmentExtById")
    DepartmentExt selectDepartmentExtById(Integer id){
        return deptServ.selectDepartmentExtById(id);
    }

    //ok
    @GetMapping("selectAllDepartment")
    List<Department> selectAllDepartment(){
        return deptServ.selectAllDepartment();
    }

    //ok
    @GetMapping("selectAllCode")
    List<String> selectAllCode(){
        return deptServ.selectAllCode();
    }

    //ok
    @GetMapping("selectAllId")
    List<Integer> selectAllId(){
        return deptServ.selectAllId();
    }

    //ok
    @GetMapping("deleteDepartmentById")
    int deleteDepartmentById(Integer id){
        return deptServ.deleteDepartmentById(id);
    }

    //ok,同时也设置成功了id这个服务可以稍微改一下，可以把返回值设置成返回的id，这个比较好。
    //改好了，插入、删除，和更新都只是暂时可以，细致的null值和级联操作还没有做。
    @GetMapping("insertDepartment")
    Department insertDepartment(Department dept){
        dept = new Department();
        dept.setName("xindewe");
        dept.setCode("12345678");
        deptServ.insertDepartment(dept);
        return dept;
    }

    //ok，
    @GetMapping("updateDepartment")
    int updateDepartment(Department dept){
        dept = new Department();
        dept.setId(1);
        dept.setName("xinde");
        return deptServ.updateDepartment(dept);
    }


    //以下测试ee
    @Autowired
    EmploymentServ eeServ;

    //ok
    @GetMapping("selectEmployeeById")
    Employee selectEmployeeById(Integer id){
        return eeServ.selectEmployeeById(id);
    }

    //ok
    @GetMapping("selectEmployeeExtById")
    EmployeeExt selectEmployeeExtById(Integer id){
        return eeServ.selectEmployeeExtById(id);
    }
    //ok
    @GetMapping("selectEmployeeByDeptId")
    List<Employee> selectEmployeeByDeptId(Integer deptId){
        return eeServ.selectEmployeeByDeptId(deptId);
    }

    //ok
    @GetMapping("selectEmployeeExtByDeptId")
    List<EmployeeExt> selectEmployeeExtByDeptId(Integer deptId){
        return eeServ.selectEmployeeExtByDeptId(deptId);
    }

    //ok
    @GetMapping("selectAllEmployee")
    List<Employee> selectAllEmployee(){
        return eeServ.selectAllEmployee();
    }

    //ok
    @GetMapping("selectAllEmployeeExt")
    List<EmployeeExt> selectAllEmployeeExt(){
        return eeServ.selectAllEmployeeExt();
    }

    //ok
    @GetMapping("selectAllAccount")
    List<String> selectAllAccount(){
        return eeServ.selectAllAccount();
    }

    //ok
    @GetMapping("deleteEmployeeById")
    int deleteEmployeeById(Integer id){
        return eeServ.deleteEmployeeById(id);
    }

    //0k
    @GetMapping("deleteEmployeeByDeptId")
    int deleteEmployeeByDeptId(Integer deptId){
        return eeServ.deleteEmployeeByDeptId(deptId);
    }

    //ok
    @GetMapping("updateEmployee")
    int updateEmployee(Employee ee){
        ee = new Employee();

        ee.setId(10);
//        ee.setName("lll");
        ee.setAge(45);
        ee.setSex("男");
        ee.setTel("17772413437");
//        ee.setAccount("tyuiokjhj");
        ee.setPwd("tykjhu");
        ee.setDeptId(1);

        return eeServ.updateEmployee(ee);
    }


    //ok
    @GetMapping("insertEmployee")
    int insertEmployee(Employee ee){

//        ee.setId(1);
        ee.setName("lll");
        ee.setAge(45);
        ee.setSex("男");
        ee.setTel("17772413437");
        ee.setAccount("tyuiokjhj");
        ee.setPwd("tykjhu");
        ee.setDeptId(1);

        return eeServ.insertEmployee(ee);
    }




}
