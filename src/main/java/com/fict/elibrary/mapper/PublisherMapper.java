package com.fict.elibrary.mapper;

import com.fict.elibrary.dto.PublisherDto;
import com.fict.elibrary.entity.Publisher;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public interface PublisherMapper extends BaseMapper<Publisher, PublisherDto> {

}
