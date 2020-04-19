package com.yami.graph;

public class Vertex<T> {

    private T obj;
    private String label;

    public Vertex(String label, T obj) {
        this.label = label;
        this.obj = obj;
    }

    public T getObject() {
        return obj;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }
}
