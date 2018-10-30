package org.atree.service;

import java.util.List;

import org.atree.domain.BoardAttachVO;

public interface BoardAttachService {

	public int insert(BoardAttachVO vo);
	public int remove(BoardAttachVO vo);
	public List<BoardAttachVO> getList(BoardAttachVO vo);
}
