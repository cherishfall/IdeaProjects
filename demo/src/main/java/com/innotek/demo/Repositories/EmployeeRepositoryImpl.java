package com.innotek.demo.Repositories;

import com.innotek.demo.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

//员工的增删操作没有同步到department表的num字段
//员工的修改部门id没有检查id是否存在或者有效

@Repository
public class EmployeeRepositoryImpl implements EmployeeRepository{
    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    public int saveEmployee(Employee ee) {
// INSERT INTO employee (name, phone, sex, age, acount, pwd, dept_id, flag) VALUES ('程瑞', null, null, null, 'chengrui', 'chengrui', 8, 1)
        String sql = "INSERT INTO employee (name, phone, sex, age, acount, pwd, dept_id, flag) VALUES " +
                "(?, ?, ?, ?, ?, ?, ?, 1)";
        return jdbcTemplate.update(sql, ee.getName(), ee.getPhone(), ee.getSex(), ee.getAge(), ee.getAcount(),
                ee.getPwd(), ee.getDept_id());
    }

    @Override
    public int deleteEmployee(Integer id) {
//UPDATE innotek.employee t SET t.flag = 0 WHERE t.id = 4
        String sql = "update employee set flag=0 where id=?";
        return jdbcTemplate.update(sql, id);
    }

    @Override
    public int updateEmployee(Employee ee) {
        //UPDATE employee t SET t.sex = '男' WHERE t.id = 3
        String sql = "update employee set phone=?, sex=?, age=?, pwd=?, dept_id=? where id=?";
        return jdbcTemplate.update(sql, ee.getPhone(), ee.getSex(), ee.getAge(), ee.getPwd(), ee.getDept_id(), ee.getId());


    }

    @Override
    public Employee findById(Integer id) {
        String sql = "select * from employee where id=?";
        RowMapper<Employee> rowMapper = new BeanPropertyRowMapper<>(Employee.class);
        return jdbcTemplate.queryForObject(sql, rowMapper, id);
    }

    @Override
    public List<Employee> findByName(String name){
        String sql = "select * from employee where name=?";
        RowMapper<Employee> rowMapper = new BeanPropertyRowMapper<>(Employee.class);
        return jdbcTemplate.query(sql, rowMapper, name);
    }

    @Override
    public List<Employee> findByDeptId(Integer dept_id){
        String sql = "select * from employee where flag=1 and dept_id=?";
        RowMapper<Employee> rowMapper = new BeanPropertyRowMapper<>(Employee.class);
        return jdbcTemplate.query(sql, rowMapper, dept_id);
    }

    @Override
    public List<Employee> findAll() {
        String sql = "select * from employee where flag=1";
        RowMapper<Employee> rowMapper = new BeanPropertyRowMapper<>(Employee.class);
        return jdbcTemplate.query(sql, rowMapper);
    }

}
