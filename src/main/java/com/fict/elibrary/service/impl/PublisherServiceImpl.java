package com.fict.elibrary.service.impl;

import com.fict.elibrary.dto.PublisherDto;
import com.fict.elibrary.exception.ResourceNotFoundException;
import com.fict.elibrary.mapper.PublisherMapper;
import com.fict.elibrary.repository.PublisherRepository;
import com.fict.elibrary.service.PublisherService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class PublisherServiceImpl implements PublisherService {
    private final PublisherRepository publisherRepository;
    private final PublisherMapper publisherMapper;

    @Override
    public List<PublisherDto> findAll() {
        return publisherMapper.toDtoList(publisherRepository.findAllByOrderByTitleAsc());
    }

    @Override
    public PublisherDto findById(Long id) throws ResourceNotFoundException {
        var publisher = publisherRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Publisher with the id {%d} not found!".formatted(id)));

        return publisherMapper.toDto(publisher);
    }
}
