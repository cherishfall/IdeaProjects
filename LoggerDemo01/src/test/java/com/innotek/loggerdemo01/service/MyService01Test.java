package com.innotek.loggerdemo01.service;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;


@SpringBootTest
class MyService01Test {
    @Autowired
    MyService01 myService01;

    @BeforeEach
    void setUp() {
    }

    @AfterEach
    void tearDown() {
    }

    @Test
    void logTest01() {
        myService01.logTest01();
    }

    @Test
    void logTest02() {
        myService01.logTest02();
    }

    @Test
    void logTest03() {
        myService01.logTest03();
    }
}