package com.fict.elibrary.dto;

import com.fict.elibrary.entity.Author;
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
    private final Long id;
    private final String firstName;
    private final String lastName;
}