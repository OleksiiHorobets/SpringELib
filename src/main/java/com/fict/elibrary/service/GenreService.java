package com.fict.elibrary.service;

import com.fict.elibrary.dto.GenreDto;
import com.fict.elibrary.exception.ResourceNotFoundException;

import java.util.List;

public interface GenreService {
    List<GenreDto> findAll();

    GenreDto findById(Long id) throws ResourceNotFoundException;
}
