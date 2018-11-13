package org.atree.controller;

import org.atree.domain.PageParam;
import org.atree.domain.ReplyPageDTO;
import org.atree.domain.ReplyVO;
import org.atree.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies")
@RestController
@Log4j

public class ReplyController {
	@Setter(onMethod_=@Autowired)
	private ReplyService service;
	@PreAuthorize("isAuthenticated")
	@PostMapping(value = "/new", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> create(@RequestBody ReplyVO vo) {
		log.info("reply vo :" + vo);

		int result = service.register(vo);

		return result == 1 ? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/pages/{bno}/{page}",produces={MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page")int page,@PathVariable("bno")int bno,Model model){
		PageParam pageParam=new PageParam();
		pageParam.setBno(bno);
		pageParam.setPage(page);
		pageParam.setTotal(service.getTotal(pageParam));
		log.info(service.getListPage(pageParam));
		return new ResponseEntity<>(service.getListPage(pageParam),HttpStatus.OK);
	}
	
	@GetMapping(value="/{rno}",produces={MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno")int rno){
		PageParam pageParam=new PageParam();
		pageParam.setRno(rno);
		return new ResponseEntity<ReplyVO>(service.read(pageParam),HttpStatus.OK);
	}
	@PreAuthorize("principal.username==#vo.replyer")
	@RequestMapping(method= {RequestMethod.PUT,RequestMethod.PATCH},value="/{rno}",consumes="application/json",
			produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo,@PathVariable("rno") int rno){

		vo.setRno(rno);
		int result=service.modify(vo);
		return result==1?new ResponseEntity<String>("success",HttpStatus.OK):new ResponseEntity<String> (HttpStatus.INTERNAL_SERVER_ERROR);
	}
	@PreAuthorize("principal.username==#vo.replyer")
	@RequestMapping(method= {RequestMethod.PUT,RequestMethod.PATCH},value="/delete/{rno}",consumes="application/json",
			produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> delete(@RequestBody ReplyVO vo,@PathVariable("rno") int rno){
	
		vo.setRno(rno);
		int result=service.remove(vo);
		return result==1?new ResponseEntity<String>("success",HttpStatus.OK):new ResponseEntity<String> (HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
