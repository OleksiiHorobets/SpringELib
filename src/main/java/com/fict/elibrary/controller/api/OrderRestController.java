package com.fict.elibrary.controller.api;

import com.fict.elibrary.dto.OrderDto;
import com.fict.elibrary.entity.OrderStatus;
import com.fict.elibrary.exception.ResourceNotFoundException;
import com.fict.elibrary.service.OrderService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/orders")
public class OrderRestController {
    private final OrderService orderService;


    @PostMapping("/fulfill/{id}")
    public ResponseEntity<OrderDto> fulfillTheOrder(@PathVariable Long id) throws ResourceNotFoundException {
        var order = orderService.fulfillOrderById(id);

        return ResponseEntity.ok(order);
    }

    @PatchMapping("/status/{id}")
    public void updateOrderStatus(@PathVariable Long id, @RequestParam OrderStatus orderStatus) throws ResourceNotFoundException {
        log.info("Update order status order id: {} -> status: {}", id, orderStatus);
        orderService.setOrderStatus(id, orderStatus);
    }
}
