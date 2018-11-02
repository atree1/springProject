package org.atree.mapper;

import java.util.List;


import org.atree.domain.PageParam;
import org.atree.domain.ReplyVO;

public interface ReplyMapper {

	public int create(ReplyVO vo);
	public ReplyVO read(PageParam pageParam);
	public int update(ReplyVO vo);
	public int delete(ReplyVO vo);
	public List<ReplyVO> getList(PageParam pageParam);
	public int count(PageParam pageParam);
	public int depthInsert(ReplyVO vo);
	public List<ReplyVO> depthGetList(PageParam pageParam);
}
