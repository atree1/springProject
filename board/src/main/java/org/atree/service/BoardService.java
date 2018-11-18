package org.atree.service;

import java.util.List;

import org.atree.domain.BoardAttachDTO;
import org.atree.domain.BoardVO;
import org.atree.domain.PageParam;

public interface BoardService {

	public int register(BoardVO vo);
	public BoardVO read(PageParam pageParam);
	public int modify(BoardVO vo);
	public int remove(BoardVO vo);
	public int getTotal(PageParam pageParam);
	public List<BoardVO> getList(PageParam pageParam);
	public List<BoardAttachDTO> getAttachList(int bno);
	public int upViewCnt(BoardVO vo);
	public int updateLike(int bno,String userid);
}
