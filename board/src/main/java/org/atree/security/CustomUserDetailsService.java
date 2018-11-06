package org.atree.security;

import org.atree.domain.MemberVO;
import org.atree.mapper.MemberMapper;
import org.atree.security.domain.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService{

	@Setter(onMethod_=@Autowired)
	private MemberMapper mapper;
	
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException{
	
		log.warn("Load User :"+userName);
		MemberVO vo=mapper.getMember(userName);
		
		log.info(vo);
		return new Customer(vo);
	}
	
}
