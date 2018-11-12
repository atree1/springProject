package org.atree.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.bind.annotation.CookieValue;
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

	private BoardService service;

	@GetMapping("/list")
	public void list(@ModelAttribute("pageObj") PageParam pageParam, Model model) {
		log.info("list get......................");
		pageParam.setTotal(service.getTotal(pageParam));
		model.addAttribute("list", service.getList(pageParam));
	}

	@GetMapping("/register")
	public void registerGET() {

	}

	@PostMapping("/register")
	public String registerPost(RedirectAttributes rttr, @ModelAttribute("board") @Valid BoardVO boardVO,
			BindingResult bindingResult) {
		log.info("-----------------------------------------------");
		log.info("binding:" + bindingResult);
		if (boardVO.getAttachList() != null) {
			log.info("-----------------------------------------------");
			boardVO.getAttachList().forEach(attach -> log.info(attach));
		}
		if (bindingResult.hasErrors()) {
			log.info("Has Error .........................");
			return "redirect:/board/register";
		}

		int result = service.register(boardVO);
		rttr.addFlashAttribute("result", result == 1 ? "SUCCESS" : "FAIL");

		return "redirect:/board/list";
	}

	@GetMapping("/read")
	public void read(@CookieValue(value = "viewCookie", required = false) String viewCookie,
			@ModelAttribute("pageObj") PageParam pageParam, Model model) {

		BoardVO vo = service.read(pageParam);

		log.info(viewCookie);
		if (viewCookie != null) {
			String[] numbers = viewCookie.split("_");
			boolean check = false;
			String bno = "" + pageParam.getBno();
			log.info(bno);

			for (String number : numbers) {
				log.info(number);
				
				if (number.equals(bno)) {
					check = true;
					log.info(check);
					break;
				}
			}

			if (!check) {
				service.upViewCnt(vo);
			}
		}
		log.info("read page..........");
		log.info(pageParam);
		model.addAttribute("board", vo);

	}

	@GetMapping("/modify")
	public void modify(@ModelAttribute("pageObj") PageParam pageParam, Model model) {

		log.info("modify page..........");
		log.info(pageParam);
		model.addAttribute("board", service.read(pageParam));

	}

	@PostMapping("/modify")
	public String modify(@ModelAttribute("pageObj") PageParam pageParam, @ModelAttribute("board") BoardVO boardVO,
			RedirectAttributes rttr) {
		int result = service.modify(boardVO);
		log.info("post modify......................................");
		log.info(pageParam);
		rttr.addFlashAttribute("result", result == 1 ? "SUCCESS" : "FAILED");
		return pageParam.getLink("redirect:/board/read");
	}

	@PostMapping("/remove")
	public String remove(@ModelAttribute("pageObj") PageParam pageParam, @ModelAttribute("board") BoardVO boardVO,
			RedirectAttributes rttr) {
		int result = service.remove(boardVO);
		if (result == 1) {
			List<BoardAttachDTO> attachList = service.getAttachList(pageParam.getBno());
		}
		rttr.addFlashAttribute("result", result == 1 ? "SUCCESS" : "FAILED");
		return pageParam.getLink("redirect:/board/list");
	}

	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachDTO>> getAttachList(int bno) {

		List<BoardAttachDTO> result = service.getAttachList(bno);
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}

	private void deleteFiles(List<BoardAttachDTO> attachList) {
		if (attachList == null || attachList.size() == 0) {
			return;
		}
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get(
						"C:\\upload\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());

				Files.deleteIfExists(file);

				if (Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\s_" + attach.getUuid() + "_"
							+ attach.getFileName());
					Files.delete(thumbNail);
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		});
	}

}
