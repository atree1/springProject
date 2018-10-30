package org.atree.service;

import java.util.List;

import org.atree.domain.BoardAttachVO;
import org.atree.mapper.BoardAttachMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class BoardAttachServiceImpl implements BoardAttachService {

	BoardAttachMapper mapper;
	@Override
	public int insert(BoardAttachVO vo) {
		// TODO Auto-generated method stub
		return mapper.insert(vo);
	}

	@Override
	public int remove(BoardAttachVO vo) {
		// TODO Auto-generated method stub
		return mapper.delete(vo);
	}

	@Override
	public List<BoardAttachVO> getList(BoardAttachVO vo) {
		// TODO Auto-generated method stub
		return getList(vo);
	}

}
