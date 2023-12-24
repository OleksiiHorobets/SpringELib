package com.fict.elibrary.service.impl;

import com.fict.elibrary.dto.BookDto;
import com.fict.elibrary.dto.ModifyBookDto;
import com.fict.elibrary.dto.PatchBookDto;
import com.fict.elibrary.entity.Author;
import com.fict.elibrary.entity.Book;
import com.fict.elibrary.exception.ResourceNotFoundException;
import com.fict.elibrary.exception.ResourceUniqueViolationException;
import com.fict.elibrary.mapper.BookMapper;
import com.fict.elibrary.repository.BookRepository;
import com.fict.elibrary.service.AuthorService;
import com.fict.elibrary.service.BookService;
import com.fict.elibrary.service.GenreService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Slf4j
@RequiredArgsConstructor
public class BookServiceImpl implements BookService {
    private final BookMapper bookMapper;
    private final BookRepository bookRepository;
    private final AuthorService authorService;
    private final GenreService genreService;
    private final PublisherServiceImpl publisherService;


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
    public BookDto update(Long id, ModifyBookDto modifyBookDto) throws ResourceNotFoundException {
        var bookToUpdate = bookRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Book with id {%d} not found!".formatted(id)));

        bookMapper.updateBookFromBookDto(modifyBookDto, bookToUpdate);

        Author author = resolveAuthor(modifyBookDto);
        bookToUpdate.setAuthor(author);
        bookToUpdate.setGenre(genreService.findById(modifyBookDto.getGenreId()));
        bookToUpdate.setPublisher(publisherService.findById(modifyBookDto.getPublisherId()));

        return bookMapper.toDto(bookRepository.save(bookToUpdate));
    }

    private Author resolveAuthor(ModifyBookDto modifyBookDto) {
        var authorDto = modifyBookDto.getAuthor();

        return authorService.findByFirstAndLastName(authorDto.getFirstName(), authorDto.getLastName())
                .orElseGet(() -> new Author(authorDto.getFirstName(), authorDto.getLastName()));
    }

    @Override
    public Book findById(Long id) throws ResourceNotFoundException {
        var book = bookRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Book with such id: {%d} not found!".formatted(id)));

        return book;
    }

    @Override
    @Transactional
    public BookDto patchUpdate(Long id, PatchBookDto patchBookDto) throws ResourceNotFoundException {
        var bookToPatch = bookRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Book with id {%d} not found!".formatted(id)));

        bookMapper.patchBookFromPatchBookDto(patchBookDto, bookToPatch);
        log.info("Book after patch: {}", bookToPatch);

        return bookMapper.toDto(bookRepository.save(bookToPatch));
    }

    @Override
    @Transactional
    public BookDto save(ModifyBookDto bookDto) throws ResourceNotFoundException, ResourceUniqueViolationException {
        var bookToSave = new Book();
        bookMapper.updateBookFromBookDto(bookDto, bookToSave);

        Author author = resolveAuthor(bookDto);
        bookToSave.setRemoved(false);
        bookToSave.setAuthor(author);
        bookToSave.setGenre(genreService.findById(bookDto.getGenreId()));
        bookToSave.setPublisher(publisherService.findById(bookDto.getPublisherId()));

        if (bookRepository.checkIfExists(bookToSave)) {
            throw new ResourceUniqueViolationException("Book with such author, genre, publisher and publication date already exists!");
        }

        return bookMapper.toDto(bookRepository.save(bookToSave));
    }

    @Override
    public Book save(Book book) throws ResourceNotFoundException, ResourceUniqueViolationException {
        return bookRepository.save(book);
    }

    @Override
    public boolean canBeOrdered(BookDto book) {
        return !book.isRemoved() &&
                book.getCopies() > 0;
    }

}
