package com.yami.grocery;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.yami.common.json.store.JsonFileStore;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class GroceryService {

    private JsonUtil jsonUtil = new JsonUtil();
    public static void main(String[] args) {
        new GroceryService().start();
    }

    public void start() {

    }

    public ProductCategoryList getProductCategory() throws IOException, ParseException {
        ProductCategoryList productCategoryList = new ProductCategoryList();
        List<Map<String, Object>> productCategories = jsonUtil.getJsonArray("product-category.json");
//        List<Map<String, Object>> productCategoriesDetails = jsonUtil.getJsonArray("product-category-list.json");
        List<ProductCategory> productCategoriesDetails = jsonUtil.getJsonList("product-category-list.json", new TypeToken<List<ProductCategory>>() {}.getType());
        System.out.println(productCategories);
        System.out.println(productCategoriesDetails);

        Map<String, Map<String, String>> result2 = productCategoriesDetails.stream().collect(
                Collectors.toMap(ProductCategory::getCategory, ProductCategory::getLabel));

        for (Map<String, Object> productCategory : productCategories) {
            System.out.println(">>>" + productCategory);
            List<String> subcategories = (List<String>) productCategory.get("subCategory");
            for(String subcategory : subcategories) {
                System.out.println("subCategory:" +subcategory);

            }
        }
        return null;
    }
}
