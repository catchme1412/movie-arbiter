package com.yami.common.json.store;

import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.io.*;
import java.util.Map;

public class JsonFileStore {

    public JSONArray getJsonArray(String jsonFile) throws IOException, ParseException {
        //JSON parser object to parse read file
        JSONParser jsonParser = new JSONParser();
        JSONArray jsonArray = null;
        InputStream inputStream = getClass().getClassLoader().getResourceAsStream(jsonFile);

        try (InputStreamReader reader = new InputStreamReader(inputStream)) {
            //Read JSON file
            Object obj = jsonParser.parse(reader);
            jsonArray = (JSONArray) obj;
        }
        return jsonArray;
    }


}
