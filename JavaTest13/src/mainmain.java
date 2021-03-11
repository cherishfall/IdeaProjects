public class mainmain
{
    public static void main(String[] args){
        System.out.println("C1 i: "+ C1.i);
        System.out.println("C2 i, j:" + C2.i + ", " +C2.j);
//        C1 i: 1
//        C2 i, j:1, 22

        C1.seti(11);
        C2.setJ(22);

        System.out.println("C1 i: "+ C1.i);
        System.out.println("C2 i, j:" + C2.i + ", " + C2.j);
//        C1 i: 11
//        C2 i, j:11, 22

//        小结
//        1）子类是不继承父类的static变量和方法的。因为这是属于类本身的。但是子类是可以访问的。
//        2）子类和父类中同名的static变量和方法都是相互独立的，并不存在任何的重写的关系。

//        修饰为 static  、 final 、private 的方法一定是前期绑定，因为他们根本都不存在override。
        C1.seti(1);
        System.out.println("C1 i: "+ C1.i);
        System.out.println("C3 i: "+ C3.i);
        C1.seti(11);
        System.out.println("C1 i: "+ C1.i);
        System.out.println("C3 i: "+ C3.i);
        System.out.println("C3 i: "+ C3.i);
//        C1 i: 1
//        C3 i: 3
//        C1 i: 11
//        C3 i: 3
//      总结，其实这些都要归结为继承的实现机制，而不是继承的概念。从概念上说，非常容易说，（同包）构造器、私有变量方法不继承，但是这个
//        不继承到底是啥意思，其实是没有获得直接访问权限。所以继承是全部获得、部分可访问的意思。
//        静态属性和实例属性，都是继承的，但是实例属性是对象持有的，静态属性是类持有。实例属性各个对象独立，不相互影响。如果没有在子类中
//        没有定义和父类中同名的属性，那么可以直接使用父类中的静态属性（同一份，相互影响）
//        如果在子类中定义和父类中同名属性（可以类型不一样），那么父类中的属性就被隐藏了，注意，如果向上转型，那用的就是父类中的属性
//        【才意识到一个事儿】其实只有对象是可以向上转型的，类是没有向上转型这一说的。如果是用多态，使用的是肯定是父类的静态变量和静态方法
//        静态变量和静态方法其实不叫重写，而是隐藏（前期绑定）。对象属性和对象方法才可以重写（可以用于多态，后期绑定）吧。


    }
}

class C1{
    static int i = 1;

    static int geti(){
        return i;
    }

    static void seti(int a){
        i = a;
    }
}

class C2 extends C1{
    static int j = 2;
    static int getJ(){
        return j;
    }

    static void setJ(int a){
        j = a;
    }
}

class C3 extends C1{
    static int i = 3;
    static void geti(int a){
        i = a;
    }
}

class C4 extends C1{
    double i;
}

