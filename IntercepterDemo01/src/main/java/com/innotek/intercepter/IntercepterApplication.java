package com.innotek.intercepter;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@SpringBootApplication
@ServletComponentScan(basePackages = "com.innotek.intercepter.filter")
public class IntercepterApplication {

    public static void main(String[] args) {
        SpringApplication.run(IntercepterApplication.class, args);
    }

}
