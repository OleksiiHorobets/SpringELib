package com.fict.elibrary.service.impl;

import com.fict.elibrary.dto.GenreDto;
import com.fict.elibrary.entity.Genre;
import com.fict.elibrary.exception.ResourceNotFoundException;
import com.fict.elibrary.mapper.GenreMapper;
import com.fict.elibrary.repository.GenreRepository;
import com.fict.elibrary.service.GenreService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.util.Pair;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import static org.springframework.data.util.Pair.toMap;

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
    public Genre findById(Long id) throws ResourceNotFoundException {
        return genreRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Genre with the id {%d} not found!".formatted(id)));
    }

    @Override
    public Map<Genre, Long> getBookDistributionByGenres() {
        return genreRepository.getBookDistributionByGenre()
                .stream()
                .map(row -> Pair.of((Genre)row[0],(Long) row[1]))
                .collect(toMap());
    }

}
