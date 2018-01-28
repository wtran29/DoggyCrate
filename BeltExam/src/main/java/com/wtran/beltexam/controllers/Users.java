package com.wtran.beltexam.controllers;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.wtran.beltexam.models.Box;
import com.wtran.beltexam.models.User;
import com.wtran.beltexam.services.BoxService;
import com.wtran.beltexam.services.UserService;
import com.wtran.beltexam.validator.UserValidator;

@Controller
public class Users {
	private UserService userService;
	private UserValidator userValidator;
	private BoxService boxService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("MMMM-dd-yyyy");
	    dateFormat.setLenient(false);
	    binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
	}
	
    public Users(UserService userService, UserValidator userValidator, BoxService boxService) {
        this.userService = userService;
        this.userValidator = userValidator;
        this.boxService = boxService;
        
        
    }
 
	
	@RequestMapping("/registration")
    public String register(@Valid @ModelAttribute("user") User user) {
        System.out.println("hit the index page");
		return "subscribe.jsp";
    }
	@RequestMapping("/")
	public String redirect(Principal principal) {
		String email = principal.getName();
		User user = userService.findByEmail(email);
		List<User> allAdmin = userService.getAdmin();
		if(allAdmin.contains(user)) {
			return "redirect:/admindash";
		} else {
			
			return "redirect:/subscribe";
		}
	}
	
	
	@PostMapping("/registration")
	public String registration(@Valid @ModelAttribute("user") User user, BindingResult result, Model model) {
		userValidator.validate(user, result);
		
		if(result.hasErrors()) {
			System.out.println("hit errors in registration");
			
		}
		if(userService.getAdmin().isEmpty()) {
			System.out.println("saved admin role");
			userService.saveUserWithAdminRole(user);
			
			return "redirect:/admindash";
			
		}
		
		if(userService.findByEmail(user.getEmail()) == null) {
			System.out.println("saved user role");
			userService.saveWithUserRole(user);
			return "redirect:/subscribe";
		}
		else {
			model.addAttribute("regMessage", "Email already exists!");
			return "index.jsp";
		}
		
	}
	
	@RequestMapping("/adminz/{id}")
	public String makeAdmin(@PathVariable("id") Long id) {
		System.out.println("saved admin role");
		User user = userService.findById(id);
		userService.saveUserWithAdminRole(user);

		return "redirect:/admindash";
	}
		
    
    @RequestMapping("/login")
    public String login(@RequestParam(value="error", required=false) String error, @RequestParam(value="logout", required=false) String logout, Model model, @ModelAttribute("user") User user) {
    	if(error !=null) {
    		System.out.println("errors at login");
    		model.addAttribute("errorMessage", "Invalid Credentials, Please try again.");
    		
    	}
    	if(logout != null) {
    		System.out.println("logging out");
    		model.addAttribute("logoutMessage", "Logout Successful!");
    		
    	}
    	return "index.jsp";
    	
    }
    
    @RequestMapping("/logout")
    public String logout(@RequestParam(value="logout", required=false) String logout, Model model) {
    	if(logout != null) {
    		System.out.println("logging out");
    		model.addAttribute("logoutMessage", "Logout Successful!");
    		
    	}
    	return "index.jsp";
    }
     
    @RequestMapping(value = {"/dashboard", "/home"})
    public String home(Principal principal, Model model) {

    	String email = principal.getName();
    	
    	model.addAttribute("currentUser", userService.findByEmail(email));
    	return "redirect:/adminDash";
    	
    }
   
//    @RequestMapping("/delete/{id}")
//    public String delete(@PathVariable("id") Long id) {
//    	System.out.println("Deleting in controller");
//    	userService.deleteUser(id);
//    	return "redirect:/admindash";
//    }
    
    @RequestMapping("/admindash")
	public String index(@ModelAttribute("user") User user, @ModelAttribute("box") Box box, Model model) {
    	System.out.println("Getting all users");
		model.addAttribute("allUsers", userService.allUsers());
    	model.addAttribute("allBoxes", boxService.allBoxes());

		return "admin.jsp";
	}

    
    @RequestMapping("/dashboard/{id}")
    public String show(Model model, @PathVariable("id") Long id) {
    	System.out.println("Showing user");
    	User user = userService.getUser(id);
    	model.addAttribute("id",id);
    	model.addAttribute("currentUser", user);
    	return "subscribe.jsp";
    }
   @PostMapping("/box")
   public String createBox(@Valid @ModelAttribute("box") Box box, BindingResult result, Model model, Principal principal) {
	   box.setActivate(true);
	   if(result.hasErrors()) {
		   System.out.println("errors creating box");
		   model.addAttribute("boxMessage", "Must provide package name and cost, Please try again.");
		   return "redirect:/admindash";
	   }
	   else {
		   System.out.println("creating package");
		   boxService.createBox(box);
		   return "redirect:/admindash";
	   }
   }
   
   @RequestMapping("/subscribe")
   public String selection(@ModelAttribute("user") User user, Model model, Principal principal) {
	   String email = principal.getName();
	   User currentUser = userService.findByEmail(email);
	   model.addAttribute("currentUser", currentUser);
	   model.addAttribute("allBoxes", boxService.allBoxes());
	   
	   return "subscribe.jsp";
   }
   
   @PostMapping("/subscribe")
   public String createSubscription(@Valid @ModelAttribute("user") User user, Principal principal, @RequestParam("dueDate") int dueDate, @RequestParam("box") Box box, Model model, BindingResult result) {
	   String email = principal.getName();   	
	   User current = userService.findByEmail(email);
	   System.out.println(box);
	   System.out.println(dueDate);
	   System.out.println(current);
	   if(result.hasErrors()) {
		   model.addAttribute("currentUser", current);
		   return "subscribe.jsp";
	   }else {
		   
		   current.setBox(box);
		   current.setDueDate(dueDate);
		   userService.update(current);
		   return "redirect:/profile";
		   
	   }
	  
   }
   
//   @PostMapping("/subscribebox")
//   public String createSubscription(Principal principal, @RequestParam("dueDate") int dueDate, @RequestParam("boxes") Box box, Model model) {
////	   Box userbox = boxService.findByBoxId(userboxId);
//	   System.out.println("came here");
//	   return "redirect:/profile";
//	   String email = principal.getName();
//	   	
//	   User current = userService.findByEmail(email);
//	   
//   	
//	   userService.findByEmail(email);
//	   current.setBox(box);
//	   current.setDueDate(dueDate);
//	   userService.save(current);
//	   return "redirect:/profile"; 
//	   Date today = new Date();
//	   today.getDay();
//	   System.out.println(today.getDay());
//	   return "subscribe.jsp"; 
//	   if(dueDate>today) {
//		   subscribeService.createSubscribe(box);
//	   }
  
//   }
   @RequestMapping("/profile")
   public String profile(@ModelAttribute("user") User user, Principal principal, Model model) {
	   String email = principal.getName();   	
	   User current = userService.findByEmail(email);
	   model.addAttribute("currentUser", current);
	   return "profile.jsp";
   }
   @RequestMapping("/deactivate/{id}")
   public String deactivate(@PathVariable("id") Long id, @ModelAttribute("box") Box box) {
	   System.out.println("came in here");
	   Box boxId = boxService.getById(id);
	   boxId.setActivate(false);
	   boxService.save(boxId);
	   return "redirect:/admindash";
   }
   
   @RequestMapping("/activate/{id}")
   public String activate(@PathVariable("id") Long id, @ModelAttribute("box") Box box) {
	   Box boxId = boxService.getById(id);
	   boxId.setActivate(true);
	   boxService.save(boxId);
	   return "redirect:/admindash";
   }
   
   @RequestMapping("/delete/{id}")
   public String delete(@PathVariable("id") Long id, @ModelAttribute("box") Box box) {
	   Box boxId = boxService.getById(id);
	   boxService.delete(boxId);
	   return "redirect:/admindash";
   }
}