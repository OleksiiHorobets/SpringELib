package com.fict.elibrary.dto;

import lombok.Data;

import java.time.LocalDate;

@Data
public class UpdateBookDto {
    private final String title;
    private final Integer pages;
    private final LocalDate publicationDate;
    private final PublisherDto publisher;
    private final GenreDto genre;
    private final AuthorDto author;
    private final Integer copies;
    private final Boolean isRemoved;
}
