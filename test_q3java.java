/**
 * Javadoc comment for Stack class
 */
package com.example;

import java.util.ArrayList;

// Single line comment

public class Stack<T> {

    /* Block comment */
    private ArrayList<T> data;
    private int size;
    private static final int MAX = 0xFF;
    private static final long BIG = 100L;
    private static final int BIN = 0b1010;
    private static final double PI = 3.14d;
    private static final float E  = 2.71f;

    public Stack() {
        this.data = new ArrayList<>();
        this.size = 0;
    }

    public void push(T item) {
        if (size >= MAX) throw new RuntimeException("full");
        data.add(item);
        ++size;
    }

    public T pop() throws Exception {
        if (size == 0) throw new Exception("empty");
        return data.get(--size);
    }

    public boolean isEmpty() {
        return size == 0;
    }

    public static void main(String[] args) {
        Stack<Integer> s = new Stack<>();
        s.push(42);
        s.push(0x1A);

        int x = 10, y = 20;
        int z = (x >= y) ? x : y;
        int w = (x << 2) | (y >> 1);
        int u = x >>> 1;
        boolean flag = (x == y) || (x != 0) && !(y <= 0);

        Runnable r = () -> System.out.println("lambda");
        java.util.function.Function<Integer,Integer> sq = x2 -> x2 * x2;

        @SuppressWarnings("unused")
        String msg = "hello \"world\"";
        char c = '\n';

        System.out.println("z = " + z);
    }
}
