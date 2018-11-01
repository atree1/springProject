package org.atree.mapper;

import java.util.List;

import org.atree.domain.BoardAttachDTO;

public interface BoardAttachMapper {

	public int insert(BoardAttachDTO vo);
	public int delete(String uuid);
	public void deleteAll(int bno);

	public List<BoardAttachDTO> findByBno(int bno);
}
