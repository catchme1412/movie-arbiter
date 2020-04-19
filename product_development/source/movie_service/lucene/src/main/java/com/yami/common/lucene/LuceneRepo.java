package com.yami.common.lucene;

import jdk.nashorn.internal.parser.JSONParser;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.*;
import org.apache.lucene.index.*;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.search.*;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.store.RAMDirectory;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

public class LuceneRepo {
    StandardAnalyzer analyzer = new StandardAnalyzer();
//    Directory index = new RAMDirectory();
    Directory index = FSDirectory.open(Paths.get("/tmp/test.db"));
    IndexWriterConfig config = new IndexWriterConfig(analyzer);
    IndexWriter w = new IndexWriter(index, config);

    public LuceneRepo() throws IOException {
    }

    @SuppressWarnings("deprecation")
    public static void main(String[] args) throws IOException, ParseException {

        LuceneRepo luceneRepo = new LuceneRepo();
        IndexWriter w = luceneRepo.getIndexWriter();
        luceneRepo.addDoc("{\"title\":\"Lucene in Action\", \"isbn\":\"1\"}");
        luceneRepo.addDoc("{\"title\":\"Lucene for Dummies\", \"isbn\":\"2\"}");

        luceneRepo.addDoc(w, "Java", "3");
        luceneRepo.addDoc(w, "Oracle", "4");
        luceneRepo.addDoc(w, "Dummies", "6");
        luceneRepo.addDoc(w, "A & Lucene  & Java for Dummies", "5");
        w.close();
        Query query = luceneRepo.getQuery();
        luceneRepo.search(query);

        Query originalQuery = new BooleanQuery.Builder()
                .add(new FuzzyQuery(new Term("title", "lucesen")), BooleanClause.Occur.SHOULD)
                .build();
        System.out.println("=============================");
        luceneRepo.search(originalQuery);
        return;
    }

    private  Query getQuery() {
        Query originalQuery = new BooleanQuery.Builder()
                .add(new FuzzyQuery(new Term("title", "lucesen")), BooleanClause.Occur.SHOULD)
                .build();
        Query featureQuery = FeatureField.newSaturationQuery("isbn", "5");
        return new BooleanQuery.Builder()
                .add(originalQuery, BooleanClause.Occur.SHOULD)
                .add(new BoostQuery(featureQuery, .5f), BooleanClause.Occur.SHOULD)
                .build();
    }

    private List<Document> search(Query customQuery) throws IOException {
        List<Document> result = new ArrayList<>();
        int hitsPerPage = 10;
        IndexReader reader = DirectoryReader.open(getIndex());
        IndexSearcher searcher = new IndexSearcher(reader);
//        searcher.setSimilarity(new CustomSimilarityBase());
        TopScoreDocCollector collector = TopScoreDocCollector.create(hitsPerPage, 1);
        searcher.search(customQuery, collector);
        ScoreDoc[] hits = collector.topDocs().scoreDocs;

        System.out.println("Found " + hits.length + " hits.");
        for (int i = 0; i < hits.length; ++i) {
            int docId = hits[i].doc;
            Document d = searcher.doc(docId);
            result.add(d);
            System.out.println(d.get("isbn"));
            System.out.println(d.get("title"));
        }
        reader.close();
        return result;
    }

    private IndexWriter getIndexWriter() {
        return w;
    }

    public Directory getIndex() {
        return index;
    }

    private void addDoc(IndexWriter w, String title, String isbn) throws IOException {
        Document doc = new Document();
        doc.add(new TextField("title", title, Field.Store.YES));
        doc.add(new TextField("isbn", isbn, Field.Store.YES));
        w.addDocument(doc);
    }

    private void addDoc(String json) throws IOException {
        Document doc = new Document();
        JSONObject object = convertToJsonObject(json);
        for(String field : (Set<String>) object.keySet()){
            Class type = object.get(field).getClass();
            if(type.equals(String.class)){
                doc.add(new TextField(field, (String)object.get(field), Field.Store.YES));
            }else if(type.equals(Long.class)){
                doc.add(new LongPoint(field, (long)object.get(field)));
            }else if(type.equals(Double.class)){
                doc.add(new DoublePoint(field, (double)object.get(field)));
            }else if(type.equals(Boolean.class)){
                doc.add(new StringField(field, object.get(field).toString(), Field.Store.YES));
            }
        }
        try {
            w.addDocument(doc);
        } catch (IOException ex) {
            System.err.println("Error adding documents to the index. " +  ex.getMessage());
        }
//        doc.add(new TextField("title", title, Field.Store.YES));
//        doc.add(new TextField("isbn", isbn, Field.Store.YES));
    }

    private JSONObject convertToJsonObject(String json) {
        return (JSONObject) JSONValue.parse(json);
    }
    /**
     * Add documents to the index
     */
    public void addDocuments(JSONArray jsonObjects){
        for(JSONObject object : (List<JSONObject>) jsonObjects){
            Document doc = new Document();
            for(String field : (Set<String>) object.keySet()){
                Class type = object.get(field).getClass();
                if(type.equals(String.class)){
                    doc.add(new TextField(field, (String)object.get(field), Field.Store.YES));
                }else if(type.equals(Long.class)){
                    doc.add(new LongPoint(field, (long)object.get(field)));
                }else if(type.equals(Double.class)){
                    doc.add(new DoublePoint(field, (double)object.get(field)));
                }else if(type.equals(Boolean.class)){
                    doc.add(new StringField(field, object.get(field).toString(), Field.Store.YES));
                }
            }
            try {
                w.addDocument(doc);
            } catch (IOException ex) {
                System.err.println("Error adding documents to the index. " +  ex.getMessage());
            }
        }
    }


//    /**
//     * Parse a Json file. The file path should be included in the constructor
//     */
//    public JSONArray parseJSONFile(String json){
//        ObjectMapper mapper = new ObjectMapper();
//        // convert to json object
//        JsonNode jsonNode = mapper.readTree(json);
//
//
//        return arrayObjects;
//    }
}
