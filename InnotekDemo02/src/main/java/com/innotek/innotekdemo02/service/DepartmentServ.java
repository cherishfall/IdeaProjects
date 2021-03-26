package com.innotek.innotekdemo02.service;

import com.innotek.innotekdemo02.dao.IDepartmentDao;
import com.innotek.innotekdemo02.dao.IEmployeeDao;
import com.innotek.innotekdemo02.entity.Department;
import com.innotek.innotekdemo02.entity.DepartmentExt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentServ {
    @Autowired
    IEmployeeDao iEmployeeDao;

    @Autowired
    IDepartmentDao iDepartmentDao;

    public Department selectDepartmentById(Integer id){
        return iDepartmentDao.selectDepartmentById(id);
    }
    public DepartmentExt selectDepartmentExtById(Integer id){
        return iDepartmentDao.selectDepartmentExtById(id);
    }

    public List<Department> selectAllDepartment(){
        return iDepartmentDao.selectAllDepartment();
    }

    //注意，这个插入返回的是插入主键id值,返回0说明插入失败
    public int insertDepartment(Department dept){
        List<String> codeList = iDepartmentDao.selectAllCode();
        if(!codeList.contains(dept.getCode())){
            if(iDepartmentDao.insertDepartment(dept) == 1){
                return dept.getId();
            }else{
                return 0;
            }
        }else {
            return 0;
        }
    }

    public int updateDepartment(Department dept){
        return iDepartmentDao.updateDepartment(dept);
    }

    public int deleteDepartmentById(Integer id){
        int rows = iDepartmentDao.deleteDepartmentById(id);
        if(rows != 0){
            iEmployeeDao.deleteEmployeeByDeptId(id);
        }else {
            return 0;
        }

        return rows;
    }

    public List<String> selectAllCode(){
        return iDepartmentDao.selectAllCode();
    }

    public List<Integer> selectAllId(){
        return iDepartmentDao.selectAllId();
    }
}
