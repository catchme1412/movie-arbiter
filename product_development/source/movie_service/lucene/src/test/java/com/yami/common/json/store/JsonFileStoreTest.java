package com.yami.common.json.store;

import org.json.simple.JSONArray;
import org.json.simple.parser.ParseException;
import org.junit.Assert;
import org.junit.Test;

import java.io.IOException;

import static org.junit.Assert.*;

public class JsonFileStoreTest {


    @Test
    public void getJsonArray() throws IOException, ParseException {
        JsonFileStore jsonFileStore = new JsonFileStore();
        JSONArray employees = jsonFileStore.getJsonArray("employee.json");
        Assert.assertNotNull(employees);
        Assert.assertEquals(employees.size(), 2);
    }
}