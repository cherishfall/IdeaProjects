package com.innotek.valiadationdemo01.controller;

import com.innotek.valiadationdemo01.entity.Employee;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import java.util.List;

@Controller
@Slf4j

public class HomeController {

    @GetMapping("/test01")
    @ResponseBody
     Employee test01(@Valid Employee ee, BindingResult bindingResult){
        if(bindingResult.hasErrors()){
            List<ObjectError> erroeList = bindingResult.getAllErrors();
            for (ObjectError error : erroeList){
                log.error(error.toString());
            }

            return null;
        }else {
            return ee;
        }

    }
}
