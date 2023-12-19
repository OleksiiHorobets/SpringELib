package com.fict.elibrary.repository;

import com.fict.elibrary.entity.Genre;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface GenreRepository extends JpaRepository<Genre, Long> {
    List<Genre> findAllByOrderByTitleAsc();
}
