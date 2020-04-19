package com.yami.grocery;

import java.util.List;

public class ProductCategoryList {

    private List<ProductCategory> productCategories;

    public List<ProductCategory> getProductCategories() {
        return productCategories;
    }

    public void setProductCategories(List<ProductCategory> productCategories) {
        this.productCategories = productCategories;
    }

    public void add(ProductCategory productCategory) {
        productCategories.add(productCategory);
    }
}
