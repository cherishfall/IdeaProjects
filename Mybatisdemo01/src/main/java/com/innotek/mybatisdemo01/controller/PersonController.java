package com.innotek.mybatisdemo01.controller;

import com.innotek.mybatisdemo01.entity.Person;
import com.innotek.mybatisdemo01.serv.PersonServ;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PersonController {
    @Autowired
    PersonServ personServ;

    @GetMapping("person")
    public Person person(int id){
        return personServ.selectPersonById(id);
    }
}
