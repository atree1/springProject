package org.atree.mapper;

import org.atree.domain.MemberVO;

public interface MemberMapper {

	public MemberVO getMember(String userid);
	public int insertMember(MemberVO vo);

}
