package com.fict.elibrary.repository;

import com.fict.elibrary.entity.Genre;
import jakarta.persistence.NamedNativeQuery;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface GenreRepository extends JpaRepository<Genre, Long> {
    List<Genre> findAllByOrderByTitleAsc();

    //    @Query("SELECT g, COUNT(b) FROM Genre g JOIN g.books b GROUP BY g")
    @Query("SELECT g, COUNT(b) FROM Genre g JOIN g.books b GROUP BY g")
    List<Object[]> getBookDistributionByGenre();
}
