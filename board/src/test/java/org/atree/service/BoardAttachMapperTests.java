package org.atree.service;


import org.atree.domain.BoardVO;
import org.atree.mapper.BoardMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardAttachMapperTests {

	@Setter(onMethod_=@Autowired)
	BoardMapper mapper;
	@Test
	public void test(){
		BoardVO vo =new BoardVO();
		vo.setTitle("as");
		vo.setContent("asdas");
		vo.setWriter("asd");
		log.info(mapper.insertSelectKey(vo));
	log.info(vo.getBno());
	}
}
