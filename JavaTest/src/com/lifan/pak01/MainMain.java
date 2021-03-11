package com.lifan.pak01;

import com.lifan.pak02.*;


public class MainMain {

    public void fun1(){}
    protected void fun2(){}
    void fun3(){}
    private void fun4(){}

    public static void  main(String[] args){
//        同文件，同一文件不能声明两个public类
        ClassClass00 c00 = new ClassClass00();
        c00.fun1();//public
        c00.fun2();//ptotected
        c00.fun3();//default

//        同包，类访问控制符为public
        ClassClass01 c01 = new ClassClass01();
        c01.fun1();
        c01.fun2();
        c01.fun3();
//        同包总结，同一个包的类，类访问控制符无作用，可以直接访问同包的类中除private的方法和属性
//        同一个包中类的关系 = 同一文件中的类的关系

//       不同包，类访问控制符为 public
        ClassClass03 c03 = new ClassClass03();
        c03.fun1();//public

//        不同包，类访问控制符为默认 default
//        ClassClass05 c05 = new ClassClass05(); //报错
//      com.lifan.pak02.ClassClass05在com.lifan.pak02中不是公共的; 无法从外部程序包中对其进行访问

//        不同包，类访问控制符为public，继承自该调用类
        MainMain01 mm01 = new MainMain01();
        mm01.fun1();//public
        mm01.fun2();//proted, 这个为什么是可见的？就有点奇怪
//        mm01.fun3();//default 报错
//        'fun3()' is not public in 'com.lifan.pak01.MainMain'. Cannot be accessed from outside package
//        mm01.fun5(); //报错
//        fun5() 在 com.lifan.pak02.MainMain01 中是 protected 访问控制


//        1，不同包总结，不同包的类，只可以访问类控制符为public的类，除2中情况外，只可以访问不同包的类中public的方法和属性
//        2，对于不同包之间有继承关系的类，子类继承自父类的protect方法和属性可以访问，子类新增的protect方法和属性不可以访问


    }
}





class ClassClass00{
    public void fun1(){}
    protected void fun2(){}
    void fun3(){}
    private void fun4(){}
}
