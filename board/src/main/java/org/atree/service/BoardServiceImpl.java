package org.atree.service;

import java.util.List;

import org.atree.domain.BoardVO;
import org.atree.domain.PageParam;
import org.atree.mapper.BoardMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{

	BoardMapper mapper;
	@Override
	public int register(BoardVO vo) {
		// TODO Auto-generated method stub
		return mapper.create(vo);
	}

	@Override
	public BoardVO read(PageParam pageParam) {
		// TODO Auto-generated method stub
		return mapper.read(pageParam);
	}

	@Override
	public int modify(BoardVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public int remove(BoardVO vo) {
		// TODO Auto-generated method stub
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

	
}
