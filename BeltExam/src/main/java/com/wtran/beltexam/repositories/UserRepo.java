package com.wtran.beltexam.repositories;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.wtran.beltexam.models.Box;
import com.wtran.beltexam.models.User;

@Repository
public interface UserRepo extends CrudRepository<User, Long>{
	User findByEmail(String email);
	
	User findByFirstname(String firstname);
	User findByLastname(String lastname);
	User findByUpdatedAt(Date updatedAt);
	List<User>findAll();
	List<User> findByRoles_NameIs(String name);
	User findById(Long id);
	
	
	@Query("SELECT u, r FROM User u JOIN u.roles r")
	List<Object[]> allUsers();

	

	

	
	
	
}
