package com.innotek.mybatisdemo02.serv;

import com.innotek.mybatisdemo02.dao.IClazzDao;
import com.innotek.mybatisdemo02.entity.Clazz;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ClazzServ {
    @Autowired
    IClazzDao iClazzDao;

    public Clazz selectClazzById(int id){
        return iClazzDao.selectClazzById(id);
    }
}
