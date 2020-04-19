import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.*;
import org.apache.lucene.index.*;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.search.*;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.RAMDirectory;

import java.io.IOException;

public class BoostingExample {
    @SuppressWarnings("deprecation")
    public static void main(String[] args) throws IOException, ParseException {

        StandardAnalyzer analyzer = new StandardAnalyzer();
        Directory index = new RAMDirectory();

        IndexWriterConfig config = new IndexWriterConfig(analyzer);

        IndexWriter w = new IndexWriter(index, config);
        addDoc(w, "Lucene in Action", "1");
        addDoc(w, "Lucene for Dummies", "2");
        addDoc(w, "Java", "3");
        addDoc(w, "Oracle", "4");
        addDoc(w, "Dummies", "6");
        addDoc(w, "A & Lucene  & Java for Dummies", "5");
        w.close();

        Query originalQuery = new BooleanQuery.Builder()
                .add(new FuzzyQuery(new Term("title", "lucesen")), BooleanClause.Occur.SHOULD)
                .build();
        Query featureQuery = FeatureField.newSaturationQuery("isbn", "5");
        Query query = new BooleanQuery.Builder()
                .add(originalQuery, BooleanClause.Occur.SHOULD)
                .add(new BoostQuery(featureQuery, .5f), BooleanClause.Occur.SHOULD)
                .build();
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
            System.out.println(d.get("isbn"));
            System.out.println(d.get("title"));
        }
        reader.close();
    }

    private static void addDoc(IndexWriter w, String title, String isbn) throws IOException {
        Document doc = new Document();
        doc.add(new TextField("title", title, Field.Store.YES));
        doc.add(new StringField("isbn", isbn, Field.Store.YES));
        w.addDocument(doc);
    }


}