public class mainmain {

}

class c1{
    void fun0(){
        System.out.println("i am c1 instance");
    }

    static void fun1(){
        System.out.println("i am c1 static");
    }

    final void fun2(){
        System.out.println("i am c1 final");
    }

    private void fun3(){
        System.out.println("i am c1 private");
    }
}

class c2 extends c1{
//    static void fun0(){} // 报错，Static method 'fun0()' in 'c2' cannot override instance method 'fun0()' in 'c1'
    void fun0(){}
//    静态方法不能重写实例方法，实例方法只能实例方法重写

//    void fun1(){} // 报错，Instance method 'fun1()' in 'c2' cannot override static method 'fun1()' in 'c1
    static void fun1(){}
//    实例方法不能重写静态方法，静态方法只能静态方法重写

//    void fun2(){}// 报错，'fun2()' cannot override 'fun2()' in 'c1'; overridden method is final
//    final void fun2(){} // 报错，'fun2()' cannot override 'fun2()' in 'c1'; overridden method is final
//    static void fun2(){} // 报错，Static method 'fun2()' in 'c2' cannot override instance method 'fun2()' in 'c1'
//    final 修饰的方法，是无论如何不能重写的

    private void fun3(){} // 对的
//    根据onjava8，私有方法可以获得，但不可继承其接口，也就是说私有方法除了你知道有这个，其他之外都是不影响的
//    这里的同名函数表面是【重写方法】，其实是【新增方法】
//    私有方法也是隐式的final方法，因为无论如何private方法都不会被重写，
}