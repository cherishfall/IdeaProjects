package com.innotek.mybatisdemo01.controller;

import com.innotek.mybatisdemo01.entity.Card;
import com.innotek.mybatisdemo01.serv.CardServ;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CardController {
    @Autowired
    CardServ cardServ;

    @GetMapping("/card")
    Card card(int id){
        return cardServ.selectCardById(id);
    }
}
