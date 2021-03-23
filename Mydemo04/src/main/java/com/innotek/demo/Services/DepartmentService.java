package com.innotek.demo.Services;

import com.innotek.demo.Department;

import java.util.List;

public interface DepartmentService {
    public int saveDepartment(Department dept);
    public int deleteDepartment(Integer id);
    public int updateDepartment(Department dept);
    public Department findById(Integer id);
    public Department findByName(String name);
    public List<Department> findAll();
}
