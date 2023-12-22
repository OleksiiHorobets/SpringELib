package com.fict.elibrary.dto;

import com.fasterxml.jackson.annotation.JsonAlias;
import com.fict.elibrary.entity.Author;
import jakarta.annotation.Nullable;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;

/**
 * A DTO for the {@link Author} entity
 */
@Data
public final class AuthorDto implements Serializable {
    @Serial
    private static final long serialVersionUID = 0L;
    @JsonAlias("authorId")
    private final Long id;
    @NotNull
    @Pattern(regexp = "^['a-zA-Z?а-яА-ЯёЁ]{1,50}$")
    private final String firstName;
    @NotNull
    @Pattern(regexp = "^['a-zA-Z?а-яА-ЯёЁ]{1,50}$")
    private final String lastName;
}