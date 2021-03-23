package com.innotek.demo.Services;

import com.innotek.demo.Entity.DeptEE;
import com.innotek.demo.Repositories.DeptEERepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeptEESevImpl implements DeptEESev{
    @Autowired
    DeptEERepo deptEERepo;

    @Override
    public List<DeptEE> findEEByEEName(String name){
        return deptEERepo.findEEByEEName(name);
    }

    @Override
    public List<DeptEE> findEEByEENameAndDeptName(String name, String dept_name){
        return deptEERepo.findEEByEENameAndDeptName(name, dept_name);
    }
}
