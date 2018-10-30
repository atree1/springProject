package org.atree.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class PageParam {

	private int page, bno, start, end, total, display;
	private double per;
	private boolean prev, next;
	private String type, keyword;
	private String[] types;

	public void setDisplay(int display) {
		this.display = display;
		this.per = (double) display;
	}

	public void setTotal(int total) {
		this.end = (int) (Math.ceil(this.page / 10.0)) * 10;
		this.start = this.end - 9;

		if (this.end * display > total) {
			this.end = (int) (Math.ceil(total /(double)(display)));
			this.next = false;

		} else {
			this.next = true;
		}
		this.prev = this.start != 1;
	}

	public int getSkip() {
		return (this.page - 1) * display;

	}

	public void setType(String type) {
		this.type = type;

		if (type == null || type.trim().length() == 0) {
			this.types = null;
			return;
		}

		this.types = type.split("");
	}

	public String getLink(String path) {
		return UriComponentsBuilder.fromPath(path)
				.queryParam("bno", this.bno).queryParam("page", this.page)
				.queryParam("type", this.type)
				.queryParam("keyword", this.keyword)
				.toUriString();
	}

	public PageParam() {
		this.page = 1;
		this.display = 10;
		
	}

}
