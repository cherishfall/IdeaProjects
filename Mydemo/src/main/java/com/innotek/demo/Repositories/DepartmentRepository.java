package com.innotek.demo.Repositories;

import com.innotek.demo.Department;
import com.innotek.demo.Employee;

import java.util.List;

public interface DepartmentRepository {
    public int saveDepartment(Department dept);
    public int deleteDepartment(Integer id);
    public int updateDepartment(Department dept);
    public Department findById(Integer id);
    public Department findByName(String name);
    public List<Department> findAll();
}
