package com.fict.elibrary.controller;

import com.fict.elibrary.service.OrderService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/orders")
public class OrderController {
    private final OrderService orderService;

    @GetMapping("/admin")
    public String getOrders(
            @RequestParam(name = "page", defaultValue = "0", required = false) int pageNumber,
            @RequestParam(name = "size", defaultValue = "2", required = false) int pageSize,
            Model model,
            HttpSession session
    ) {
        log.info("Orders List: User with session id: {}", session.getId());
        var pageRequest = PageRequest.of(pageNumber, pageSize);

        model.addAttribute("ordersList", orderService.findAll(pageRequest));
        return "user/display_orders";
    }


}
