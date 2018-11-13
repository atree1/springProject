package org.atree.domain;

import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.NotEmpty;

import lombok.Data;

@Data
public class MemberVO {
	
	@NotEmpty
	private String userid,userpw,username;
	private boolean enabled;
	
	private Date regdate;
	private Date updatedate;
	private List<AuthVO> authList;
	
}
