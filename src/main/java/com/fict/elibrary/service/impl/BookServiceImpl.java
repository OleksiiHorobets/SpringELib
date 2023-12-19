package com.fict.elibrary.service.impl;

import com.fict.elibrary.dto.BookDto;
import com.fict.elibrary.dto.UpdateBookDto;
import com.fict.elibrary.exception.ResourceNotFoundException;
import com.fict.elibrary.mapper.BookMapper;
import com.fict.elibrary.repository.BookRepository;
import com.fict.elibrary.service.BookService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class BookServiceImpl implements BookService {
    private final BookMapper bookMapper;
    private final BookRepository bookRepository;

    @Override
    public Page<BookDto> findAll(boolean includeRemoved, Pageable pageable) {
        return includeRemoved ?
                bookRepository.findAll(pageable).map(bookMapper::toDto) :
                bookRepository.findAllByRemoved(false, pageable).map(bookMapper::toDto);
    }

    @Override
    public Page<BookDto> findAllByAuthorName(boolean includeRemoved, String authorName, Pageable pageRequest) {
        return includeRemoved ?
                bookRepository.findAllByAuthorName(authorName, pageRequest).map(bookMapper::toDto) :
                bookRepository.findAllByRemovedAndAuthorName(false, authorName, pageRequest).map(bookMapper::toDto);
    }

    @Override
    public Page<BookDto> findAllByTitle(boolean includeRemoved, String bookTitle, Pageable pageRequest) {
        return includeRemoved ?
                bookRepository.findAllByTitleContainingIgnoreCase(bookTitle, pageRequest).map(bookMapper::toDto) :
                bookRepository.findAllByRemovedAndTitleContainingIgnoreCase(false, bookTitle, pageRequest)
                        .map(bookMapper::toDto);
    }

    @Override
    public BookDto update(Long id, UpdateBookDto updateBookDto) throws ResourceNotFoundException {
        var bookToUpdate = bookRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Book with id {%d} not found!".formatted(id)));

        bookMapper.updateBookFromBookDto(updateBookDto, bookToUpdate);

        return bookMapper.toDto(bookRepository.save(bookToUpdate));
    }

    @Override
    public BookDto findById(Long id) throws ResourceNotFoundException {
        var book = bookRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Book with such id: {%d} not found!".formatted(id)));

        return bookMapper.toDto(book);
    }

}
