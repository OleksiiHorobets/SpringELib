package com.fict.elibrary.service;

import com.fict.elibrary.entity.Author;

import java.util.Optional;

public interface AuthorService {
    Optional<Author> findById(Long id);
}
