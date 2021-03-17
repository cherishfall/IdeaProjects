package com.innotek.demo.Services;

import com.innotek.demo.Employee;
import com.innotek.demo.Repositories.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService{
    @Autowired
    EmployeeRepository eeRepo;

    @Override
    public int saveEmployee(Employee ee) {
        return eeRepo.saveEmployee(ee);
    }

    @Override
    public int deleteEmployee(Integer id) {
        return eeRepo.deleteEmployee(id);
    }

    @Override
    public int updateEmployee(Employee ee) {
        return eeRepo.updateEmployee(ee);
    }

    @Override
    public Employee findById(Integer id) {
        return eeRepo.findById(id);
    }

    public List<Employee> findByName(String name){
        return eeRepo.findByName(name);
    }
    public List<Employee> findByDeptId(Integer dept_id){
        return eeRepo.findByDeptId(dept_id);
    }

    @Override
    public List<Employee> findAll() {
        return eeRepo.findAll();
    }
}
