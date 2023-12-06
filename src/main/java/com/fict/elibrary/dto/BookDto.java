package com.fict.elibrary.dto;

import com.fict.elibrary.entity.Book;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;

/**
 * A DTO for the {@link Book} entity
 */
@Data
public final class BookDto implements Serializable {
    @Serial
    private static final long serialVersionUID = 0L;

    private final Long id;
    private final String title;
    private final Integer pages;
    private final LocalDate publicationDate;
    private final PublisherDto publisher;
    private final GenreDto genre;
    private final AuthorDto author;
    private final Integer copies;
}