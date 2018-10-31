package org.atree.domain;

import lombok.Data;

@Data
public class BoardAttachDTO {

	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	private char fType;
	private int bno;
	
	public char getImg() {
		if(fileType) {
			
			return 'i';
		}
		else {
			return 'n';	
		}
	}
	
	
}
