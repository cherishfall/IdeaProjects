public class mainmain {
    public static void main(String[] args){
        new c2();

//        0 - c1 static a
//        1 - c2 static c
//        2 - c1 instance b
//        3 - c1 构造器
//        4 - c2 instance d
//        5 - c2 构造器

        //所以顺序是
        // 1先初始化基类的静态属性和派生类的静态属性
        // 2基类的实例属性和实例方法
        // 3派生类的实例属性和实例方法

    }
}

class out{
    static int i = 0;
    static int print(String str){
        System.out.println(i + " - "+str);
        return i++;
    }
}

class c1{
    static int a = out.print("c1 static a");
    int b = out.print("c1 instance b");
    c1(){
        out.print("c1 构造器");
    }

}

class c2 extends c1{
    static int c = out.print("c2 static c");
    int d = out.print("c2 instance d");

    c2(){
        out.print("c2 构造器");
    }
}

