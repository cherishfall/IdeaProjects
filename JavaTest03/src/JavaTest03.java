
//public enum Week{ } //报错
//Class 'Week' is public, should be declared in a file named 'Week.java'
//所以 枚举还真是个类哦，只是用了enum这个关键字

enum Week{
    YI, ER, SAN, SI, WU, LIU, QI, BA, JIU,
}


public class JavaTest03 {
    public static void main(String[] args){
        for(Week i: Week.values()){
            System.out.println(i.toString()+" : "+i.ordinal());
        }

        Week day = Week.YI;

        switch(day){ //意思是编译器其实能识别出day是Week类型，所以下面的标签不需要再家Week前缀
            case YI:
                System.out.println(day.toString());
                break;
//            case Week.ER://报错
//            枚举 switch case 标签必须为枚举常量的非限定名称
            case ER:
                System.out.println(day.toString());
                break;
            default:
                System.out.println(day.toString());
        }

    }
}
