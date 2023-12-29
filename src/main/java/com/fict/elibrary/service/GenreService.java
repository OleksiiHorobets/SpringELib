package com.fict.elibrary.service;

import com.fict.elibrary.dto.GenreDto;
import com.fict.elibrary.entity.Genre;
import com.fict.elibrary.exception.ResourceNotFoundException;

import java.util.List;
import java.util.Map;

public interface GenreService {
    List<GenreDto> findAll();

    Genre findById(Long id) throws ResourceNotFoundException;

    Map<Genre, Long> getBookDistributionByGenres();
}
