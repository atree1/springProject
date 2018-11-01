package org.atree.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class UserVO {

	private String userid,userpw,username;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date regdate,updatedate;
}
