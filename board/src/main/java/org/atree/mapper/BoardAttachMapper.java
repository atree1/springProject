package org.atree.mapper;

import java.util.List;

import org.atree.domain.BoardAttachVO;

public interface BoardAttachMapper {

	public int insert(BoardAttachVO vo);
	public int delete(BoardAttachVO vo);
	public List<BoardAttachVO> findByBno(BoardAttachVO vo);
}
