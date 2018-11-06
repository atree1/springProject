package org.atree.security.domain;

import java.util.Collection;

import org.atree.domain.MemberVO;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Data;

public class Customer extends User{public Customer(String username, String password, boolean enabled, boolean accountNonExpired,
			boolean credentialsNonExpired, boolean accountNonLocked,
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
		// TODO Auto-generated constructor stub
	}
/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private MemberVO member;
	
	
	
}
