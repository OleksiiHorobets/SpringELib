package com.fict.elibrary.dto;

import com.fict.elibrary.entity.OrderStatus;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class OrderDto {
    private String orderId;
    private ELibUserDto user;
    private BookDto book;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    private LocalDateTime returnDate;
    private Boolean onSubscription;
    private BigDecimal fine;
    private OrderStatus orderStatus;
}
