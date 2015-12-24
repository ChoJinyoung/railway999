package com.dorothy.railway999.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dorothy.railway999.annotation.Auth;
import com.dorothy.railway999.service.QboardService;
import com.dorothy.railway999.vo.QboardVo;


@Controller
@RequestMapping ("/qboard")
public class QboardController {
	
	@Autowired
	private QboardService qboardservice;
	
	
	@RequestMapping({ "/list", "" })
	public String list(
			@RequestParam(value = "p", required = true, defaultValue = "1") int page,
			@RequestParam(value = "kwd", required = false) String kwd,
			Model model) {
		Map<String, Object> listData = qboardservice.list(page, kwd);
		model.addAttribute("listData", listData);
		return "/board/qboard";
	}

	
	@Auth(role="")
	@RequestMapping( "/insertform" )
	public String insertform(Model model,@ModelAttribute QboardVo vo) {
		model.addAttribute("vo",vo);
		return "/board/qboardwriteform";
	}
	
	@Auth(role="")
	@RequestMapping("/insert")
	public String insert(@ModelAttribute QboardVo vo){
		qboardservice.writeQboard(vo);
		return "redirect:/qboard/list";
	}
	
	
	@RequestMapping("/viewform/{qboardno}")
    public String viewform( @PathVariable( "qboardno" ) long no, Model model ){
       	QboardVo qboardVo = qboardservice.viewQboard(no);
		model.addAttribute("qboard", qboardVo);
       return "/board/qboardviewform";
    }

	@Auth(role="")
	@RequestMapping( "/updateform" )
	public String updateform( Model model,@RequestParam long no ) {
		QboardVo vo = qboardservice.modify(no);
		model.addAttribute("vo",vo);
		return "/board/qboardmodifyform";
	}
	
	@Auth(role="")
	@RequestMapping( "/update" )
	public String update( @ModelAttribute QboardVo vo ) {
		qboardservice.updateQboard(vo);
		return "redirect:/qboard/list";
	}
	
	@Auth(role="")
	@RequestMapping( "/delete" )
	public String delete( Model model,@RequestParam long no) {
		qboardservice.deleteQboard(no);
		return "redirect:/qboard/list";
	}


	

}
