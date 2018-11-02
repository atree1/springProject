package org.atree.service;

import java.util.List;

import org.atree.domain.PageParam;
import org.atree.domain.ReplyPageDTO;
import org.atree.domain.ReplyVO;



public interface ReplyService {

	public int register(ReplyVO vo);
	public ReplyVO read(PageParam pageParam);
	public int modify(ReplyVO vo);
	public int remove(ReplyVO vo);
	public int getTotal(PageParam pageParam);
	public List<ReplyVO> getList(PageParam pageParam);
	public ReplyPageDTO getListPage(PageParam pageParam);

}
