package com.fict.elibrary.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PastOrPresent;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

import java.time.LocalDate;

@Data
public class ModifyBookDto {
    @NotNull
    @Pattern(regexp = "^['a-zA-Z?!,.а-яА-ЯёЁ0-9\\s\\-:]{1,350}$", message = "Title should not contain special symbols!")
    private final String title;
    @NotNull
    @Min(1)
    private final Integer pages;
    @NotNull
    @PastOrPresent
    private final LocalDate publicationDate;
    @NotNull
    private final Long publisherId;
    @NotNull
    private final Long genreId;
    @NotNull
    private final AuthorDto author;
    @NotNull
    @Min(0)
    private final Integer copies;
}
