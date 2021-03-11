public class MainMain {
    void fun1(){
        System.out.println("lifan");
    }

    public static void main(String[] args){
        MainMain mm = new MainMain();
        mm.fun1();
        //类的静态方法不能直接调用类的实例方法，但是可以在类的静态方法里可以先创建一个实例，再调用
        //重点是不能【直接调用】——不生成实例，调用
    }
}
