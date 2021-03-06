package com.innotek.innotekdemo02.dao;

import com.innotek.innotekdemo02.entity.Employee;
import com.innotek.innotekdemo02.entity.EmployeeExt;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface IEmployeeDao {

    Employee selectEmployeeById(Integer id);
    EmployeeExt selectEmployeeExtById(Integer id);

    List<Employee> selectEmployeeByDeptId(Integer deptId);
    List<EmployeeExt> selectEmployeeExtByDeptId(Integer deptId);

    List<Employee> selectAllEmployee();
    List<EmployeeExt> selectAllEmployeeExt();

    List<String> selectAllAccount();

    int insertEmployee(Employee ee);

    int updateEmployee(Employee ee);

    int deleteEmployeeById(Integer id);

    int deleteEmployeeByDeptId(Integer dept_id);







}
