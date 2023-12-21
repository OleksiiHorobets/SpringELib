package com.fict.elibrary.service.impl;

import com.fict.elibrary.dto.GenreDto;
import com.fict.elibrary.exception.ResourceNotFoundException;
import com.fict.elibrary.mapper.GenreMapper;
import com.fict.elibrary.repository.GenreRepository;
import com.fict.elibrary.service.GenreService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class GenreServiceImpl implements GenreService {
    private final GenreRepository genreRepository;
    private final GenreMapper genreMapper;

    @Override
    public List<GenreDto> findAll() {
        return genreMapper.toDtoList(genreRepository.findAllByOrderByTitleAsc());
    }

    @Override
    public GenreDto findById(Long id) throws ResourceNotFoundException {
        var genre = genreRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Genre with the id {%d} not found!".formatted(id)));

        return genreMapper.toDto(genre);
    }
}
