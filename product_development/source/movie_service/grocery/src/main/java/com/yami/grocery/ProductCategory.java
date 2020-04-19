package com.yami.grocery;

import java.util.List;
import java.util.Map;

public class ProductCategory {

    private String category;

    private Map<String, String> label;

    private List<ProductCategory> subCategory;

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public List<ProductCategory> getSubCategory() {
        return subCategory;
    }

    public void setSubCategory(List<ProductCategory> subCategory) {
        this.subCategory = subCategory;
    }

    public Map<String, String> getLabel() {
        return label;
    }

    public void setLabel(Map<String, String> label) {
        this.label = label;
    }
}
