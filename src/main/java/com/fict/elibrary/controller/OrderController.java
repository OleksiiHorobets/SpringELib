package com.fict.elibrary.controller;

import com.fict.elibrary.dto.NewOrderDto;
import com.fict.elibrary.entity.OrderStatus;
import com.fict.elibrary.exception.ResourceNotFoundException;
import com.fict.elibrary.exception.ResourceUniqueViolationException;
import com.fict.elibrary.mapper.BookMapper;
import com.fict.elibrary.service.BookService;
import com.fict.elibrary.service.OrderService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;

import java.util.Set;

import static com.fict.elibrary.utils.UserUtils.resolveUserId;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/orders")
public class OrderController {
    private final OrderService orderService;
    private final BookService bookService;

    private final BookMapper bookMapper;

    @GetMapping("/admin")
    public String getOrdersAdmin(
            @RequestParam(name = "page", defaultValue = "0", required = false) int pageNumber,
            @RequestParam(name = "size", defaultValue = "5", required = false) int pageSize,
            Model model,
            HttpSession session
    ) {
        log.info("Orders List: User with session id: {}", session.getId());
        var pageRequest = PageRequest.of(pageNumber, pageSize);

        model.addAttribute("ordersList", orderService.findAll(pageRequest));
        return "admin/display_orders_admin";
    }

    @GetMapping("/user")
    public String getOrdersUser(
            @RequestParam(name = "page", defaultValue = "0", required = false) int pageNumber,
            @RequestParam(name = "size", defaultValue = "5", required = false) int pageSize,
            Model model,
            HttpSession session
    ) {
        log.info("Orders List: User with session id: {}", session.getId());
        var pageRequest = PageRequest.of(pageNumber, pageSize);

        model.addAttribute("ordersList", orderService.findUsersOrdersByIdAndStatus(
                resolveUserId(), pageRequest, Set.of(OrderStatus.ACCEPTED)));
        return "user/display_orders_user";
    }

    @GetMapping("/new")
    public String orderPage(
            @RequestParam @NotNull Long bookId,
            Model model
    ) throws ResourceNotFoundException {
        var bookToOrder = bookMapper.toDto(bookService.findById(bookId));

        if (!bookService.canBeOrdered(bookToOrder)) {
            return "error/400";
        }

        model.addAttribute("book", bookToOrder);
        return "user/order_book";
    }

    @PostMapping
    public String addNewOrder(@Valid NewOrderDto orderDto, Model model) throws ResourceNotFoundException {
        log.info("Add new order request: {}", orderDto);

        orderService.placeOrder(resolveUserId(), orderDto);
        model.addAttribute("msg", "success");
        return "redirect:/orders/user/requests?message=success";
    }

    @GetMapping("/user/requests")
    public String getMyRequests(
            @RequestParam(name = "page", defaultValue = "0", required = false) int pageNumber,
            @RequestParam(name = "size", defaultValue = "5", required = false) int pageSize,
            @RequestParam(name = "message", required = false) String message,
            Model model
    ) {
        var userId = resolveUserId();
        log.info("Get Users requests for user id: {}", userId);

        var pageRequest = PageRequest.of(pageNumber, pageSize);
        model.addAttribute("requestsList", orderService.findUsersOrdersByIdAndStatus(
                userId, pageRequest, Set.of(OrderStatus.PROCESSING, OrderStatus.REJECTED)));
        model.addAttribute("msg", message);

        return "user/my_requests";
    }

    @GetMapping("/admin/requests")
    public String getUsersRequests(
            @RequestParam(name = "page", defaultValue = "0", required = false) int pageNumber,
            @RequestParam(name = "size", defaultValue = "5", required = false) int pageSize,
            Model model
    ) {
        log.info("Get Users requests");

        var pageRequest = PageRequest.of(pageNumber, pageSize);
        model.addAttribute("requestsList", orderService.findAllRequestsOfNonBlockedUsers(pageRequest));
        return "admin/users_requests";
    }

    @DeleteMapping("/cancel/{orderId}")
    @ResponseStatus(HttpStatus.OK)
    public void cancelOrder(@PathVariable Long orderId) throws ResourceUniqueViolationException, ResourceNotFoundException {
        long userId = resolveUserId();
        orderService.cancelOrder(userId, orderId);
    }


}
