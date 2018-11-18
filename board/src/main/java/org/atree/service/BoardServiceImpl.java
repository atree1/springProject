package org.atree.service;

import java.util.List;

import org.atree.domain.BoardAttachDTO;
import org.atree.domain.BoardVO;
import org.atree.domain.LikeVO;
import org.atree.domain.PageParam;
import org.atree.mapper.BoardAttachMapper;
import org.atree.mapper.BoardMapper;
import org.atree.mapper.LikeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;

	@Setter(onMethod_ = @Autowired)
	private LikeMapper likeMapper;

	@Transactional
	@Override
	public int register(BoardVO vo) {
		// TODO Auto-generated method stub
		// int result=mapper.create(vo);
		int result = mapper.insertSelectKey(vo);
		if (vo.getAttachList() == null || vo.getAttachList().size() <= 0) {
			return result;
		}

		for (BoardAttachDTO attach : vo.getAttachList()) {
			attach.setBno(vo.getBno());
			attachMapper.insert(attach);
		}
		return result;
	}

	@Override
	public BoardVO read(PageParam pageParam) {
		// TODO Auto-generated method stub
		return mapper.read(pageParam);
	}

	@Transactional
	@Override
	public int modify(BoardVO vo) {

		attachMapper.deleteAll(vo.getBno());

		if (vo.getAttachList() == null) {
			return mapper.update(vo);
		}
		if (vo.getAttachList().size() > 0) {
			vo.getAttachList().forEach(attach -> {
				attach.setBno(vo.getBno());
				attachMapper.insert(attach);
			});
		}
		return mapper.update(vo);
	}

	@Transactional
	@Override
	public int remove(BoardVO vo) {
		// TODO Auto-generated method stub
		attachMapper.deleteAll(vo.getBno());
		return mapper.delete(vo);
	}

	@Override
	public List<BoardVO> getList(PageParam pageParam) {
		// TODO Auto-generated method stub
		return mapper.getList(pageParam);
	}

	@Override
	public int getTotal(PageParam pageParam) {
		// TODO Auto-generated method stub
		return mapper.count(pageParam);
	}

	@Override
	public List<BoardAttachDTO> getAttachList(int bno) {
		// TODO Auto-generated method stub
		return attachMapper.findByBno(bno);
	}

	@Override
	
	public int upViewCnt(BoardVO vo) {
		// TODO Auto-generated method stub
		return mapper.upViewCnt(vo);
	}

	@Transactional
	@Override
	public int updateLike(int bno,String userid) {
		// TODO Auto-generated method stub
		LikeVO likeVO = likeMapper.getLike(new LikeVO(bno,userid));

		if (likeVO == null) {
			likeMapper.insertLike(new LikeVO(bno,userid));
			mapper.updateLike(bno, 1);
			return mapper.getLikeCount(bno);
			
		}
		else {
			likeMapper.deleteLike(likeVO);
			mapper.updateLike(bno, -1);
			return mapper.getLikeCount(bno);
		
		}

		

	}

}
