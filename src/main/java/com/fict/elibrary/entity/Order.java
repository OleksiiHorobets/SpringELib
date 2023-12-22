package com.fict.elibrary.entity;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Getter
@Setter
@Table(name = "orders", schema = "local_lib")
public class Order {
    @Id
    @SequenceGenerator(name = "ID_GENERATOR_ORDERS", sequenceName = "LOCAL_LIB.ORDERS_SEQ", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ID_GENERATOR_ORDERS")
    @Column(name = "id", updatable = false)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private ELibUser user;

    @ManyToOne
    @JoinColumn(name = "book_id")
    private Book book;
    @Column(name = "start_date", nullable = false)
    private LocalDateTime startDate;
    @Column(name = "end_date", nullable = false)
    private LocalDateTime endDate;
    @Column(name = "return_date", nullable = true)
    private LocalDateTime returnDate;
    @Column(name = "on_subscription")
    private Boolean onSubscription;

}
