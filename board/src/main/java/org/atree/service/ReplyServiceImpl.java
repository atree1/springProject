package org.atree.service;

import java.util.List;

import org.atree.domain.PageParam;
import org.atree.domain.ReplyPageDTO;
import org.atree.domain.ReplyVO;
import org.atree.mapper.BoardMapper;
import org.atree.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Setter(onMethod_=@Autowired)
	private ReplyMapper mapper;
	@Setter(onMethod_=@Autowired)
	private BoardMapper boardMapper;
	
	@Transactional
	@Override
	public int register(ReplyVO vo) {
		// TODO Auto-generated method stub
		boardMapper.updateReplyCnt(vo.getBno(),1);
		//return mapper.create(vo);
		return mapper.depthInsert(vo);
	}

	@Override
	public ReplyVO read(PageParam pageParam) {
		// TODO Auto-generated method stub
		return mapper.read(pageParam);
	}

	@Override
	public int modify(ReplyVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	@Transactional
	public int remove(ReplyVO vo) {
		// TODO Auto-generated method stub
		boardMapper.updateReplyCnt(vo.getBno(),-1);
		return mapper.delete(vo);
	}

	@Override
	public int getTotal(PageParam pageParam) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<ReplyVO> getList(PageParam pageParam) {
		// TODO Auto-generated method stub
//		return mapper.getList(pageParam);
		return mapper.depthGetList(pageParam);

	}

	@Override
	public ReplyPageDTO getListPage(PageParam pageParam) {
		// TODO Auto-generated method stub
		return new ReplyPageDTO(mapper.count(pageParam),mapper.depthGetList(pageParam));
	}
	
	

}
