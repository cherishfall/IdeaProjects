package com.innotek.mybatisdemo03.dao;

import com.innotek.mybatisdemo03.entity.Article;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface IArticleDao {
    public List<Article> selectArticleByOrderId(int oid);
}
