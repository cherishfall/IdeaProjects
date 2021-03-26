package com.innotek.mybatisdemo03.controller;

import com.innotek.mybatisdemo03.entity.Article;
import com.innotek.mybatisdemo03.serv.ArticleServ;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class ArticleController {
    @Autowired
    ArticleServ articleServ;

    @GetMapping("/article")
    public List<Article> article(int oid){
        return articleServ.selectArticleByOrderId(oid);
    }
}
