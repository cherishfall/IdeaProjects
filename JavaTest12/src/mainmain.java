public class mainmain {
    public static void main(String[] args){

        C1 t0 = new C1(1);
//        C1.C2 t2 = new C1.C2(); //内部类不能单独实例化，只能生创建一个外部类对象，然后再在用外部类实例化内部类
        C1.C2 t11 = t0.new C2(); // 这样就可以用t1生成的内部类对象t11访问t1的所有属性了，包括私有属性。
        System.out.println(t11.getA()); //1

        C1 t1 = new C1(11);
        C1.C2 t2 = new C1().new C2();//这样可以 感觉这样的写法是不是要好一些哦
        C1.C2 t3 = new C1(). new C2(); //这样也可以
        System.out.println(t2.getA());// 0

        //所以对普通的内部类的理解，一定是先创建一个外部类对象，然后通过这个外部类对象创建一个内部类对象
    }

}

class C1{
    private int a;
    C1(){}
    C1(int a){
        this.a = a;
    }
    class C2{
//        内部类
        int getA(){
            return C1.this.a;
        }
    }

    C2 getC2(){
        return new C2();
    }

}
