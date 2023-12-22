package com.fict.elibrary.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;

import java.math.BigDecimal;

@Configuration
@EnableConfigurationProperties
public class OrderServiceConfig {
    private final BigDecimal usdPerDayFine;

    public OrderServiceConfig(@Value("${orders.fine.day}") BigDecimal usdPerDayFine) {
        this.usdPerDayFine = usdPerDayFine;
    }

    public BigDecimal getUsdPerDayFine() {
        return usdPerDayFine;
    }
}
