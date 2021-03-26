package com.innotek.innotekdemo02.dao;

import com.innotek.innotekdemo02.entity.Department;
import com.innotek.innotekdemo02.entity.DepartmentExt;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface IDepartmentDao {
    Department selectDepartmentById(Integer id);
    DepartmentExt selectDepartmentExtById(Integer id);
    List<Department> selectAllDepartment();

    int insertDepartment(Department dept);

    int updateDepartment(Department dept);

    int deleteDepartmentById(Integer id);

    List<String> selectDepartmentAllCode();


}
