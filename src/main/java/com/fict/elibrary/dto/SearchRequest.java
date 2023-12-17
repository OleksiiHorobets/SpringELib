package com.fict.elibrary.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;

@Data
@AllArgsConstructor
@ToString
public final class SearchRequest {
    @NotNull
    @Pattern(regexp = "\\b(?:by_title|by_author)\\b")
    private final String searchBy;
    @NotNull
    private final String content;

}
