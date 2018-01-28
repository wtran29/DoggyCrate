package com.wtran.beltexam.config;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import com.wtran.beltexam.models.User;
import com.wtran.beltexam.services.UserService;

@Component
@Lazy
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler{

	private UserService userService;
	public CustomLogoutSuccessHandler(UserService userService) {
		this.userService = userService;
	}
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void onLogoutSuccess(HttpServletRequest request,
			HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		// Code For Business Here
		userService.findByUpdatedAt(userService.findByEmail(authentication.getName()));
			
		
		logger.info("Logout Successful with Principal: " + authentication.getName());
		
		response.setStatus(HttpServletResponse.SC_OK);
        //redirect to login
		response.sendRedirect("/login");
	}
}
