package com.yami.movie.inventory;

import com.google.gson.reflect.TypeToken;
import com.yami.movie.inventory.search.SearchQuery;
import org.apache.lucene.document.Document;

import java.io.IOException;
import java.util.List;

public class MovieInventory {

    private DataStore<Document, Movie> dataStore;

    public MovieInventory(String fileStore) throws IOException {
        dataStore = new LuceneDataStore(fileStore, new TypeToken<Movie>() {}.getType());
    }

    public void add(Movie product) throws IOException {
        dataStore.add(product);
    }

    public void update(Movie product) {
        dataStore.update(product);
    }

    public void delete(Movie product) {
        dataStore.delete(product);
    }

    public List<Movie> search (SearchQuery query) throws IOException {
        List<Movie> result = dataStore.search(query);
        return result;
    }

    public List<Movie> getAll() throws IOException {
        return dataStore.getAllDocuments();
    }
}
