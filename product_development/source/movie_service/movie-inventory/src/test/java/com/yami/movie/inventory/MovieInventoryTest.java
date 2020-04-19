package com.yami.movie.inventory;

import com.yami.movie.inventory.search.SearchQuery;
import org.junit.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Comparator;
import java.util.List;

public class MovieInventoryTest {

    @Test
    public void testSearchWithBoost() throws IOException {
        MovieInventory movieInventory = new MovieInventory("/tmp/lucene/inv1.db");
        Movie movie = new Movie();
        movie.addGenre("action", .8f);
        movie.addGenre("romance", 1f);
        movie.setTitle("Nadodikattu", "en_US");
        movie.setTitle("നാടോടിക്കാറ്റ്", "ml_IN");
//        movie.setTag("Doublehorse");

        movieInventory.add(movie);

        Movie prod2 = new Movie();
        prod2.addGenre("action", 1f);
        prod2.setTitle("Nirapara Matta 10kg", "en_US");
        prod2.setTag("Nirapara");
        movieInventory.add(prod2);

        Movie prod3 = new Movie();
        prod3.addGenre("biscuit", 1f);
        prod3.setTitle("Horlicks biscuit", "en_US");
        prod3.setTag("Horlicks");
        movieInventory.add(prod3);

        System.out.println("Total product in inventory: " + movieInventory.getAll().size());
        SearchQuery query = new SearchQuery();
        query.addFuzzyField("title", "നാടോടിക്കാറ്റ്");
        query.addFuzzyField("brand", "Doublehorse");
        query.setFieldBoost("categories", "rice", .5f);
        List<Movie> result = movieInventory.search(query);
        System.out.println(result + " for query:" + query);
        Assert.assertTrue(result.get(0).getTitle().contains("നാടോടിക്കാറ്റ്"));
        Assert.assertTrue(result.size() == 1);
    }

    @Test
    public void brandSearch() throws IOException {
        MovieInventory movieInventory = new MovieInventory("/tmp/lucene/inv1.db");
        Movie prod1 = new Movie();
        prod1.addGenre("action", 1f);
        prod1.setTitle("Vadi Matta 5kg", "en_US");
        prod1.setTitle("കേരള മട്ട 5kg", "ml_IN");
        prod1.setTag("Doublehorse");
        movieInventory.add(prod1);

        Movie prod2 = new Movie();
        prod2.addGenre("romance", 1f);
        prod2.setTitle("Nirapara Matta 10kg", "en_US");
        prod2.setTag("Nirapara");
        movieInventory.add(prod2);

        Movie prod3 = new Movie();
        prod3.addGenre("biscuit", 1f);
        prod3.setTitle("Horlicks biscuit", "en_US");
        prod3.setTag("Horlicks");
        movieInventory.add(prod3);

        System.out.println("Total product in inventory: " + movieInventory.getAll().size());
        SearchQuery query = new SearchQuery();
        query.addFuzzyField("genre", "romance");
        query.addFuzzyField("categories", "rice");
        List<Movie> result = movieInventory.search(query);
        System.out.println(result + " for query:" + query);
        Assert.assertTrue(result.get(0).getTitle().contains("കേരള മട്ട 5kg"));
        Assert.assertTrue(result.size() == 1);
    }

    @Test
    public void testAliasNames() throws IOException {
        MovieInventory movieInventory = new MovieInventory("/tmp/lucene/inv2.db");
        Movie prod1 = new Movie();
        prod1.addGenre("banana", 1f);
        prod1.setTitle("Netrapazham", "en_US");
        prod1.setTitle("വാഴപ്പഴം", "ml_IN");
//        prod1.setBrand("Doublehorse");
        movieInventory.add(prod1);

        System.out.println("Total product in inventory: " + movieInventory.getAll().size());
        SearchQuery query = new SearchQuery();
        query.addFuzzyField("title", "വാഴ പ്പഴം");
//        query.setFieldBoost("category", "banana", .5f);
        List<Movie> result = movieInventory.search(query);
        System.out.println(result + " for query:" + query);
        Assert.assertTrue(result.get(0).getTitle().contains("Netrapazham"));
    }

    @Test
    public void categorySearch() throws IOException {
        MovieInventory movieInventory = new MovieInventory("/tmp/lucene/inv3.db");
        Movie prod1 = new Movie();
        prod1.addGenre("banana", 1f);
        prod1.setTitle("Netrapazham", "en_US");
        prod1.setTitle("വാഴപ്പഴം", "ml_IN");
//        prod1.setBrand("Doublehorse");
        movieInventory.add(prod1);

        System.out.println("Total product in inventory: " + movieInventory.getAll().size());
        SearchQuery query = new SearchQuery();
        query.addFuzzyField("genre", "banana");
//        query.setFieldBoost("category", "banana", .5f);
        List<Movie> result = movieInventory.search(query);
        System.out.println(result + " for query:" + query);
        Assert.assertTrue(result.get(0).getTitle().contains("Netrapazham"));
    }

    @Test
    public void simpleSearch() throws IOException {
        MovieInventory movieInventory = new MovieInventory("/tmp/lucene/inv4.db");
        Movie prod1 = new Movie();
        prod1.addGenre("rice", 1f);
        prod1.setTitle("Vadi Matta 5kg", "en_US");
        prod1.setTitle("കേരള മട്ട 5kg", "ml_IN");
        prod1.setTag("Doublehorse");
        movieInventory.add(prod1);

        Movie prod2 = new Movie();
        prod2.addGenre("oil", 1f);
        prod2.setTitle("Coconut oil", "en_US");
        prod2.setTag("Kera");
        movieInventory.add(prod2);

        Movie prod3 = new Movie();
        prod3.addGenre("biscuit", 1f);
        prod3.setTitle("Horlicks biscuit", "en_US");
        prod3.setTag("Horlicks");
        movieInventory.add(prod3);

        System.out.println("Total product in inventory: " + movieInventory.getAll());
        SearchQuery query = new SearchQuery();
        query.addFuzzyField("name", "Coconut oil");
        query.addFuzzyField("brand", "Kera");
        query.setFieldBoost("category", "rice", .5f);
        List<Movie> result = movieInventory.search(query);
        System.out.println(result);
        Assert.assertEquals(result.size(), 1);
    }

    @After
    public void clean() throws IOException {
       try {
           Files.walk(Paths.get("/tmp/lucene/"))
                   .sorted(Comparator.reverseOrder())
                   .map(Path::toFile)
                   .forEach(File::delete);
       } catch (Throwable t) {}
    }

}