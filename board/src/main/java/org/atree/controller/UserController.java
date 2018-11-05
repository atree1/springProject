package org.atree.controller;

import org.atree.domain.UserVO;
import org.atree.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/*")
@AllArgsConstructor
public class UserController {

	
	private UserService service;
	@GetMapping("/login")
	public void login() {
		log.info("login get~~~~");
		
		
	}
	@GetMapping("/logout")
	public void logoutGet() {
		log.info("custom logout");
	}
	
	@GetMapping("/register")
	public void register() {
		log.info("register~~~~~~~");
	}
	@PostMapping("/register")
	public String register(@ModelAttribute("user") UserVO user) {
		log.info("login post~~~~~~");
	
		int result=service.regist(user);
		

		return result==1?"redirect:/user/login":"redirect:/user/register";
	}
}
