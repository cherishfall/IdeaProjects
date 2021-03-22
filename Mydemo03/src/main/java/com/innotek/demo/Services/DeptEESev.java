package com.innotek.demo.Services;

import com.innotek.demo.Entity.DeptEE;

import java.util.List;

public interface DeptEESev {
    List<DeptEE> findEEByEEName(String name);
    List<DeptEE> findEEByEENameAndDeptName(String name, String dept_name);
}
