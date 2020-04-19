package com.yami.grocery;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import org.json.simple.JSONObject;

import java.io.IOException;
import java.lang.reflect.Type;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;

public class JsonUtil {

    private Gson gson = new Gson();

    public Map<String, Object> toMap(JSONObject object) {
        Map<String, Object> map = new HashMap<String, Object>();

        Set entries = object.keySet();
        Iterator itr = entries.iterator();
        while (itr.hasNext()) {
            String key = (String) itr.next();
            Object value = object.get(key);
            map.put(key, value);
        }
//        Iterator<String> keysItr = object.entrySet();
//        while(keysItr.hasNext()) {
//            String key = keysItr.next();
//            Object value = object.get(key);
//
//            if(value instanceof JSONArray) {
//                value = toList((JSONArray) value);
//            }
//
//            else if(value instanceof JSONObject) {
//                value = toMap((JSONObject) value);
//            }
//            map.put(key, value);
//        }
        return map;
    }

//    public static List<Object> toList(JSONArray array) throws JSONException {
//        List<Object> list = new ArrayList<Object>();
//        for(int i = 0; i < array.length(); i++) {
//            Object value = array.get(i);
//            if(value instanceof JSONArray) {
//                value = toList((JSONArray) value);
//            }
//
//            else if(value instanceof JSONObject) {
//                value = toMap((JSONObject) value);
//            }
//            list.add(value);
//        }
//        return list;
//    }

    public List getJsonArray(String fileName) throws IOException {
        URL url = getClass().getClassLoader().getResource(fileName);
        String json = new String(Files.readAllBytes(Paths.get(url.getPath())));
        List map = gson.fromJson(json, List.class);
        return map;
    }
    public <T> List<T> getJsonList(String fileName, Type type) throws IOException {
        URL url = getClass().getClassLoader().getResource(fileName);
        String json = new String(Files.readAllBytes(Paths.get(url.getPath())));
        List<T> nameEmployeeMap = gson.fromJson(json, type);
        System.out.println(nameEmployeeMap.get(0).getClass());
        return nameEmployeeMap;
    }


    public Map getJsonList(String fileName) throws IOException {
        URL url = getClass().getClassLoader().getResource(fileName);
        String json = new String(Files.readAllBytes(Paths.get(url.getPath())));
        Map map = gson.fromJson(json, Map.class);
        return map;
    }
}
