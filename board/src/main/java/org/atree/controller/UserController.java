package org.atree.controller;

import javax.validation.Valid;

import org.atree.domain.MemberVO;
import org.atree.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/*")

public class UserController {
	
	
	@Setter(onMethod_=@Autowired)
	private MemberService service;
	@Setter(onMethod_=@Autowired)
	private PasswordEncoder pwEncoder;
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
	public String registerPost(RedirectAttributes rttr,@Valid MemberVO vo,BindingResult bindingResult) {
		
		if (bindingResult.hasErrors()) {
			log.info("Has Error .........................");
			return "redirect:/user/register";
		}
		String pw=pwEncoder.encode(vo.getUserpw());
		vo.setUserpw(pw);
		
		int result=service.register(vo);
	
		rttr.addAttribute("result",result==1?"SUCCESS":"FAIL");
		
		return "redirect:/user/login";
	}

}