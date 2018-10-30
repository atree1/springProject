package org.atree.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class BoardAttachVO {

	private String uuid,uploadpath,filename;
	private boolean fileType;
	private int bno;
	
	
	
	
}
