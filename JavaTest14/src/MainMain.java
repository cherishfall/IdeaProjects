public class MainMain {
    public static void main(String[] args) {
        int a = 1;
        System.out.println("main: a-" + a);
        fun1(a);
        System.out.println("after fun1, main a:-"+a);


        T t1 = new T(1);
        System.out.println(t1.a);
        T t2 = fun2(t1);
        System.out.println(t1.a);// 没变，t1.a 还是 1
        System.out.println(t2.a);

//        不管是基本类型变量的值传递，还是引用类型的引用传递，其实都是赋值传递
//        意思就是实参和形参的关系是 形参=实参，形参是在调用方法栈中新定义的
//        如果是基本类型，是相互隔离的
//        如果是引用类型，使用引用变量修改其指向堆中的数据是可以
//        但是单纯改变引用本身是相互隔离的，和传指针一样，如果是用指针修改指向的内容是可以，但修改指针本身是相互隔离的

    }

    static void fun1(int val){
        val = 2;
        System.out.println("fun1: a-" + val);
    }

    static T fun2(T tt){
        tt = new T(2);
        return tt;
    }
}

class T{
    int a;
    T(){}
    T(int val) {a = val;}
}
