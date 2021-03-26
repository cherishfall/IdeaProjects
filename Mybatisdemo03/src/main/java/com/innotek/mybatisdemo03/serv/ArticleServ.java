package com.innotek.mybatisdemo03.serv;

import com.innotek.mybatisdemo03.dao.IArticleDao;
import com.innotek.mybatisdemo03.entity.Article;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ArticleServ {
    @Autowired
    IArticleDao iArticleDao;

    public List<Article> selectArticleByOrderId(int oid){
        return iArticleDao.selectArticleByOrderId(oid);
    }
}
