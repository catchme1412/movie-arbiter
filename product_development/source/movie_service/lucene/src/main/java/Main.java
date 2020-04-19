import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.StringField;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.*;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.queryparser.complexPhrase.ComplexPhraseQueryParser;
import org.apache.lucene.search.*;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.RAMDirectory;
import org.apache.lucene.util.Version;
import org.apache.lucene.queries.CommonTermsQuery;
import java.io.IOException;

public class Main {
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
        addDoc(w, "Lucene  & Java for Dummies", "5");
        w.close();

        String querystr = "lucene";

        Term term = new Term("title", "Lusene");
//        Query q = new FuzzyQuery(term);

        Query q = new ComplexPhraseQueryParser("title", analyzer)
                .parse("lusene~");

//        CustomQuery query = new CustomQuery(q);

//        Custom customQuery = new ImagineaDemoCustomScoreQuery(q);

//        Query q = new QueryParser("title", analyzer).parse(querystr);



        int hitsPerPage = 10;
        IndexReader reader = DirectoryReader.open(index);
        IndexSearcher searcher = new IndexSearcher(reader);
//        searcher.setSimilarity(new CustomSimilarityBase());
        TopScoreDocCollector collector = TopScoreDocCollector.create(hitsPerPage, 1);
        searcher.search(q, collector);
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