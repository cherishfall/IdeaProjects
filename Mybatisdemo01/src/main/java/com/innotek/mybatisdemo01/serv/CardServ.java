package com.innotek.mybatisdemo01.serv;

import com.innotek.mybatisdemo01.dao.ICardDao;
import com.innotek.mybatisdemo01.entity.Card;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Service
public class CardServ {
    @Autowired
    ICardDao iCardDao;

    public Card selectCardById(int id){
        return iCardDao.selectCardById(id);
    }
}
