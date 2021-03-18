package com.ex0317.demo0317;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/person")
public class PersonController {

    @Autowired
    Serv serv;

    @GetMapping("/add")
    String add(){
        return "person/add";
    }

    @PostMapping("/add")
    @ResponseBody
    List<Person> responAdd(Person p){
        serv.addPenson(p);
        return serv.findByName(p.name);
    }

    @GetMapping("/delete")
    String delete(){
        return "person/delete";
    }

    @PostMapping("/delete")
    @ResponseBody
    Person responDelete(Integer id){
        serv.deletePerson(id);
        return serv.findById(id);
    }

    @GetMapping("/update")
    String update(Model model, @RequestParam(value = "id", defaultValue = "1") Integer id){
        Person p = serv.findById(id);
        model.addAttribute("p", p);
        return "person/update";
    }

    @PostMapping("/update")
    @ResponseBody
    Person responUpdate(Person p){
        serv.updatePerson(p);
        return serv.findById(p.id);
    }

    @GetMapping("/find")
    String find(){
        return "person/find";
    }

    @PostMapping("/find")
    @ResponseBody
    List<Person> responFind(String name){
        return serv.findByName(name);
    }




}
