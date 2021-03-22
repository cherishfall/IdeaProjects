import java.io.*;
class test
{
    public static void main (String[] args) throws java.lang.Exception
    {
        System.out.println("hi");
//        <nulltype>无法转换为boolean
//        if(null) System.out.println("null");
//        if(!null) System.out.println("! null");

        String str = null;
        if(str == null) System.out.println("null");
    }
}