package org.atree.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/*")

public class UserController {

	
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

}