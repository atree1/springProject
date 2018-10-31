package org.atree.controller;


import java.util.List;

import javax.validation.Valid;

import org.atree.domain.BoardAttachDTO;
import org.atree.domain.BoardVO;
import org.atree.domain.PageParam;
import org.atree.service.BoardService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@Log4j
@AllArgsConstructor
public class BoardController {

	BoardService service; 
	@GetMapping("/list")
	public void list(@ModelAttribute("pageObj")PageParam pageParam,Model model) {
		log.info("list get......................");
		pageParam.setTotal(service.getTotal(pageParam));
		model.addAttribute("list" ,service.getList(pageParam));
	}

	@GetMapping("/register")
	public void registerGET() {
		
	}
	
	@PostMapping("/register")
	public String registerPost(RedirectAttributes rttr, @ModelAttribute ("board")@Valid BoardVO boardVO, BindingResult bindingResult) {
		log.info("-----------------------------------------------");
		log.info("binding:"+bindingResult);
		if(boardVO.getAttachList()!=null) {
			log.info("-----------------------------------------------");
			boardVO.getAttachList().forEach(attach->log.info(attach));
		}
		if(bindingResult.hasErrors()) {
			log.info("Has Error .........................");
			return "redirect:/board/register";
		}
		
		int result = service.register(boardVO);
		rttr.addFlashAttribute("result", result==1?"SUCCESS":"FAIL");
		
		return "redirect:/board/list";
	}
	@GetMapping({"/read","/modify"})
	public void read(@ModelAttribute("pageObj")PageParam pageParam,Model model) {
		log.info("read page..........");
		model.addAttribute("board",service.read(pageParam));
	}
	
	@PostMapping("/modify")
	public String modify(@ModelAttribute("pageObj")PageParam pageParam,@ModelAttribute("board")BoardVO boardVO,RedirectAttributes rttr) {
		int result=service.modify(boardVO);
		log.info("post modify......................................");
		rttr.addFlashAttribute("result",result==1?"SUCCESS":"FAILED");
		return pageParam.getLink("redirect:/board/read");
	}
	@PostMapping("/remove")
	public String remove(@ModelAttribute("pageObj")PageParam pageParam,@ModelAttribute("board")BoardVO boardVO,RedirectAttributes rttr) {
		int result=service.remove(boardVO);
		
		rttr.addFlashAttribute("result",result==1?"SUCCESS":"FAILED");
		return pageParam.getLink("redirect:/board/list");
	}
	@GetMapping(value="/getAttachList",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachDTO>> getAttachList(int bno){
		log.info("------------------------------------------------------");
		log.info("------------------------------------------------------");
		log.info("getAttachList json");
		List<BoardAttachDTO> result=service.getAttachList(bno);
		for (BoardAttachDTO dto : result) {
			log.info(dto.getFType());
			if(dto.getFType()=='i') {
			dto.setFileType(true);}
			log.info(dto.isFileType());
		}
		return new ResponseEntity<> (result,HttpStatus.OK);
	}
}
