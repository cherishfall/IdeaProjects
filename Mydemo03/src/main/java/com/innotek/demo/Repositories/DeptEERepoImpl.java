package com.innotek.demo.Repositories;

import com.innotek.demo.Employee;
import com.innotek.demo.Entity.DeptEE;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import static java.sql.Types.VARCHAR;

@Repository
public class DeptEERepoImpl implements DeptEERepo{
    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    public List<DeptEE> findEEByEEName(String name){
        //接口默认是public，重写的方法在访问控制上不能小于原来风访问权限，抛出的异常不能大元原方法

        String sql = "select e.id id, e.name name, e.phone phone, e.sex sex, e.age age, e.acount acount, " +
                "d.id dept_id, d.name dept_name, d.code dept_code " +
                "from employee e join department d on d.id = e.dept_id " +
                "where e.name=?";
        List<DeptEE> deptEES = jdbcTemplate.query(sql, new MyRowMapper(), name);
        return deptEES;
    }

    @Override
    public List<DeptEE> findEEByEENameAndDeptName(String name, String dept_name){
        String sql = "select e.id id, e.name name, e.phone phone, e.sex sex, e.age age, e.acount acount, " +
                "d.id dept_id, d.name dept_name, d.code dept_code " +
                "from employee e join department d on d.id = e.dept_id " +
                "where e.name=? and d.name=?";
        List<DeptEE> deptEES = jdbcTemplate.query(sql, new Object[]{name, dept_name}, new int[]{VARCHAR, VARCHAR}, new MyRowMapper());
        return deptEES;

    }

    public class MyRowMapper implements RowMapper<DeptEE>{
        @Override
        public DeptEE mapRow(ResultSet rs, int rowNum) throws SQLException {
            Integer id = rs.getInt("id");//如果值为SQL NULL ，则返回的值为0
            String name = rs.getString("name");//如果值为SQL NULL ，则返回的值为null
            String phone = rs.getString("phone");
            String sex = rs.getString("sex");
            Integer age = rs.getInt("age");
            String acount = rs.getString("acount");
            Integer dept_id = rs.getInt("dept_id");
            String dept_name = rs.getString("dept_name");
            String dept_code = rs.getString("dept_code");


            DeptEE deptEE = new DeptEE(id,name,phone,sex,age,acount,dept_id,dept_name,dept_code);
            return deptEE;
        }
    }


}
