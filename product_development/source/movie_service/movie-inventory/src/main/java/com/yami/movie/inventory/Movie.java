package com.yami.movie.inventory;

import java.util.ArrayList;
import java.util.List;

public class Movie {

    private String movieId;
    private List<String> title;
    private List<String> links;
    private long releaseDate;
    private float rating;
    private final List<String> actors;
    private List<String> images;
    //locale for each 'title' in the same order
    private List<String> locale;
    private List<String> genre;
    private List<String> directors;
    private List<String> tag;

    private int likes;
    private int dislikes;

    public Movie() {
        title = new ArrayList<>(1);
        locale = new ArrayList<>(1);
        genre = new ArrayList<>(1);
        directors = new ArrayList<>(1);
        actors = new ArrayList<>(1);
        tag = new ArrayList<>(1);
    }

    public void addGenre(String genre, float weight) {
        this.genre.add(genre);
    }

    public void setTag(String tag) {
        this.tag.add(tag);
    }

    public void setTitle(String name, String locale) {
        this.title.add(name);
        this.locale.add(locale);
    }

    public List<String> getTitle() {
        return title;
    }

    @Override
    public String toString() {
        return "Movie{" +
                "movieId='" + movieId + '\'' +
                ", title=" + title +
                ", links=" + links +
                ", releaseDate=" + releaseDate +
                ", rating=" + rating +
                ", actors=" + actors +
                ", images=" + images +
                ", locale=" + locale +
                ", genre=" + genre +
                ", directors=" + directors +
                ", tag=" + tag +
                '}';
    }

    public List<String> getLocale() {
        return locale;
    }

    public String getMovieId() {
        return movieId;
    }

    public void setMovieId(String movieId) {
        this.movieId = movieId;
    }


    public List<String> getDirectors() {
        return directors;
    }

    public void setDirectors(List<String> directors) {
        this.directors = directors;
    }

    public void addActor(String actor) {

    }
    public List<String> getActors() {
        return actors;
    }

    public List<String> getImages() {
        return images;
    }

    public void setImages(List<String> images) {
        this.images = images;
    }

    public long getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(long releaseDate) {
        this.releaseDate = releaseDate;
    }

    public float getRating() {
        return rating;
    }

    public void setRating(float rating) {
        this.rating = rating;
    }

    public List<String> getLinks() {
        return links;
    }

    public void setLinks(List<String> links) {
        this.links = links;
    }

    public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }

    public int getDislikes() {
        return dislikes;
    }

    public void setDislikes(int dislikes) {
        this.dislikes = dislikes;
    }
}
