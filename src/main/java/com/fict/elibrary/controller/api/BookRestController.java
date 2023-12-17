package com.fict.elibrary.controller.api;

import com.fict.elibrary.dto.UpdateBookDto;
import com.fict.elibrary.exception.ResourceNotFoundException;
import com.fict.elibrary.service.BookService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/books")
@RequiredArgsConstructor
@Slf4j
public class BookRestController {
    private final BookService bookService;

    @PatchMapping("{id}")
    public ResponseEntity<?> updateBook(
            @Valid UpdateBookDto updateBookDto,
            @PathVariable Long id
    ) throws ResourceNotFoundException {
        log.info("API: update book request with id {} and UpdateBookDto: {}", id, updateBookDto);
        var updatedBook = bookService.update(id, updateBookDto);
        return ResponseEntity.ok(updatedBook);
    }
}
