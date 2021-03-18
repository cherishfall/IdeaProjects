package com.innotek.demo.Services;

import com.innotek.demo.Department;
import com.innotek.demo.Repositories.DepartmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentServiceImpl implements DepartmentService{
    @Autowired
    DepartmentRepository deptRepo;

    @Override
    public int saveDepartment(Department dept) {
        return deptRepo.saveDepartment(dept);
    }

    @Override
    public int deleteDepartment(Integer id) {
        return deptRepo.deleteDepartment(id);
    }

    @Override
    public int updateDepartment(Department dept) {
        return deptRepo.updateDepartment(dept);
    }

    @Override
    public Department findByName(String name){
        return deptRepo.findByName(name);
    }

    @Override
    public Department findById(Integer id) {
        return deptRepo.findById(id);
    }

    @Override
    public List<Department> findAll() {
        return deptRepo.findAll();
    }
}
