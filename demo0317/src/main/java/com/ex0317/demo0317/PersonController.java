package com.ex0317.demo0317;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
//@RequestMapping("/person")
public class PersonController {

    @Autowired
    Serv serv;

    @GetMapping("/person/add")
    String add(){
        return "/person/add";
    }

    @PostMapping("/person/add")
//    @ResponseBody
    String responAdd(Person p){
        serv.addPenson(p);
        return "redirect:/peradmin";
    }

    @GetMapping("/person/update")
    String update(Model model, @RequestParam(value = "id") Integer id){
        Person p = serv.findById(id);
        model.addAttribute("p", p);
        return "/person/update";
    }

    @PostMapping("/person/update")
//    @ResponseBody
    String responUpdate(Person p){
        serv.updatePerson(p);
        return "redirect:/peradmin";
    }


    @GetMapping("/person/delete")
    String delete(){
        return "/person/delete";
    }

    @PostMapping("/person/delete")
//    @ResponseBody
    String responDelete(Integer id){
        serv.deletePerson(id);
        return "redirect:/peradmin";
    }



    @GetMapping("/person/find")
    String find(){
        return "/person/find";
    }

    @PostMapping("/person/find")
//    @ResponseBody
    String responFind(Model model, String name){
        List<Person> people = serv.findByName(name);
        model.addAttribute("people", people);
        return "forward:/person/findresult";
    }

//    @GetMapping ("/person/findresult") 不行
//    @RequestMapping("/person/findresult") 可以
    @PostMapping("/person/findresult")
    String findResult(){
        return "/person/findresult";
    }




}
