package com.fict.elibrary.service;

import com.fict.elibrary.dto.NewOrderDto;
import com.fict.elibrary.dto.OrderDto;
import com.fict.elibrary.entity.OrderStatus;
import com.fict.elibrary.exception.ResourceNotFoundException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Set;

public interface OrderService {
    Page<OrderDto> findAll(Pageable pageable);

    OrderDto fulfillOrderById(Long id) throws ResourceNotFoundException;

    Page<OrderDto> findUsersOrdersById(Long userId, Pageable pageable);

    Page<OrderDto> findUsersOrdersByIdAndStatus(Long userId, Pageable pageable, Set<OrderStatus> statuses);

    void placeOrder(Long userId, NewOrderDto orderDto) throws ResourceNotFoundException;

}
