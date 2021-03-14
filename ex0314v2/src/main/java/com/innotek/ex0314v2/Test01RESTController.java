package com.innotek.ex0314v2;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;



@RestController
@RequestMapping("/test01")
public class Test01RESTController {

    @GetMapping
    public String test01Home(){
        return "test01";
    }

    @GetMapping("/name")
    public String getMyName(){
        return "name";
    }

    @GetMapping("/profile")
    public MyProfile getMyProfile(){
        return new MyProfile("lifan", "male", 23);
    }

}




