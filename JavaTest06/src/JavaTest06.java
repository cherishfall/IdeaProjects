public class JavaTest06 {


    public static void main(String[] args){
        System.out.println("main");
        Test1 t1 = new Test1();
        System.out.println("main");
//        main
//        类属性1
//        实例属性1
//        构造器1
//        main

        System.out.println("main");
        int a = Test2.f1();
        System.out.println("main");

//        main
//        类属性2 这个是初始化类属性时候输出的
//        类属性2 这个是调用静态方法输出的
//        main


//        所以还是类属性，实例属性和构造器的顺序
//        没有用到的就不初化
//        静态属性只初始化一次
    }
}

class Test1{
    static int a = f1();
    int b = f2();

    Test1(){
        System.out.println("构造器1");
    }

    static int f1(){
        System.out.println("类属性1");
        return 1;
    }

    static int f2(){
        System.out.println("实例属性1");
        return 2;
    }
}

class Test2{
    static int a = f1();
    int b = f2();

    Test2(){
        System.out.println("构造器2");
    }

    static int f1(){
        System.out.println("类属性2");
        return 1;
    }

   int f2(){
        System.out.println("实例属性2");
        return 2;
    }

}

class Test3{
    static int a = f1();

    int b = f2();

    Test3(){
        System.out.println("构造器3");
    }

    static int f1(){
        System.out.println("类属性3");
        return 1;
    }

    static int f2(){
        System.out.println("实例属性3");
        return 2;
    }
}
