package org.atree.service;

import org.atree.domain.AuthVO;
import org.atree.domain.MemberVO;
import org.atree.mapper.MemberAuthMapper;
import org.atree.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;

@Service
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_=@Autowired)
	private MemberMapper mapper;
	@Setter(onMethod_=@Autowired)
	private MemberAuthMapper Authmapper;
	@Override
	
	@Transactional
	public int register(MemberVO vo) {
		// TODO Auto-generated method stub
		AuthVO authVO=new AuthVO();
		authVO.setUserid(vo.getUserid());
		authVO.setAuth("ROLE_MEMBER");
		mapper.insertMember(vo);
		return Authmapper.insertMemberAuth(authVO);
	}

}
