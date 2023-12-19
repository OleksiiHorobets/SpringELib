package com.fict.elibrary.repository;

import com.fict.elibrary.entity.Publisher;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PublisherRepository extends JpaRepository<Publisher, Long> {
    List<Publisher> findAllByOrderByTitleAsc();

}
