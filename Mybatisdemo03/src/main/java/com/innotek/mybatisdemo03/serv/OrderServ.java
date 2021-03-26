package com.innotek.mybatisdemo03.serv;

import com.innotek.mybatisdemo03.dao.IOrderDao;
import com.innotek.mybatisdemo03.entity.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderServ {
    @Autowired
    IOrderDao iOrderDao;

    public Order selectOrderById(int id){
        return iOrderDao.selectOrderById(id);
    }

    public List<Order> selectOrderByUserId(int user_id){
        return iOrderDao.selectOrderByUserId(user_id);
    }
}
