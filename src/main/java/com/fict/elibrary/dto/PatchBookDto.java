package com.fict.elibrary.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.PastOrPresent;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

import java.time.LocalDate;

@Data
public class PatchBookDto {
    @Pattern(regexp = "^['a-zA-Z?!,.а-яА-ЯёЁ0-9\\s\\-:]{1,350}$", message = "Title should not contain special symbols!")
    private final String title;
    @Min(1)
    private final Integer pages;
    @PastOrPresent
    private final LocalDate publicationDate;
    private final PublisherDto publisher;
    private final GenreDto genre;
    private final AuthorDto author;
    @Min(0)
    private final Integer copies;
    private final Boolean isRemoved;
}
