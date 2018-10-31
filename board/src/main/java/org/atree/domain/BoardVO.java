package org.atree.domain;

import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class BoardVO {
	private Integer bno;
	@NotEmpty(message="공백 금지")
	private String title,content,writer;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date regdate,updatedate;
	private char deleted;
	private int replyCnt;
	private List<BoardAttachDTO> attachList;
}
