package org.atree.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.atree.domain.BoardVO;
import org.atree.domain.PageParam;

public interface BoardMapper {

	public int create(BoardVO vo);
	public BoardVO read(PageParam pageParam);
	public int update(BoardVO vo);
	public int delete(BoardVO vo);
	public List<BoardVO> getList(PageParam pageParam);
	public int count(PageParam pageParam);
	public int maxBno();
	public void updateReplyCnt(@Param("bno") int bno,@Param("amount") int amount);
	public int insertSelectKey(BoardVO vo);
	public int upViewCnt(BoardVO vo);
	public int upLikeCnt(BoardVO vo);
	public int getLikeCount(int bno);
}
