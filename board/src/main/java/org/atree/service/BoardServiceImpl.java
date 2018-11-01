package org.atree.service;

import java.util.List;

import org.atree.domain.BoardAttachDTO;
import org.atree.domain.BoardVO;
import org.atree.domain.PageParam;
import org.atree.mapper.BoardAttachMapper;
import org.atree.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BoardServiceImpl implements BoardService{

	@Setter(onMethod_=@Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_=@Autowired)
	private BoardAttachMapper attachMapper;
	
	@Transactional
	@Override
	public int register(BoardVO vo) {
		// TODO Auto-generated method stub
		int result=mapper.create(vo);
		
		if(vo.getAttachList()==null||vo.getAttachList().size()<=0) {
			return result;
		}
		int bno=mapper.maxBno();
		for (BoardAttachDTO attach:vo.getAttachList()) {
			attach.setBno(bno);
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
	
		if(vo.getAttachList()==null) {
			return mapper.update(vo);
		}
				if(vo.getAttachList().size()>0) {
			vo.getAttachList().forEach(attach->{
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

	
}
