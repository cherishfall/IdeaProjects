package com.innotek.mybatisdemo03.dao;

import com.innotek.mybatisdemo03.entity.Order;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface IOrderDao {
    public Order selectOrderById(int id);

    public List<Order> selectOrderByUserId(int user_id);

}
