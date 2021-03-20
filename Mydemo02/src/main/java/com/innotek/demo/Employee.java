package com.innotek.demo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Employee {
    Integer id;
    String name;
    String phone;
    String sex;
    Integer age;
    String acount;
    String pwd;
    Integer dept_id;
    Integer flag;
}
