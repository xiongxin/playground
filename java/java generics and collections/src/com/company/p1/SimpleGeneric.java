package com.company.p1;

public class SimpleGeneric<T> {
    T t;

    SimpleGeneric(T t) {
        this.t = t;
    }

    void erased(T t) {
        // 无法使用泛型创建对象
        // T nt = new T();

        // 无法使用泛型创建数组
        // T[] arr = new T[];

        // 无法针对泛型执行实例判断
        // if(t instanceof T){
        //     ...
        // }
    }

    T getTarget() {
        return t;
    }

    public static void main(String[] args) {
        SimpleGeneric<String> strSg = new SimpleGeneric<>("hello");
        String str = strSg.getTarget();
    }
}
