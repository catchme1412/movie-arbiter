package com.yami.common.lucene;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.*;
import org.apache.lucene.index.*;
import org.apache.lucene.search.*;
import org.apache.lucene.store.RAMDirectory;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

public class LuceneRepository {


    private IndexWriter indexWriter;
    private RAMDirectory index;

    public void init() throws IOException {
        StandardAnalyzer analyzer = new StandardAnalyzer();
        index = new RAMDirectory();

        IndexWriterConfig config = new IndexWriterConfig(analyzer);
        indexWriter = new IndexWriter(index, config);
    }

    public static void main(String[] args) throws IOException {
        LuceneRepository luceneRepository = new LuceneRepository();
        luceneRepository.init();
        String json = "{\"title\":\"Lucene in action\", \"category\":\"technical\"}";
        luceneRepository.addDocument(json);
        json = "{\"title\":\"dummies for science\", \"category\":\"novel\"}";
        luceneRepository.addDocument(json);
        luceneRepository.closeIndexWriter();
        Query query = null;
        Query originalQuery = new BooleanQuery.Builder()
                .add(new FuzzyQuery(new Term("title", "lucesen")), BooleanClause.Occur.SHOULD)
                .build();
        List<Document> result = luceneRepository.search(luceneRepository.getQuery());
        System.out.println(result);
    }

    private Query getQuery() {
        Query originalQuery = new BooleanQuery.Builder()
                .add(new FuzzyQuery(new Term("title", "dummies")), BooleanClause.Occur.SHOULD)
                .add(new FuzzyQuery(new Term("category", "nov")), BooleanClause.Occur.SHOULD)
                .build();
        Query featureQuery = FeatureField.newSaturationQuery("title", "dummies");
        return new BooleanQuery.Builder()
                .add(originalQuery, BooleanClause.Occur.SHOULD)
                .add(new BoostQuery(featureQuery, .5f), BooleanClause.Occur.SHOULD)
                .build();
    }


    private void closeIndexWriter() throws IOException {
        indexWriter.close();
    }

    public List<Document> search(Query query) throws IOException {
        List<Document> result = new ArrayList<>();
        int hitsPerPage = 10;
        IndexReader reader = DirectoryReader.open(index);
        IndexSearcher searcher = new IndexSearcher(reader);
//        searcher.setSimilarity(new CustomSimilarityBase());
        TopScoreDocCollector collector = TopScoreDocCollector.create(hitsPerPage, 1);
        searcher.search(query, collector);
        ScoreDoc[] hits = collector.topDocs().scoreDocs;

        System.out.println("Found " + hits.length + " hits.");
        for (int i = 0; i < hits.length; ++i) {
            int docId = hits[i].doc;
            Document d = searcher.doc(docId);
            result.add(d);
//            System.out.println(d.get("isbn"));
            System.out.println(d.get("title"));
        }
        reader.close();
        return result;
    }

    public void addDocument(String json) {
        JSONObject jsonObject = convertToJsonObject(json);
        Document doc = new Document();
        for (String field : (Set<String>) jsonObject.keySet()) {
            Class type = jsonObject.get(field).getClass();
            if (type.equals(String.class)) {
                doc.add(new TextField(field, (String) jsonObject.get(field), Field.Store.YES));
            } else if (type.equals(Long.class)) {
                doc.add(new LongPoint(field, (long) jsonObject.get(field)));
            } else if (type.equals(Double.class)) {
                doc.add(new DoublePoint(field, (double) jsonObject.get(field)));
            } else if (type.equals(Boolean.class)) {
                doc.add(new StringField(field, jsonObject.get(field).toString(), Field.Store.YES));
            }
        }
        try {
            indexWriter.addDocument(doc);
        } catch (IOException ex) {
            System.err.println("Error adding documents to the index. " + ex.getMessage());
        }
    }

    private JSONObject convertToJsonObject(String json) {
        return (JSONObject) JSONValue.parse(json);
    }
}
