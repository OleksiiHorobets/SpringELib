package com.fict.elibrary.mapper;

import com.fict.elibrary.dto.BookDto;
import com.fict.elibrary.dto.UpdateBookDto;
import com.fict.elibrary.entity.Book;
import org.mapstruct.BeanMapping;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.Mappings;
import org.mapstruct.NullValuePropertyMappingStrategy;

@Mapper(componentModel = "spring")
public interface BookMapper {

    @Mappings({
            @Mapping(source = "removed", target = "isRemoved"),
            @Mapping(source = "id", target = "bookId")
    })
    BookDto toDto(Book entity);


    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    @Mapping(source = "isRemoved", target = "removed")
    void updateBookFromBookDto(UpdateBookDto updateBookDto, @MappingTarget Book book);
}
