package p1;
import p2.Father;
import p3.Sun;

public class Run {
    public static void main(String[] args){
        Father f1 = new Father();
        f1.fun1();

        Sun s1 = new Sun();
        s1.fun1();

        //位于不同包中的类，在没有继承关系的类中
        //只能通过类的对象访问该对象的public方法，其他方法一律不能访问。
    }

}
