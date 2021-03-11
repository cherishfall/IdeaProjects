package p3;

import p2.Father;

public class Sun extends Father{
    protected void fun5(){}
    void fun6(){}

    public static void main(String[] args){

        Sun s1 = new Sun();
        s1.fun1();
        s1.fun2();
//        s1.fun3();//'fun3()' is not public in 'p2.Father'. Cannot be accessed from outside package
        //其实protected 最典型的用法就是这个，在与父类不同包的子类中【注意前提】，可以通过子类对象直接调用（访问）继承自父类的protected方法
        // 而default和private是不能直接访问的，因为被隐藏了。

        Father f1 = new Father();
        f1.fun1();
//        f1.fun2();//'fun2()' has protected access in 'p2.Father'
//        这就是那句话，在与父类不同包的子类中【注意前提】，
//        只能通过子类对象访问继承自父类的protected方法，不能通过父类对象直接访问父类的protected方法【这应该是最简洁的解释类】
    }
}
