package com.ex0317.demo0317;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class Serv {
    @Autowired
    Repo repo;

    int addPenson(Person p){
        return repo.addPenson(p);

    }

    int deletePerson(Integer id){
        return repo.deletePerson(id);
    }

    int updatePerson(Person p){
        return repo.updatePerson(p);
    }

    Person findById(Integer id){
        return repo.findById(id);
    }

    List<Person> findByName(String name){
        return repo.findByName(name);
    }

    List<Person> findAll(){
        return repo.findAll();
    }
}
