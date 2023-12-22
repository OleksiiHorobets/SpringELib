package com.fict.elibrary.mapper;

import com.fict.elibrary.dto.BookDto;
import com.fict.elibrary.dto.PatchBookDto;
import com.fict.elibrary.dto.ModifyBookDto;
import com.fict.elibrary.entity.Book;
import org.mapstruct.BeanMapping;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingConstants;
import org.mapstruct.MappingTarget;
import org.mapstruct.Mappings;
import org.mapstruct.NullValuePropertyMappingStrategy;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public interface BookMapper {

    @Mappings({
            @Mapping(source = "removed", target = "isRemoved"),
            @Mapping(source = "id", target = "bookId")
    })
    BookDto toDto(Book entity);


    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
//    @Mapping(source = "isRemoved", target = "removed")
    @Mapping(source = "author", target = "author", ignore = true)
    void updateBookFromBookDto(ModifyBookDto modifyBookDto, @MappingTarget Book book);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    @Mapping(source = "isRemoved", target = "removed")
    void patchBookFromPatchBookDto(PatchBookDto patchBookDto, @MappingTarget Book book);

}
