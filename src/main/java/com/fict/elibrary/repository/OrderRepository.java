package com.fict.elibrary.repository;

import com.fict.elibrary.entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderRepository extends JpaRepository<Order, Long> {
}
