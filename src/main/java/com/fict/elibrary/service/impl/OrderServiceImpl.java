package com.fict.elibrary.service.impl;

import com.fict.elibrary.config.OrderServiceConfig;
import com.fict.elibrary.dto.NewOrderDto;
import com.fict.elibrary.dto.OrderDto;
import com.fict.elibrary.entity.Book;
import com.fict.elibrary.entity.ELibUser;
import com.fict.elibrary.entity.Order;
import com.fict.elibrary.entity.OrderStatus;
import com.fict.elibrary.exception.ResourceNotFoundException;
import com.fict.elibrary.exception.ResourceUniqueViolationException;
import com.fict.elibrary.mapper.BookMapper;
import com.fict.elibrary.mapper.OrderMapper;
import com.fict.elibrary.repository.OrderRepository;
import com.fict.elibrary.service.BookService;
import com.fict.elibrary.service.ELibUserService;
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
import java.util.Set;

import static com.fict.elibrary.entity.OrderStatus.PROCESSING;
import static com.fict.elibrary.entity.OrderStatus.REJECTED;

@Service
@Slf4j
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {
    private final OrderServiceConfig orderServiceConfig;
    private final OrderRepository orderRepository;
    private final OrderMapper orderMapper;
    private final BookMapper bookMapper;
    private final BookService bookService;

    private final ELibUserService userService;

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

    @Override
    public Page<OrderDto> findUsersOrdersByIdAndStatus(Long userId, Pageable pageable, Set<OrderStatus> statuses) {
        return orderRepository.findAllByUserIdAndOrderStatusIn(userId, statuses, pageable)
                .map(orderMapper::toDto)
                .map(this::addTheFine);
    }

    @Override
    @Transactional
    public void placeOrder(Long userId, NewOrderDto orderDto) throws ResourceNotFoundException {
        var book = bookService.findById(orderDto.getBookId());
        if (!bookService.canBeOrdered(bookMapper.toDto(book))) {
            throw new ResourceNotFoundException("Book you are trying to order is not present!");
        }

        var customer = userService.findById(userId);

        var now = LocalDateTime.now();
        var order = prepareOrderWithoutEndDate(book, customer, now);

        switch (orderDto.getOrderType()) {
            case ON_SUBSCRIPTION -> resolveOnSubscription(now, order);
            case READING_ROOM -> resolveInReadingRoom(now, order);
        }

        orderRepository.save(order);
    }

    @Override
    @Transactional
    public void cancelOrder(Long userId, Long orderId) throws ResourceNotFoundException, ResourceUniqueViolationException {
        log.info("Cancel order for user: {} and orderId: {}", userId, orderId);
        var order = orderRepository.findByIdAndUserIdAndOrderStatusIn(orderId, userId, Set.of(PROCESSING))
                .orElseThrow(() -> new ResourceNotFoundException("Order with id: {%s} not found!".formatted(orderId)));

        var book = order.getBook();
        book.setCopies(book.getCopies() + 1);
        bookService.save(book);

        orderRepository.delete(order);
    }

    @Override
    public Page<OrderDto> findAllRequestsOfNonBlockedUsers(Pageable pageable) {
        return orderRepository.findAllRequestsOfNonBannedUserWhereOrderStatusIn(Set.of(PROCESSING, REJECTED), pageable)
                .map(orderMapper::toDto)
                .map(this::addTheFine);
    }

    @Override
    public void setOrderStatus(Long id, OrderStatus status) throws ResourceNotFoundException {
        var order = orderRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Order with such id {%s} is not found!".formatted(id)));

        order.setOrderStatus(status);
        orderRepository.save(order);
    }

    private void resolveInReadingRoom(LocalDateTime now, Order order) {
        order.setEndDate(now.plusDays(1));
        order.setOnSubscription(false);
    }

    private void resolveOnSubscription(LocalDateTime now, Order order) {
        order.setEndDate(now.plusDays(orderServiceConfig.getSubscriptionDays()));
        order.setOnSubscription(true);
    }

    private Order prepareOrderWithoutEndDate(Book bookToOrder, ELibUser customer, LocalDateTime now) {
        var order = new Order();

        order.setStartDate(now);
        bookToOrder.setCopies(bookToOrder.getCopies() - 1);
        order.setBook(bookToOrder);
        order.setUser(customer);
        order.setOrderStatus(PROCESSING);

        return order;
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
