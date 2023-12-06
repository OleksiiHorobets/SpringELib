package com.fict.elibrary.dto;

import com.fict.elibrary.entity.Publisher;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;

/**
 * A DTO for the {@link Publisher} entity
 */
@Data
public final class PublisherDto implements Serializable {
    @Serial
    private static final long serialVersionUID = 0L;
    private final Long id;
    private final String title;
}