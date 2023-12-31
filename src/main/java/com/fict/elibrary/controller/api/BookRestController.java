package com.fict.elibrary.controller.api;

import com.fict.elibrary.dto.BookDto;
import com.fict.elibrary.dto.ModifyBookDto;
import com.fict.elibrary.dto.PatchBookDto;
import com.fict.elibrary.exception.ResourceNotFoundException;
import com.fict.elibrary.exception.ResourceUniqueViolationException;
import com.fict.elibrary.service.BookService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/books")
@RequiredArgsConstructor
@Slf4j
public class BookRestController {
    private final BookService bookService;

    @PatchMapping("{id}")
    public ResponseEntity<BookDto> patchBook(
            @PathVariable Long id,
            @Valid PatchBookDto patchBookDto
    ) throws ResourceNotFoundException {
        log.info("API: patch book request with id {} and PatchBookDto: {}", id, patchBookDto);
        var updatedBook = bookService.patchUpdate(id, patchBookDto);
        return ResponseEntity.ok(updatedBook);
    }

    @PutMapping("{id}")
    public ResponseEntity<BookDto> updateBook(
            @PathVariable Long id,
            @RequestBody @Valid ModifyBookDto modifyBookDto
    ) throws ResourceNotFoundException {
        log.info("API: update book request with id {} and UpdateBookDto: {}", id, modifyBookDto);
        var updatedBook = bookService.update(id, modifyBookDto);
        return ResponseEntity.ok(updatedBook);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public BookDto createBook(
            @RequestBody ModifyBookDto modifyBookDto
    ) throws ResourceUniqueViolationException, ResourceNotFoundException {
        return bookService.save(modifyBookDto);
    }
}
