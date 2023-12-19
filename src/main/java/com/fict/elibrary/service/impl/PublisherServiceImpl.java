package com.fict.elibrary.service.impl;

import com.fict.elibrary.dto.PublisherDto;
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
}
