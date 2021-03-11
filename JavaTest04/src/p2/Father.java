package p2;
import p3.Sun;

public class Father {
    public void fun1(){}
    protected void fun2(){}
    void fun3(){}
    private void fun4(){}

    public static void main(String[] args){
        Sun s1 = new Sun();
        s1.fun1();//这个没啥好说的
        s1.fun2();//其实就这个地方挺奇怪的，
        // 在与子类不同包的父类中【注意前提】，可以通过子类对象直接访问子类的protected方法
        // 而不能通过子类对象直接访问子类的default 和 provate 方法

        //以下总结为不同包，同包只要不是private，随便相互访问
        // 总结，在具有继承关系的类中【注意前提】
        // 在子类中，可以通过子类对象直接访问继承自父类的protected方法
        // 在父类中，也可以通过子类对象直接访问继承自父类的protected方法

        //【注意】不管是在子类还是父类中，都不能通过对象直接访问没有继承关系的protected方法
        //1，在子类中，不可以通过父类对象直接访问父类的protected方法
        //2，在父类中，不可以通过子类对象直接访问子类新增的protected方法

    }
}
