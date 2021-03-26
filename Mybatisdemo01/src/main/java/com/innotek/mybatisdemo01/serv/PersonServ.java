package com.innotek.mybatisdemo01.serv;

import com.innotek.mybatisdemo01.dao.IPersonDao;
import com.innotek.mybatisdemo01.entity.Person;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PersonServ {
    @Autowired
    IPersonDao iPersonDao;

    public Person selectPersonById(int id){
        return iPersonDao.selectPersonById(id);
    }
}
