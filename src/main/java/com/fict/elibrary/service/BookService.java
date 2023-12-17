package com.fict.elibrary.service;

import com.fict.elibrary.dto.BookDto;
import com.fict.elibrary.dto.UpdateBookDto;
import com.fict.elibrary.exception.ResourceNotFoundException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface BookService {

    Page<BookDto> findAll(boolean includeRemoved, Pageable pageable);

    Page<BookDto> findAllByAuthorName(boolean includeRemoved, String authorName, Pageable pageRequest);

    Page<BookDto> findAllByTitle(boolean includeRemoved, String bookTitle, Pageable pageRequest);

    BookDto update(Long id, UpdateBookDto updateBookDto) throws ResourceNotFoundException;

}
