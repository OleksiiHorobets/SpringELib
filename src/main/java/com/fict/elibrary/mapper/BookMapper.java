package com.fict.elibrary.mapper;

import com.fict.elibrary.dto.BookDto;
import com.fict.elibrary.entity.Book;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface BookMapper {

//    BookMapper INSTANCE = Mappers.getMapper(BookMapper.class);

    //    @Named("toDto")
//    @Mapping(target = "copies", qualifiedByName = "getCopies")
    BookDto toDto(Book entity);

    //    @IterableMapping(qualifiedByName = "toDto")
//    List<BookDto> toDtoList(List<Book> entityList);

//    default String getCopies(Book book) {
//        return
//    }
}
