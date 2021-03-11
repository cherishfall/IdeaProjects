package p1;

import p2.Sun;

public class Father {
    protected void fun1(){}

    protected void fun2(){
        System.out.println("I am Father fun2");
    }

    void fun3(){}

    private void fun4(){}

    public static void main(String[] args){
        Sun s1 = new Sun();
        s1.fun1(); //其实，我倾向于这个不是这么刻意设计的，而是没注意到这个设计，这个确实也很不好理解
        //在父类的方法中，可以通过子类对象直接调用子类对象没有被重写过的方法（确实很拗口哦）
//        s1.fun2();// 报错，'fun2()' has protected access in 'p2.Sun'
//        s1.super.fun2();// 报错，Class name expected here
    }
}
