package org.atree.mapper;

import org.atree.domain.UserVO;

public interface UserMapper {
	
	public UserVO get(UserVO vo);
	public int insert(UserVO vo);
	
}
