package com.example.work6;

public class AudioItem {
    private long id;
    private String name;

    public AudioItem(long id, String name) {
        this.id = id;
        this.name = name;
    }

    public long getId() { return id; }
    public String getName() { return name; }

    @Override
    public String toString() {
        return name.replace(".mp3", "");
    }
}