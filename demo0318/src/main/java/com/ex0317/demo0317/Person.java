package com.ex0317.demo0317;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Person {
    Integer id;
    String name;
    Integer age;
    String sex;
    Integer flag;
}
