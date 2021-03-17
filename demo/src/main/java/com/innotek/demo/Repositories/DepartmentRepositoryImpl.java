package com.innotek.demo.Repositories;

import com.innotek.demo.Department;
import com.innotek.demo.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

//部门的删除没有同步到employee表的flag字段
@Repository
public class DepartmentRepositoryImpl implements DepartmentRepository{
    @Autowired
    JdbcTemplate jdbcTemplate;
    @Override
    public int saveDepartment(Department dept) {
        //INSERT INTO department (name, code, num, flag) VALUES ('项目管理部', '0901', DEFAULT, DEFAULT)
        String sql = "INSERT INTO department (name, code, num, flag) VALUES (?, ?, ?, 1)";
        return jdbcTemplate.update(sql, dept.getName(), dept.getCode(), dept.getNum());
    }

    @Override
    public int deleteDepartment(Integer id) {
        String sql = "update department set flag=0 where id=?";
        return jdbcTemplate.update(sql, id);
    }

    @Override
    public int updateDepartment(Department dept) {
        String sql = "update department set code=?, num=? where id=?";
        return jdbcTemplate.update(sql, dept.getCode(), dept.getNum(), dept.getId());
    }

    @Override
    public Department findById(Integer id) {
        String sql = "select * from department where id=?";
        RowMapper<Department> rowMapper = new BeanPropertyRowMapper<>(Department.class);
        return jdbcTemplate.queryForObject(sql, rowMapper, id);
    }

    public Department findByName(String name){
        String sql = "select * from department where name=?";
        RowMapper<Department> rowMapper = new BeanPropertyRowMapper<>(Department.class);
        return jdbcTemplate.queryForObject(sql, rowMapper, name);

    }

    @Override
    public List<Department> findAll() {
        String sql = "select * from department where flag=1";
        RowMapper<Department> rowMapper = new BeanPropertyRowMapper<>(Department.class);
        return jdbcTemplate.query(sql, rowMapper);
    }
}
