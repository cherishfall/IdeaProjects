public class JavaTest02 {
    public static void main(String[] args){

        int a = 10, b = a+1;//这个不也是对的吗，逗号表达式，这个地方不要太深究了吧。

        for(int i = 0, x = i+1; i < 10; i++){
            System.out.println(i);
            int j = i;
            System.out.println(j);
        }

//        i = 11;//报错
//        Cannot resolve symbol 'i'，
//        看来块作用域还是块作用域，在块中定义的变量出了块就被回收了，但是哦，java不能更小的块作用域中的变量隐藏/屏蔽更大块作用域中的变量
//        c和c++中都是支持的



    }
}
