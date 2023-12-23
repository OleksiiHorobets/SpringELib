package com.fict.elibrary.service;

import com.fict.elibrary.dto.OrderDto;
import com.fict.elibrary.exception.ResourceNotFoundException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface OrderService {
    Page<OrderDto> findAll(Pageable pageable);

    OrderDto fulfillOrderById(Long id) throws ResourceNotFoundException;

    Page<OrderDto> findUsersOrdersById(Long userId, Pageable pageable);
}
