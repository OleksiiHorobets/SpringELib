package com.fict.elibrary.service;

import com.fict.elibrary.dto.PublisherDto;
import com.fict.elibrary.entity.Publisher;
import com.fict.elibrary.exception.ResourceNotFoundException;

import java.util.List;

public interface PublisherService {
    List<PublisherDto> findAll();

    Publisher findById(Long id) throws ResourceNotFoundException;

}
