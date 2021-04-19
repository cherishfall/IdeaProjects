package com.innotek.valiadationdemo01.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.Range;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Employee {

    @Min(value = 0, message = "员工编号必须非负")
    private Integer id;

    @NotBlank(message = "姓名不能为空")
    @Length(min=2, max = 16, message = "姓名必须在2到16个字符")
    private String name;

    @Length(min=1, max = 1, message = "性别必须1个字符")
    private String sex;

    @Range(min = 18, max = 65, message = "工作年龄必须在18周岁到65周岁")
    private Integer age;

    @Length(min = 11, max = 11, message = "必须是中国大陆11位手机号码")
//    @Pattern(regexp = "^1(3|4|5|7|8)\\\\d{9}$", message = "手机号码格式错误")
    private String tel;


    @NotBlank(message = "账户名不能为空")
    @Length(min=4, max = 16, message = "账户名必须在6到16个字符")
    private String account;

    @NotBlank(message = "账户名不能为空")
    @Length(min=4, max = 16, message = "密码必须在6到16个字符")
    private String pwd;

    @NotNull(message = "部门编号不能为0")
    @Min(value = 0, message = "员工编号必须非负")
    private Integer deptId;
}
