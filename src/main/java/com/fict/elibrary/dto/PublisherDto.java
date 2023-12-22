package com.fict.elibrary.dto;

import com.fict.elibrary.entity.Publisher;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
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

    @NotNull
    @Size(max = 250)
    @NotBlank
    private final String title;
}