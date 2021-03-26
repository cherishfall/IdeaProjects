package com.innotek.mybatisdemo03.entity;

import java.io.Serializable;
import java.util.List;

public class User implements Serializable {
    private static final long serialVersionUID = 1L;
    private Integer id; // 用户id，主键
    private String username; // 用户名
    private String loginname; // 登录名
    private String pwd; // 密码
    private String phone; // 联系电话
    private String address; // 收货地址

    // 用户和订单是一对多的关系，即一个用户可以有多个订单
    private List<Order> orders;

    public User()
    {
        super();
    }

    public User(String username, String loginname, String pwd, String phone, String address)
    {
        super();
        this.username = username;
        this.loginname = loginname;
        this.pwd = pwd;
        this.phone = phone;
        this.address = address;
    }

    public Integer getId()
    {
        return id;
    }

    public void setId(Integer id)
    {
        this.id = id;
    }

    public String getUsername()
    {
        return username;
    }

    public void setUsername(String username)
    {
        this.username = username;
    }

    public String getLoginname()
    {
        return loginname;
    }

    public void setLoginname(String loginname)
    {
        this.loginname = loginname;
    }

    public String getPwd()
    {
        return pwd;
    }

    public void setPwd(String pwd)
    {
        this.pwd = pwd;
    }

    public String getPhone()
    {
        return phone;
    }

    public void setPhone(String phone)
    {
        this.phone = phone;
    }

    public String getAddress()
    {
        return address;
    }

    public void setAddress(String address)
    {
        this.address = address;
    }

    public List<Order> getOrders()
    {
        return orders;
    }

    public void setOrders(List<Order> orders)
    {
        this.orders = orders;
    }

    @Override
    public String toString()
    {
        return "User [id=" + id + ", username=" + username + ", loginname=" + loginname + ", pwd=" + pwd
                + ", phone=" + phone + ", address=" + address + "]";
    }
}
