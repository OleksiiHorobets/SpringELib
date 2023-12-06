package com.fict.elibrary.mapper;

import com.fict.elibrary.dto.GenreDto;
import com.fict.elibrary.entity.Genre;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface GenreMapper {

    GenreDto toDto(Genre model);

    Genre toEntity(GenreDto dto);
}
