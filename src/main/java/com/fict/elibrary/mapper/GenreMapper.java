package com.fict.elibrary.mapper;

import com.fict.elibrary.dto.GenreDto;
import com.fict.elibrary.entity.Genre;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public interface GenreMapper extends BaseMapper<Genre, GenreDto> {

}
