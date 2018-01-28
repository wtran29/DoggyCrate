package com.wtran.beltexam.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.wtran.beltexam.models.Box;
import com.wtran.beltexam.repositories.BoxRepo;

@Service
public class BoxService {

	private BoxRepo boxRepository;
	
	public BoxService(BoxRepo boxRepository) {
		this.boxRepository = boxRepository;
	}
	public Box createBox(Box box) {
		return boxRepository.save(box);
	}
	public List<Box> allBoxes() {
		return boxRepository.findAll();
	}
	public Box findByBoxId(Long userboxId) {
		return boxRepository.findOne(userboxId);
	}
	public Box getById(Long id) {
		// TODO Auto-generated method stub
		return boxRepository.getById(id);
	}
	public void save(Box boxId) {
		boxRepository.save(boxId);
		
	}
	public void delete(Box boxId) {
		boxRepository.delete(boxId);
		
	}
}
