package com.innotek.innotekdemo02.service;

import com.innotek.innotekdemo02.dao.IDepartmentDao;
import com.innotek.innotekdemo02.dao.IEmployeeDao;
import com.innotek.innotekdemo02.entity.Department;
import com.innotek.innotekdemo02.entity.DepartmentExt;
import com.innotek.innotekdemo02.entity.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentServ {
//    @Autowired
//    IEmployeeDao iEmployeeDao;

    @Autowired
    EmploymentServ eeServ;

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

    public List<String> selectAllCode(){
        return iDepartmentDao.selectAllCode();
    }

    public List<Integer> selectAllId(){
        return iDepartmentDao.selectAllId();
    }

//    新增部门
//    注意，这个插入返回的是插入主键id值,返回0说明插入失败(受影响的行数)
//    name和code字段都是不可为空
    public int insertDepartment(Department dept){
//      获取code
        List<String> codeList = selectAllCode();

//        如果code已经存在，直接返回0
        if(!codeList.contains(dept.getCode())){
            if(iDepartmentDao.insertDepartment(dept) == 1){//插入成功
                return dept.getId();
            }else{
                return 0;
            }
        }else {
            return 0;
        }
    }

//    更新部门
//    其中部门id和部门code是不能改的，部门name是可以改的
//    返回受影响的行数
    public int updateDepartment(Department dept){
        return iDepartmentDao.updateDepartment(dept);
    }

//    删除部门
//    返回部门表受影响的条数
    public int deleteDepartmentById(Integer id){
        int rows = iDepartmentDao.deleteDepartmentById(id);

        //如果没有删除成功，不用级联删除该部门的员工
        if(rows != 0){
//            iEmployeeDao.deleteEmployeeByDeptId(id);
            eeServ.deleteEmployeeByDeptId(id);
        }

        return rows;
    }



//    2021.4.1 新增懒查询方式, ok
    public  DepartmentExt selectDepartmentExtByIdLazy(Integer id){
        return iDepartmentDao.selectDepartmentExtByIdLazy(id);
    }


//    2021.4.1 增加一个部门的同时，增加该部门的员工
//    返回新增部门的id，返回0表示插入失败
    public int insertDeptAndEE(Department dept, List<Employee> ees){
//        获得新增部门的id，返回0表示插入不成功
        int deptId = insertDepartment(dept);

        if(deptId != 0){//新增部门成功
            //这里要新增一个判空，ees可能会null
            for(Employee ee: ees){
                ee.setDeptId(deptId);
//                iEmployeeDao.insertEmployee(ee); 不要直接用别的dao，用写好的service
                eeServ.insertEmployee(ee);
            }
        }else {
            return 0;
        }

        return deptId;
    }


    public int insertDeptAndEEV2(DepartmentExt deptExt){
        return insertDeptAndEE(deptExt, deptExt.getEes());
    }
}
