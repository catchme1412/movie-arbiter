package com.yami.grocery;

import org.json.simple.parser.ParseException;
import org.junit.Test;

import java.io.IOException;

import static org.junit.Assert.*;

public class GroceryServiceTest {

    @Test
    public void getProductCategory() throws IOException, ParseException {
        new GroceryService().getProductCategory();
    }
}