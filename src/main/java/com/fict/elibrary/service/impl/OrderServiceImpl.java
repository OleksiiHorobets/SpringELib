package com.fict.elibrary.service.impl;

import com.fict.elibrary.config.OrderServiceConfig;
import com.fict.elibrary.dto.OrderDto;
import com.fict.elibrary.exception.ResourceNotFoundException;
import com.fict.elibrary.mapper.OrderMapper;
import com.fict.elibrary.repository.OrderRepository;
import com.fict.elibrary.service.OrderService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

@Service
@Slf4j
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {
    private final OrderServiceConfig orderServiceConfig;
    private final OrderRepository orderRepository;
    private final OrderMapper orderMapper;

    @Override
    public Page<OrderDto> findAll(Pageable pageable) {
        return orderRepository.findAll(pageable)
                .map(orderMapper::toDto)
                .map(this::addTheFine);
    }

    @Override
    @Transactional
    public OrderDto fulfillOrderById(Long id) throws ResourceNotFoundException {
        var orderToFulfill = orderRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Order with such id is not found!"));

        orderToFulfill.setReturnDate(LocalDateTime.now());
        return orderMapper.toDto(orderRepository.save(orderToFulfill));
    }

    @Override
    public Page<OrderDto> findUsersOrdersById(Long userId, Pageable pageable) {
        return orderRepository.findAllByUserId(userId, pageable)
                .map(orderMapper::toDto)
                .map(this::addTheFine);
    }

    private OrderDto addTheFine(OrderDto order) {
        order.setFine(countFine(order));
        return order;
    }

    private BigDecimal countFine(OrderDto order) {
        var endDate = order.getEndDate();
        var currentTime = LocalDateTime.now();

        if (currentTime.isBefore(endDate)) {
            return BigDecimal.ZERO;
        }
        long daysOverdue = ChronoUnit.DAYS.between(endDate, currentTime);

        return orderServiceConfig.getUsdPerDayFine().multiply(BigDecimal.valueOf(daysOverdue));
    }

}
