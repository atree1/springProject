package org.atree.service;

import org.atree.domain.LikeVO;
import org.atree.domain.PageParam;
import org.atree.domain.ReplyVO;
import org.atree.mapper.BoardMapper;
import org.atree.mapper.LikeMapper;
import org.atree.mapper.ReplyMapper;
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
public class replyMapperTests {

	@Setter(onMethod_=@Autowired)
	ReplyMapper mapper;
	@Setter(onMethod_=@Autowired)
	BoardMapper bmapper;
	
	
	@Setter(onMethod_=@Autowired)
	BoardService service;
	@Setter(onMethod_=@Autowired)
	LikeMapper lMapper;
	@Test
	public void likeTest() {
	lMapper.getLike(new LikeVO(23,"atree"));
	}
	@Test
	public void testService() {
		
		log.info(service.updateLike(464607,"atree"));
		
	}
	@Test
	public void test(){
		ReplyVO vo=new ReplyVO();
		vo.setReply("hi");
		vo.setReplyer("atree");
		vo.setBno(463070);
		PageParam pageParam=new PageParam();
		pageParam.setBno(458978);
		pageParam.setPage(1);
		log.info(mapper.getList(pageParam));
	
		log.info(mapper.depthGetList(pageParam));
	}
}
