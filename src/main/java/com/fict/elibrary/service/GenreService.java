package com.fict.elibrary.service;

import com.fict.elibrary.dto.GenreDto;

import java.util.List;

public interface GenreService {
    List<GenreDto> findAll();
}
