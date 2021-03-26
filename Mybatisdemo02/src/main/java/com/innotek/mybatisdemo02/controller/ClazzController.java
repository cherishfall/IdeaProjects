package com.innotek.mybatisdemo02.controller;

import com.innotek.mybatisdemo02.entity.Clazz;
import com.innotek.mybatisdemo02.serv.ClazzServ;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ClazzController {
    @Autowired
    ClazzServ clazzServ;

    @GetMapping("/clazz")
    public Clazz clazz(int id){
        return clazzServ.selectClazzById(id);
    }
}
