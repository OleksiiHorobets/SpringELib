package com.fict.elibrary.service;

import com.fict.elibrary.dto.PublisherDto;

import java.util.List;

public interface PublisherService {
    List<PublisherDto> findAll();
}
