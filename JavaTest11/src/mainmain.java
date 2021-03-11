import com.sun.org.apache.bcel.internal.generic.ARETURN;

public class mainmain {
    public static void main(String[] args){
        c1 t1 = new c1();
    }

}

class c1{
    static final int a = 0;
    static final int b = fun1();//可以调用方法初始化
//    static final int b;// 报错，Variable 'b' might not have been initialized
//    也就是static final 属性必须在定义时初始化

    final int c = 1;
    final int d; // 非静态的final可以在定义时也可以在够在器里初始化
    //d是先被默认初始化初始化成0，然后被构造器初始化，因为同是初始化，所以也看成一个初始化。
    final int e = c2.fun1();
//    final int f;// 报错，Variable 'f' might not have been initialized
//    也就是说 final变量必须显示初始化

    c1(){
        d = 2;
//        e = 5;// 报错，Cannot assign a value to final variable 'e'
//        也就是说对于对象 final的属性 显式的初始化，有且只能有一次，要么在定义处，要么在构造器里
    }

    static int fun1(){
        return 0;
    }
}

class  c2{
    static int fun1(){
        return 3;
    }
}