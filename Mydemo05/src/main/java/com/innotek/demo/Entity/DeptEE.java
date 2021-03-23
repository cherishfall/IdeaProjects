package com.innotek.demo.Entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DeptEE {
    Integer id;
    String name;
    String phone;
    String sex;
    Integer age;
    String acount;
    Integer dept_id;
    String dept_name;
    String dept_code;
}
