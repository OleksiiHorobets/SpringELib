package com.fict.elibrary.controller.api;

import com.fict.elibrary.exception.ResourceNotFoundException;
import com.fict.elibrary.service.OrderService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/orders")
public class OrderRestController {
    private final OrderService orderService;


    @PostMapping("/fulfill/{id}")
    public ResponseEntity<?> fulfillTheOrder(@PathVariable Long id) throws ResourceNotFoundException {
        var order = orderService.fulfillOrderById(id);

        return ResponseEntity.ok(order);
    }
}
