package com.fict.elibrary.converter;

import lombok.experimental.UtilityClass;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

@UtilityClass
public class DateFormatter {
    public static String formatLocalDateTime(LocalDateTime localDateTime, String pattern, String language) {
        var dateTimeFormatter = DateTimeFormatter.ofPattern(pattern,
                "ua".equals(language) ? new Locale("uk", "UA") : Locale.ENGLISH);
        return localDateTime.format(dateTimeFormatter);
    }
}
