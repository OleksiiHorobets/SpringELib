package com.fict.elibrary.dto;

import com.fict.elibrary.entity.Genre;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;

/**
 * A DTO for the {@link Genre} entity
 */
@Data
public final class GenreDto implements Serializable {
    @Serial
    private static final long serialVersionUID = 0L;
    private final Long id;
    private final String title;
}