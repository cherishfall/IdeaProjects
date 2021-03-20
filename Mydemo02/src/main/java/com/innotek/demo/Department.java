package com.innotek.demo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Department {

    Integer id;

    String name;

    String code;

//    Integer num;

    Integer flag;
}
