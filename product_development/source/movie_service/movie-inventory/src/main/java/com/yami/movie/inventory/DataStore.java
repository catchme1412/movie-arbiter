package com.yami.movie.inventory;

import com.yami.movie.inventory.search.SearchQuery;

import java.io.IOException;
import java.util.List;

public interface DataStore<T, O> {
    void add(O baseDocument) throws IOException;

    void update(O baseDocument);

    void delete(O baseDocument);

    T getDocument(O baseDocument);

    List<O> search(SearchQuery query) throws IOException;

    List<O> getAllDocuments() throws IOException;
}
