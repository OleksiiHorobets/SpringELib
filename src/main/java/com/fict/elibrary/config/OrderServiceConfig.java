package com.fict.elibrary.config;

import lombok.Getter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

import java.math.BigDecimal;

@Getter
@Configuration
public class OrderServiceConfig {
    private final BigDecimal usdPerDayFine;
    private final Integer subscriptionDays;

    public OrderServiceConfig(
            @Value("${orders.fine.day}") BigDecimal usdPerDayFine,
            @Value("${orders.subscription.days}") Integer subscriptionDays) {
        this.usdPerDayFine = usdPerDayFine;
        this.subscriptionDays = subscriptionDays;
    }
}
