package com.fict.elibrary.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "books")
public class Book {
    @Id
    @SequenceGenerator(name = "ID_GENERATOR_BOOKS", sequenceName = "LOCAL_LIB.BOOKS_SEQ", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ID_GENERATOR_BOOKS")
    @Column(name = "id", updatable = false)
    private Long id;
}
