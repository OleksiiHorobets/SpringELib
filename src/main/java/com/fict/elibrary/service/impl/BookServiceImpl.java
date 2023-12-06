package com.fict.elibrary.service.impl;

import com.fict.elibrary.dto.BookDto;
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
    public Page<BookDto> findAll(Pageable pageable) {
        return bookRepository.findAll(pageable)
                .map(bookMapper::toDto);
    }
}
