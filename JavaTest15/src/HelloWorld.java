public class HelloWorld {

    public static void main(String []args) {
        System.out.println("Hello World");

        int[] arr = lifan();
        for(int i: arr){
            System.out.println(i);
        }

    }

    static int[] lifan(){
        return new int[]{1, 2, 3};//这种数组定义方式是可行的。
    }
}