package p2;
import p1.Father;

public class Sun extends Father{

//    重写（隐藏）继承自父类的fun2函数
    protected void fun2(){
        super.fun2();
//        super.fun3();// 报错，'fun3()' is not public in 'p1.Father'. Cannot be accessed from outside package
//        super.fun4();// 报错，'fun4()' has private access in 'p1.Father'
        System.out.println("I am Father fun2");
    }

    void test(){

//        fun1继承自父类的protected方法，未被重写
        fun1();
        this.fun1();
        Sun s1 = new Sun();
        s1.fun1();

//        fun2继承自父类的protected方法，被重写
        super.fun2();
//        this.super.fun2();// 报错， Cannot resolve symbol 'super'
        Sun s2 = new Sun();
//        s2.super.fun2();//报错，Class name expected here
    }

    public static void main(String[] args){
        Father f1 = new Father();
//        f1.fun1();// 报错，'fun1()' has protected access in 'p1.Father'
//        f1.fun2();// 报错，'fun2()' has protected access in 'p1.Father'

        Sun s1 = new Sun();
        s1.fun1();
        s1.fun2();
//        s1.fun3();// 报错，'fun3()' is not public in 'p1.Father'. Cannot be accessed from outside package
//        s1.fun4();// 报错，'fun4()' has private access in 'p1.Father'
    }
}

/*
 *
 *protected的总结，或者说访问控制的再一次总结
 * 1，对于同包内，除了private控制符，都可以通过对方对象直接任意调用使用
 * 2，对于不同包呢，出了public控制符和【特殊情况的protected】，都不可以通过对方对象直接调用
 * 3.1 对于不同包中且有继承关系的类，在父类中，可以通过子类对象直接调用【继承自父类的peotected、且未被重写（隐藏）的方法】
 * 【晕晕晕】这个不就是原来父类中的方法嘛，所以这样用，其实是放裤子放屁——没必要
 * 3.2 对于不同包中且有继承关系的类，在子类中，可以通过隐式或显示（this对象、创建新的子类对象）直接调用【继承自父类的peotected的、未被重写（隐藏）方法】
 * 3.3 对于不同包中且有继承关系的类，在子类中，对于【继承自父类的peotected的、已被重写（隐藏）方法】，只可以通过关键字super直接调用
 *
 * 对于继承的理解
 * 继承是子类【获得】父类，也可以理解成子类中包含了一个父类对象，但【获得】不意味着子类可以直接访问【获得的全部】
 * 1，对于同包继承，private方法和成员不继承【这里的不继承的意思是不能在子类中直接调用】
 * 2，对于不同包继承，default和private方法和成员不继承【这里的不继承的意思是不能在子类中直接调用】
 * 3，对于构造器/构造方法，尚且还有点模糊。一般来说的意义是构造器不继承
 *
 */
