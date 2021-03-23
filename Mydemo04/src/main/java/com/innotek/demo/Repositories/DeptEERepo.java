package com.innotek.demo.Repositories;


import com.innotek.demo.Employee;
import com.innotek.demo.Entity.DeptEE;

import java.util.List;

public interface DeptEERepo {
    List<DeptEE> findEEByEEName(String name);
    List<DeptEE> findEEByEENameAndDeptName(String name, String dept_name);
}
