package com.fict.elibrary.service;

import com.fict.elibrary.dto.BookDto;
import com.fict.elibrary.dto.ModifyBookDto;
import com.fict.elibrary.dto.PatchBookDto;
import com.fict.elibrary.entity.Book;
import com.fict.elibrary.exception.ResourceNotFoundException;
import com.fict.elibrary.exception.ResourceUniqueViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface BookService {

    Page<BookDto> findAll(boolean includeRemoved, Pageable pageable);

    Page<BookDto> findAllByAuthorName(boolean includeRemoved, String authorName, Pageable pageRequest);

    Page<BookDto> findAllByTitle(boolean includeRemoved, String bookTitle, Pageable pageRequest);

    BookDto update(Long id, ModifyBookDto modifyBookDto) throws ResourceNotFoundException;

    Book findById(Long id) throws ResourceNotFoundException;

    BookDto patchUpdate(Long id, PatchBookDto patchBookDto) throws ResourceNotFoundException;

    BookDto save(ModifyBookDto bookDto) throws ResourceNotFoundException, ResourceUniqueViolationException;

    boolean canBeOrdered(BookDto book);

}
