package com.yami.grocery;

import com.google.gson.reflect.TypeToken;
import org.junit.Assert;
import org.junit.Test;

import java.io.IOException;
import java.util.List;

public class JsonUtilTest {

    @Test
    public void getJsonMap() throws IOException {
        JsonUtil jsonUtil = new JsonUtil();
        List<ProductCategory> r = jsonUtil.getJsonList("product-category-list.json", new TypeToken<List<ProductCategory>>() {}.getType());
        Assert.assertNotNull(r.get(0).getCategory() != null);
    }
}