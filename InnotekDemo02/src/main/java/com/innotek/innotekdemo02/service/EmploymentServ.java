package com.innotek.innotekdemo02.service;

import com.innotek.innotekdemo02.dao.IDepartmentDao;
import com.innotek.innotekdemo02.dao.IEmployeeDao;
import com.innotek.innotekdemo02.entity.Employee;
import com.innotek.innotekdemo02.entity.EmployeeExt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class EmploymentServ {
    @Autowired
    IEmployeeDao iEmployeeDao;

    @Autowired
    IDepartmentDao iDepartmentDao;

    public Employee selectEmployeeById(Integer id){
        return iEmployeeDao.selectEmployeeById(id);
    }

    public EmployeeExt selectEmployeeExtById(Integer id){
        return iEmployeeDao.selectEmployeeExtById(id);
    }

    public List<Employee> selectEmployeeByDeptId(Integer deptId){
        return iEmployeeDao.selectEmployeeByDeptId(deptId);
    }

    public List<EmployeeExt> selectEmployeeExtByDeptId(Integer deptId){
        return iEmployeeDao.selectEmployeeExtByDeptId(deptId);
    }

    public List<Employee> selectAllEmployee(){
        return iEmployeeDao.selectAllEmployee();
    }
    public List<EmployeeExt> selectAllEmployeeExt(){
        return iEmployeeDao.selectAllEmployeeExt();
    }

    public List<String> selectAllAccount(){
        return iEmployeeDao.selectAllAccount();
    }

    //这个返回的是插入的id值
    public int insertEmployee(Employee ee){
        List<String> accountList = iEmployeeDao.selectAllAccount();
        List<Integer> deptIdList = iDepartmentDao.selectAllId();

        //ee的部门id存在，且账号不存在时
        if(deptIdList.contains(ee.getDeptId()) && !accountList.contains(ee.getAccount()) ){
            if(iEmployeeDao.insertEmployee(ee) == 1){
                return ee.getId();
            }else {
                return 0;
            }
        }else {
            return 0;
        }
    }

    public int updateEmployee(Employee ee){
        List<Integer> deptIdList = iDepartmentDao.selectAllId();
        if(deptIdList.contains(ee.getDeptId())){
            return iEmployeeDao.updateEmployee(ee);
        }else {
            return 0;
        }
    }

    public int deleteEmployeeById(Integer id){
        return iEmployeeDao.deleteEmployeeById(id);
    }

    public int deleteEmployeeByDeptId(Integer dept_id){
        return iEmployeeDao.deleteEmployeeByDeptId(dept_id);
    }
}
