package org.atree.domain;

import java.util.Date;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
@Data
public class ReplyVO {

	private int rno,bno,parent,seq,depth;
	@NotEmpty(message="占쏙옙占쏙옙占� 占쌉뤄옙占싹쇽옙占쏙옙")
	private String reply;
	private String replyer;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date replydate,updatedate;
	
}
