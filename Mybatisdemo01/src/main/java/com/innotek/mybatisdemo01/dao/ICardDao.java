package com.innotek.mybatisdemo01.dao;

import com.innotek.mybatisdemo01.entity.Card;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface ICardDao {
    Card selectCardById(int id);
}
