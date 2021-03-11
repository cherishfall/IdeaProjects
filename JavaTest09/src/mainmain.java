public class mainmain {
   public static void main(String[] args){
       c1 t1 = new c2();
       System.out.println(t1.a); // 0，但是属性是不支持多态的，向上转型，任何属性访问都被编译器解析了，不是后期的，是前期的
       System.out.println(t1.getA()); //1, 方法是支持多态的

       c2 t2 = new c2();
       System.out.println(t2.a); //1
       System.out.println(t2.getA());//1
       System.out.println(t2.getSuperA());//0





   }
}

class c1{
    int a = 0;

    public int getA() {
        return a;
    }
}

class c2 extends c1{
    int a = 1;

    @Override
    public int getA() {
        return a;
    }

    public int getSuperA(){
        return super.a;
    }
}


