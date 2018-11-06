package org.atree.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.atree.domain.MemberVO;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class Customer extends User {
	
	 
	private static final long serialVersionUID = 1L;
	private MemberVO member;
	
	public Customer(MemberVO vo) {
		super(vo.getUserid(),vo.getUserpw(),true,true,true,true,vo.getAuthList().stream().map(auth->new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		this.member=vo;
	}
	
	public Customer(String username, String password, boolean enabled, boolean accountNonExpired,
			boolean credentialsNonExpired, boolean accountNonLocked,
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
		// TODO Auto-generated constructor stub
	
	
	
		}
	
}
