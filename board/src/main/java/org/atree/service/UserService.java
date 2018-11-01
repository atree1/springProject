package org.atree.service;

import org.atree.domain.UserVO;
import org.atree.mapper.UserMapper;

import lombok.AllArgsConstructor;

public interface UserService {


	public UserVO get(UserVO vo);
	public int regist(UserVO vo);
}
