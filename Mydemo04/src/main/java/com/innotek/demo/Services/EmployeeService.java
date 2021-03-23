package com.innotek.demo.Services;

import com.innotek.demo.Employee;

import java.util.List;

public interface EmployeeService {
    public int saveEmployee(Employee ee);
    public int deleteEmployee(Integer id);
    public int updateEmployee(Employee ee);
    public Employee findById(Integer id);
    public List<Employee> findByName(String name);
    public List<Employee> findByDeptId(Integer dept_id);
    public List<Employee> findAll();

}
