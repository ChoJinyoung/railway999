package com.dorothy.railway999.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dorothy.railway999.annotation.Auth;
import com.dorothy.railway999.service.NoticeService;
import com.dorothy.railway999.vo.NoticeVo;



@Controller
@RequestMapping("/notice")
public class NoticeCotroller {

	@Autowired
	private NoticeService noticeservice;
	@RequestMapping({ "/list", "", "/search" })
	public String list(
			@RequestParam(value = "p", required = true, defaultValue = "1") int page,
			Model model) {
		Map<String, Object> listData = noticeservice.list(page);
		model.addAttribute("listData", listData);
		return "/board/notice";
	}
	
	
	@Auth(role = "Admin")
	@RequestMapping("/insert")
	public String insert(@ModelAttribute NoticeVo vo) {
		noticeservice.writeNotice(vo);
		return "redirect:/notice";

	}

	@Auth(role = "Admin")
	@RequestMapping("/delete")
	public String delete(@ModelAttribute NoticeVo vo) {
		noticeservice.deleteNotice(vo);
		return "redirect:/notice";
	}

	@Auth(role = "Admin")
	@RequestMapping("/update")
	public String update(@ModelAttribute NoticeVo vo) {
		noticeservice.updateNotice(vo);
		return "redirect:/notice";
	}
	
	@Auth(role = "Admin")
	@RequestMapping("/modify")
	public String modify(@ModelAttribute NoticeVo vo, Model model) {
		NoticeVo noticeVo = noticeservice.viewNotice(vo);
		model.addAttribute("notice", noticeVo);
		return "/board/noticemodifyform";
	}

	@Auth(role = "Admin")
	@RequestMapping("/noticeform")
	public String noticeform() {
		return "/board/noticewriteform";
	}

	@RequestMapping("/viewform")
	public String viewform(Model model, @ModelAttribute NoticeVo vo) {
		NoticeVo noticeVo = noticeservice.viewNotice(vo);
		model.addAttribute("notice", noticeVo);
		return "/board/noticeviewform";
	}

}