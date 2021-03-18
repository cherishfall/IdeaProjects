package com.ex0317.demo0317;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/peradmin")
public class PerAdminController {
    @Autowired
    Serv serv;

    @GetMapping
    public String personAdmin(Model model){
        List<Person> people = serv.findAll();
        model.addAttribute("people", people);
        return "peradmin";
    }

}
