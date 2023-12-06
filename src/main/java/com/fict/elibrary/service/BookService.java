package com.fict.elibrary.service;

import com.fict.elibrary.dto.BookDto;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface BookService {

//    Optional<Book> findById();

    Page<BookDto> findAll(Pageable pageable);


}
