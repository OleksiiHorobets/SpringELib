package com.fict.elibrary;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;


@SpringBootApplication
public class ELibraryApplication {

    public static void main(String[] args) {
        var context = SpringApplication.run(ELibraryApplication.class, args);

        System.out.println(context);
    }

}
