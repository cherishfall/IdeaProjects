package com.ex0317.demo0317;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class Repo {
    @Autowired
    JdbcTemplate jdbc;

    int addPenson(Person p){
        String sql = "INSERT INTO person (name, age, sex, flag) VALUES (?, ?, ?, 1)";
        int i = jdbc.update(sql, p.name, p.age, p.sex);
        return i;
    }

    int deletePerson(Integer id){
        String sql = "UPDATE person SET flag = 0 WHERE id = ?";
        return jdbc.update(sql, id);
    }

    int updatePerson(Person p){
        String sql = "UPDATE person SET age = ?, sex = ? WHERE id = ?";
        return jdbc.update(sql, p.age, p.sex,  p.id);
    }

    Person findById(Integer id){
        String sql = "SELECT * FROM person WHERE id=?";
        RowMapper<Person> rowMapper = new BeanPropertyRowMapper<>(Person.class);
        return jdbc.queryForObject(sql, rowMapper, id);
    }

    List<Person> findByName(String name){
        String sql = "SELECT * FROM person WHERE flag<>0 AND name=?";
        RowMapper<Person> rowMapper = new BeanPropertyRowMapper<>(Person.class);
        return jdbc.query(sql, rowMapper, name);
    }

    List<Person> findAll(){
        String sql = "SELECT * FROM person WHERE flag<>0";
        RowMapper<Person> rowMapper = new BeanPropertyRowMapper<>(Person.class);
        return jdbc.query(sql, rowMapper);
    }

}
