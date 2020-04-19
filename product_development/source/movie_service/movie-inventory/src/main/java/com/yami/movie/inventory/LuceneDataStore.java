package com.yami.movie.inventory;

import com.google.gson.Gson;
import com.yami.movie.inventory.search.FieldBoosterFeature;
import com.yami.movie.inventory.search.FuzzySearchQuery;
import com.yami.movie.inventory.search.SearchQuery;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.*;
import org.apache.lucene.index.*;
import org.apache.lucene.search.*;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import java.io.IOException;
import java.lang.reflect.Type;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

public class LuceneDataStore<T, O> implements DataStore<T, O> {

    private Gson gson = new Gson();
    StandardAnalyzer analyzer = new StandardAnalyzer();
    Directory index;
    IndexWriterConfig config;
    IndexWriter w;

    private String fileStore;

    private Type outputType;

    public LuceneDataStore(String fileStore, Type outputType) throws IOException {
        this.fileStore = fileStore;
        index = FSDirectory.open(Paths.get(fileStore));
        config = new IndexWriterConfig(analyzer);
        w = new IndexWriter(index, config);
        this.outputType = outputType;
    }


    public void add(O baseDocument) throws IOException {
        T doc = getDocument(baseDocument);
        w.addDocument((Document) doc);
        w.commit();
    }

    public void update(O baseDocument) {

    }

    public void delete(O baseDocument) {

    }

    @Override
    public T getDocument(O baseDocument) {
        Document doc = new Document();
        String json = gson.toJson(baseDocument);
        JSONObject object = convertToJsonObject(json);
        for (String field : (Set<String>) object.keySet()) {
            Class type = object.get(field).getClass();
            if (type.equals(String.class)) {
                doc.add(new TextField(field, (String) object.get(field), Field.Store.YES));
            } else if (type.equals(Long.class)) {
                doc.add(new LongPoint(field, (long) object.get(field)));
            } else if (type.equals(Double.class)) {
                doc.add(new DoublePoint(field, (double) object.get(field)));
            } else if (type.equals(Boolean.class)) {
                doc.add(new StringField(field, object.get(field).toString(), Field.Store.YES));
            } else if (type.equals(JSONArray.class)) {
                JSONArray arr = (JSONArray) object.get(field);
                for (Object e : arr) {
                    String jsonObject = String.valueOf(e);
                    doc.add(new StringField(field, jsonObject, Field.Store.YES));
                }
            }
        }
        doc.add(new StringField("_json", json, Field.Store.YES));
        return (T) doc;
    }

    public List<O> search(SearchQuery query) throws IOException {
        Query luceneQuery = getLuceneQuery(query);
        List<O> result = search(luceneQuery);
        System.out.println("Found " + result.size() + " hits for " + query);
        return result;
    }

    @Override
    public List<O> getAllDocuments() throws IOException {
        Query luceneQuery = new MatchAllDocsQuery();
        return search(luceneQuery);
    }


    private Query getLuceneQuery(SearchQuery query) {
        BooleanQuery.Builder builder = new BooleanQuery.Builder();
        for (FuzzySearchQuery fuzzyField : query.getFuzzyFields()) {
            builder.add(new FuzzyQuery(new Term(fuzzyField.getKey(), fuzzyField.getValue())), BooleanClause.Occur.SHOULD);
        }
        Query originalQuery = builder.build();

        FieldBoosterFeature fieldBooster = query.getFieldBoosterFeature();
        BooleanQuery.Builder builder1 = new BooleanQuery.Builder();
        builder1.add(originalQuery, BooleanClause.Occur.SHOULD);
        if (fieldBooster != null) {
            Query featureQuery = FeatureField.newSaturationQuery(fieldBooster.getField(), fieldBooster.getFeature());
            builder1.add(new BoostQuery(featureQuery, fieldBooster.getBoost()), BooleanClause.Occur.SHOULD);
        }

        return builder1.build();

    }

    private JSONObject convertToJsonObject(String json) {
        return (JSONObject) JSONValue.parse(json);
    }

    private List<O> search(Query luceneQuery) throws IOException {
        List<O> pojoList = new ArrayList<>();
//        List<Document> result = new ArrayList<>();
        int hitsPerPage = 10;
        IndexReader reader = DirectoryReader.open(index);
        IndexSearcher searcher = new IndexSearcher(reader);
//        searcher.setSimilarity(new CustomSimilarityBase());
        TopScoreDocCollector collector = TopScoreDocCollector.create(hitsPerPage, 1);
        searcher.search(luceneQuery, collector);
        ScoreDoc[] hits = collector.topDocs().scoreDocs;

        for (int i = 0; i < hits.length; ++i) {
            int docId = hits[i].doc;
            Document d = searcher.doc(docId);
//            result.add(d);
//            System.out.println(d.get("isbn"));
            pojoList.add(gson.fromJson(d.get("_json"), outputType));
        }
        reader.close();
        return pojoList;
    }
}
