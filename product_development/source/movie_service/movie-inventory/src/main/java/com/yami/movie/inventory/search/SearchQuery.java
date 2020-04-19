package com.yami.movie.inventory.search;

import java.util.ArrayList;
import java.util.List;

public class SearchQuery {

    private List<FuzzySearchQuery> fuzzyFields;

    private FieldBoosterFeature fieldBoosterFeature;

    public SearchQuery() {
        fuzzyFields = new ArrayList<>();
    }

    public List<FuzzySearchQuery> getFuzzyFields() {
        return fuzzyFields;
    }

    public void addFuzzyField(String field, String value) {
        FuzzySearchQuery fuzzySearchQuery = new FuzzySearchQuery();
        fuzzySearchQuery.setKey(field);
        fuzzySearchQuery.setValue(value);
        fuzzyFields.add(fuzzySearchQuery);
    }

    public void setFuzzyFields(List<FuzzySearchQuery> fuzzyFields) {
        this.fuzzyFields = fuzzyFields;
    }

    public FieldBoosterFeature getFieldBoosterFeature() {
        return fieldBoosterFeature;
    }

    public void setFieldBoost(String field, String featureValue, float boost) {
        fieldBoosterFeature = new FieldBoosterFeature();
        fieldBoosterFeature.setField(field);
        fieldBoosterFeature.setFeature(featureValue);
        fieldBoosterFeature.setBoost(boost);
    }
    public void setFieldBoosterFeatures(FieldBoosterFeature fieldBoosterFeature) {
        this.fieldBoosterFeature = fieldBoosterFeature;
    }

    @Override
    public String toString() {
        return "SearchQuery{" +
                fuzzyFields +
                ", " + fieldBoosterFeature +
                '}';
    }
}
