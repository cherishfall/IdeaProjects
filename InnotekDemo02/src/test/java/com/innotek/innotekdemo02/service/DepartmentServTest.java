package com.innotek.innotekdemo02.service;

import com.innotek.innotekdemo02.entity.Department;
import com.innotek.innotekdemo02.entity.DepartmentExt;
import com.innotek.innotekdemo02.entity.Employee;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class DepartmentServTest {
    @Autowired
    DepartmentServ deptServ;

    @Autowired
    EmploymentServ eeServ;

    @Test
    void selectDepartmentById() {
        Department dept = deptServ.selectDepartmentById(3);
        System.out.println("dept = " + dept);
    }

    @Test
    void selectDepartmentExtById() {
        DepartmentExt deptExt = deptServ.selectDepartmentExtById(3);
//        用数据库的对象之前，都要判断是否为空指针
//        System.out.println("deptName = " + deptExt.getName());
        System.out.println(deptExt);
    }

    @Test
    void selectAllDepartment() {
    }

    @Test
    void insertDepartment() {
        Deprecated dept;
    }

    @Test
    void updateDepartment() {
    }

    @Test
    void deleteDepartmentById() {
    }

    @Test
    void selectAllCode() {
    }

    @Test
    void selectAllId() {
    }

//    2021.4.1 新增懒加载查询
    @Test
    void selectDepartmentExtByIdLazy(){
        DepartmentExt deptExt = deptServ.selectDepartmentExtByIdLazy(1);
        System.out.println(deptExt.getName());

        System.out.println("李凡 李凡 李凡 分割线");
        System.out.println("李凡 李凡 李凡 分割线");
        System.out.println("李凡 李凡 李凡 分割线");

        List<Employee> ees =  deptExt.getEes();

        System.out.println(ees.get(0));

        try {
            Thread.sleep( 3000 );
        } catch (Exception e){
            System.exit( 0 ); //退出程序
        }
    }


    @Test
    void insertDeptAndEE(){
        Department dept = new Department(0, "djddd", "27688");

        List<Employee> ees = new ArrayList<>();
        Employee ee1 = new Employee();
        ee1.setName("aaa");
        ee1.setAccount("aaa1");
        ee1.setPwd("dhkjhj");
        ees.add(ee1);

        Employee ee2 = new Employee();
        ee2.setName("aaa");
        ee2.setAccount("aaa2");
        ee2.setPwd("dhkjhj");
        ees.add(ee2);

        Employee ee3 = new Employee();
        ee3.setName("aaa");
        ee3.setAccount("aaa3");
        ee3.setPwd("dhkjhj");
        ees.add(ee3);

        Employee ee4 = new Employee();
        ee4.setName("aaa");
        ee4.setAccount("aaa4");
        ee4.setPwd("dhkjhj");
        ees.add(ee4);

        deptServ.insertDeptAndEE(dept, ees);
        System.out.println(dept.getId());


        //重复的dept测试
        Department dept02 = new Department(0, "djddd", "27688");
        //遇到一个java arraylist的盲点，可以把同一个对象重复添加进list里，但是都是引用同一个物理对象。
        List<Employee> ees02 = new ArrayList<>();
        Employee ee = new Employee();
        ee.setName("aaa");
        ee.setAccount("aaa1");
        ee.setPwd("dhkjhj");
        ees02.add(ee);

        ee.setName("aaa");
        ee.setAccount("aaa2");
        ee.setPwd("dhkjhj");
        ees02.add(ee);
        deptServ.insertDeptAndEE(dept02, ees02);
        System.out.println(dept02.getId());

    }

    @Test
    void insertDeptAndEEV2(){

        List<Employee> ees = new ArrayList<>();
        Employee ee1 = new Employee();
        ee1.setName("bbb");
        ee1.setAccount("bbb1");
        ee1.setPwd("dhkjhj");
        ees.add(ee1);

        Employee ee2 = new Employee();
        ee2.setName("bbb");
        ee2.setAccount("bbb2");
        ee2.setPwd("dhkjhj");
        ees.add(ee2);

        Employee ee3 = new Employee();
        ee3.setName("bbb");
        ee3.setAccount("bbb3");
        ee3.setPwd("dhkjhj");
        ees.add(ee3);

        Employee ee4 = new Employee();
        ee4.setName("bbb");
        ee4.setAccount("bbb4");
        ee4.setPwd("dhkjhj");
        ees.add(ee4);

        DepartmentExt deptExt = new DepartmentExt();
        deptExt.setId(0);
        deptExt.setName("sdfgfds");
        deptExt.setCode("678");
        deptExt.setEes(ees);

        deptServ.insertDeptAndEEV2(deptExt);

    }


}