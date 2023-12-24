package com.fict.elibrary.repository;

import com.fict.elibrary.entity.Order;
import com.fict.elibrary.entity.OrderStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;
import java.util.Set;

public interface OrderRepository extends JpaRepository<Order, Long> {
    Page<Order> findAllByUserId(Long userId, Pageable pageable);

    Page<Order> findAllByUserIdAndOrderStatusIn(Long userId, Set<OrderStatus> orderStatuses, Pageable pageable);

    Optional<Order> findByIdAndUserIdAndOrderStatusIn(Long orderId, Long userId, Set<OrderStatus> orderStatuses);

    @Query("""
            SELECT o from Order o
            WHERE o.user.isBanned = FALSE
            AND o.orderStatus in :orderStatuses
            ORDER BY o.orderStatus
            """)
    Page<Order> findAllRequestsOfNonBannedUserWhereOrderStatusIn(Set<OrderStatus> orderStatuses, Pageable pageable);


}
