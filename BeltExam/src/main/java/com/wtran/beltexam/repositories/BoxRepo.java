package com.wtran.beltexam.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.wtran.beltexam.models.Box;

public interface BoxRepo extends CrudRepository<Box, Long>{

	List<Box> findAll();
	List<Box> findByName(String name);
	Box getById(Long id);
}
