package org.atree.domain;

import java.util.Date;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
@Data
public class ReplyVO {

	private int rno,bno;
	@NotEmpty(message="����� �Է��ϼ���")
	private String reply;
	private String replyer;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date replydate,updatedate;
	
}
