package com.fict.elibrary.service.impl;

import com.fict.elibrary.dto.AuthorDto;
import com.fict.elibrary.dto.BookDto;
import com.fict.elibrary.dto.PatchBookDto;
import com.fict.elibrary.dto.UpdateBookDto;
import com.fict.elibrary.entity.Author;
import com.fict.elibrary.exception.ResourceNotFoundException;
import com.fict.elibrary.mapper.BookMapper;
import com.fict.elibrary.repository.BookRepository;
import com.fict.elibrary.service.AuthorService;
import com.fict.elibrary.service.BookService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.function.Predicate;

@Service
@Slf4j
@RequiredArgsConstructor
public class BookServiceImpl implements BookService {
    private final BookMapper bookMapper;
    private final BookRepository bookRepository;

    private final AuthorService authorService;

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
    @Transactional
    public BookDto update(Long id, UpdateBookDto updateBookDto) throws ResourceNotFoundException {
        var bookToUpdate = bookRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Book with id {%d} not found!".formatted(id)));

        bookMapper.updateBookFromBookDto(updateBookDto, bookToUpdate);

        Author author = resolveAuthor(updateBookDto);
        bookToUpdate.setAuthor(author);

        return bookMapper.toDto(bookRepository.save(bookToUpdate));
    }

    private Author resolveAuthor(UpdateBookDto updateBookDto) {
        var authorDto = updateBookDto.getAuthor();

        return authorService.findById(authorDto.getId())
                .filter(equalByFirstAndLastName(authorDto))
                .orElseGet(() -> new Author(authorDto.getFirstName(), authorDto.getLastName()));
    }

    private Predicate<Author> equalByFirstAndLastName(AuthorDto authorDto) {
        return author -> author.getFirstName().equals(authorDto.getFirstName())
                && author.getLastName().equals(authorDto.getLastName());
    }

    @Override
    public BookDto findById(Long id) throws ResourceNotFoundException {
        var book = bookRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Book with such id: {%d} not found!".formatted(id)));

        return bookMapper.toDto(book);
    }

    @Override
    public BookDto patchUpdate(Long id, PatchBookDto patchBookDto) throws ResourceNotFoundException {
        var bookToPatch = bookRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Book with id {%d} not found!".formatted(id)));

        bookMapper.patchBookFromPatchBookDto(patchBookDto, bookToPatch);
        log.info("Book after patch: {}", bookToPatch);

        return bookMapper.toDto(bookRepository.save(bookToPatch));
    }

}
