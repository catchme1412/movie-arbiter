package com.yami.movie.inventory.search;

public class FieldBoosterFeature {

    private String field;
    private String feature;
    private float boost;

    public String getField() {
        return field;
    }

    public void setField(String field) {
        this.field = field;
    }

    public String getFeature() {
        return feature;
    }

    public void setFeature(String feature) {
        this.feature = feature;
    }

    public float getBoost() {
        return boost;
    }

    public void setBoost(float boost) {
        this.boost = boost;
    }

    @Override
    public String toString() {
        return "{" +
                "boost: '" + field + '\'' +
                "='" + feature + '\'' +
                ", boost=" + boost +
                '}';
    }
}
