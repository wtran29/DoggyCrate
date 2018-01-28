package com.wtran.beltexam.services;

import java.util.Date;
import java.util.List;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.wtran.beltexam.models.Box;
import com.wtran.beltexam.models.Role;
import com.wtran.beltexam.models.User;
import com.wtran.beltexam.repositories.BoxRepo;
import com.wtran.beltexam.repositories.RoleRepo;
import com.wtran.beltexam.repositories.UserRepo;



@Service
public class UserService {
	private UserRepo userRepository;
    private RoleRepo roleRepository;
    private BCryptPasswordEncoder bCryptPasswordEncoder;
    private BoxRepo boxRepository;
    
    public UserService(UserRepo userRepository, RoleRepo roleRepository, BCryptPasswordEncoder bCryptPasswordEncoder, BoxRepo boxRepository)     {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
        this.boxRepository = boxRepository;
    }
    
    
    // 1
    public void saveWithUserRole(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        user.setRoles(roleRepository.findByName("ROLE_USER"));
        userRepository.save(user);
    }
     
     // 2 
    public void saveUserWithAdminRole(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        user.setRoles(roleRepository.findByName("ROLE_ADMIN"));
        userRepository.save(user);
    }    
    
    // 3
    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }
    
    //4
    public User findByFirstname(String firstname) {
    	return userRepository.findByFirstname(firstname);
    }
    //5
    public User findByLastname(String lastname) {
    	return userRepository.findByLastname(lastname);
    }
    
    public User findByUpdatedAt(Date updatedAt) {
    	return userRepository.findByUpdatedAt(updatedAt);
    }


	public void findByUpdatedAt(User findByEmail) {
		// TODO Auto-generated method stub
		findByEmail.setUpdatedAt(new Date());
		userRepository.save(findByEmail);
	}
	
	public void deleteUser(Long id) {
		System.out.println("deleting User");
		userRepository.delete(id);
	}
	
	public List<User> getUsers(){
		System.out.println("getting list of users");
		return userRepository.findAll();
	}
	
	public User findById(Long id) {
		return userRepository.findById(id);
	}
	
	public List<User> allUsers() {
		return userRepository.findAll();
	}
	
	public User getUser(Long id) {
		return userRepository.findOne(id);
	}
	public List<User> getAdmin() {
		System.out.println("getting admin");
		return userRepository.findByRoles_NameIs("ROLE_ADMIN");
	}
	public User findByCurrentId(Long currentId) {
		return userRepository.findOne(currentId);
	}

	public void update(User current) {
		userRepository.save(current);
	}


	public User getById(Long id) {
		// TODO Auto-generated method stub
		return userRepository.findById(id);
	}




	
	
}