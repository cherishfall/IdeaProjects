package com.innotek.loggerdemo01.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class MyService01 {

    public void logTest01(){
        log.info("我是李凡");
        log.debug("我是李凡凡");
        log.error("我是李李凡");
        System.out.println("suspend");
    }

    public void logTest02(){
        try {
            int a = 1 / 0;
        }catch (Exception e){
            e.printStackTrace();
            log.error("-------------*****1/0****---------------", e);
        }

        System.out.println("suspend");
    }

    public void logTest03(){
        Integer[] arrs = {1, 2, 3, 4, 5, 6};
        String[] strs = {"李凡", "李凡凡", "李李凡"};
        log.debug("-------- **** arrs **** ----------", arrs);
        log.debug("-------- **** strs  **** ----------", strs);

        System.out.println("suspend");
    }
}
