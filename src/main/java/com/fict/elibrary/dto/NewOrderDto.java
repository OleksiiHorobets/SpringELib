package com.fict.elibrary.dto;

import com.fict.elibrary.enums.OrderType;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class NewOrderDto {
    @NotNull
    private Long bookId;
    @NotNull
    private OrderType orderType;
}
