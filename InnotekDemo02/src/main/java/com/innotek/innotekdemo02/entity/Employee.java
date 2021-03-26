package com.innotek.innotekdemo02.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Employee {
    private Integer id;
    private String name;
    private Integer age;
    private String sex;
    private String tel;
    private String account;
    private String pwd;
    private Integer deptId;
}
