package com.fict.elibrary.repository;

import com.fict.elibrary.entity.Book;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface BookRepository extends JpaRepository<Book, Long> {
    @Query(value = """
             SELECT b FROM Book b
             WHERE CONCAT(b.author.firstName, ' ', b.author.lastName) LIKE %:authorName%
             OR b.author.firstName ILIKE %:authorName%
             OR b.author.lastName ILIKE %:authorName%
            """)
    Page<Book> findAllByAuthorName(String authorName, Pageable pageable);

    Page<Book> findAllByTitleContainingIgnoreCase(String title, Pageable pageRequest);

    Page<Book> findAllByRemovedAndTitleContainingIgnoreCase(boolean isRemoved, String title, Pageable pageRequest);

    Page<Book> findAllByRemoved(boolean isRemoved, Pageable pageRequest);

    @Query(value = """
             SELECT b FROM Book b
             WHERE b.removed = :isRemoved AND
             CONCAT(b.author.firstName, ' ', b.author.lastName) LIKE %:authorName%
             OR b.author.firstName ILIKE %:authorName%
             OR b.author.lastName ILIKE %:authorName%
            """)
    Page<Book> findAllByRemovedAndAuthorName(boolean isRemoved, String authorName, Pageable pageRequest);

}
