package com.innotek.innotekdemo02.service;

import com.innotek.innotekdemo02.entity.Employee;
import com.innotek.innotekdemo02.entity.EmployeeExt;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class EmploymentServTest {
    @Autowired
    EmploymentServ eeServ;

    @Test
    void selectEmployeeById() {
        Employee ee = eeServ.selectEmployeeById(1);
        System.out.println(ee);
    }

    @Test
    void selectEmployeeExtById() {
        EmployeeExt ee = eeServ.selectEmployeeExtById(1);
        System.out.println(ee);
    }

    @Test
    void selectEmployeeByDeptId() {
    }

    @Test
    void selectEmployeeExtByDeptId() {
    }

    @Test
    void selectAllEmployee() {
    }

    @Test
    void selectAllEmployeeExt() {
    }

    @Test
    void selectAllAccount() {
    }

    @Test
    void insertEmployee() {
        Employee ee = new Employee();
        ee.setName("hjk");
        ee.setAccount("ghjk1");
        ee.setPwd("dhkjhj");
        ee.setDeptId(1);

        //为空是可以的。
        eeServ.insertEmployee(ee);
        System.out.println(eeServ.selectEmployeeById(ee.getId()));
    }

    @Test
    void updateEmployee() {
    }

    @Test
    void deleteEmployeeById() {
    }

    @Test
    void deleteEmployeeByDeptId() {
    }
}