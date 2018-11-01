package org.atree.service;

import org.atree.domain.UserVO;
import org.atree.mapper.UserMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
@Service
@AllArgsConstructor
public class UserServiceImpl implements UserService {
	private UserMapper mapper;
	@Override
	public UserVO get(UserVO vo) {
		// TODO Auto-generated method stub
		return mapper.get(vo);
	}
	@Override
	public int regist(UserVO vo) {
		// TODO Auto-generated method stub
		return mapper.insert(vo);
	}

}
