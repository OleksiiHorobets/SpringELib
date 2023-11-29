package com.fict.elibrary.service;

import com.fict.elibrary.entity.Book;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

public interface BookService {

//    Optional<Book> findById();

    Page<Book> findAll(Pageable pageable);


}
