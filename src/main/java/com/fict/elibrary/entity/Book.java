package com.fict.elibrary.entity;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Indexed;

import java.time.LocalDate;

@Entity
@Getter
@Setter
@Table(name = "books", schema = "local_lib")
@Indexed
public class Book {
    @Id
    @SequenceGenerator(name = "ID_GENERATOR_BOOKS", sequenceName = "LOCAL_LIB.BOOKS_SEQ", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ID_GENERATOR_BOOKS")
    @Column(name = "id", updatable = false)
    private Long id;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "pages", nullable = false)
    private Integer pages;

    @Column(name = "copies", nullable = false)
    private Integer copies;

    @Column(name = "removed", nullable = false)
    @Getter(value = AccessLevel.NONE)
    private Boolean removed;

    @Column(name = "publication_date", nullable = false)
    private LocalDate publicationDate;
    @ManyToOne(optional = false)
    @JoinColumn(name = "publisher_id")
    private Publisher publisher;

    @ManyToOne(optional = false)
    @JoinColumn(name = "genre_id")
    private Genre genre;

    @ManyToOne(optional = false, cascade = CascadeType.PERSIST)
    @JoinColumn(name = "author_id")
    private Author author;

    public Boolean isRemoved() {
        return removed;
    }
}
