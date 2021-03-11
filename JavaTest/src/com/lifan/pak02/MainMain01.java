package com.lifan.pak02;

import com.lifan.pak01.MainMain;

public class MainMain01 extends MainMain{
    protected void fun5(){}

    public static void main(String[] args){

//        不同包，MainMain是public类，MainMain01继承自MainMain
        MainMain mm = new MainMain();
        mm.fun1();
//        mm.fun2(); //报错
//        'fun2()' has protected access in 'com.lifan.pak01.MainMain'
    }
}
