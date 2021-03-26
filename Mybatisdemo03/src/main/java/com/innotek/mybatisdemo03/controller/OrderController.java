package com.innotek.mybatisdemo03.controller;

import com.innotek.mybatisdemo03.entity.Order;
import com.innotek.mybatisdemo03.serv.OrderServ;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class OrderController {
    @Autowired
    OrderServ orderServ;

    @GetMapping("/order")
    public Order order(int id){
        return orderServ.selectOrderById(id);
    }
}
