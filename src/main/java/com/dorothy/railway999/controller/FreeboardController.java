package com.dorothy.railway999.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dorothy.railway999.annotation.Auth;
import com.dorothy.railway999.service.FreeBoardService;
import com.dorothy.railway999.service.FreecommentService;
import com.dorothy.railway999.vo.FreeboardVo;
import com.dorothy.railway999.vo.FreecommentVo;


 

@Controller
@RequestMapping("/freeboard")
public class FreeboardController {
	@Autowired
	FreeBoardService boardService;
	
	@Autowired
	FreecommentService freecommentService;
	
	
	@RequestMapping({"/list",""})
	public String index(Model model,
						@RequestParam( value="p", required = true, defaultValue = "1" ) Long page){
		Map<String, Object> map = boardService.listBoard(page);
		model.addAttribute("list", map);
		return "/board/freeboard";
	}
	
	@Auth(role ="")
	@RequestMapping( "/insertform" )
	public String insertform(Model model,@ModelAttribute FreeboardVo vo) {
		model.addAttribute("vo",vo);
		return "/board/freeboardwriteform";
	}
	
	@Auth(role ="")
	@RequestMapping("/insert")
	public String insert(@ModelAttribute FreeboardVo vo){
		boardService.writeBoard(vo);
		return "redirect:/freeboard/list";
	}
	
	
	@RequestMapping( "/viewform" )
	public String viewform(ModelMap model, @RequestParam long no) {
	FreeboardVo vo=boardService.viewBoard(no);
	List<FreecommentVo> list=freecommentService.getByNo(no);
	model.put( "vo", vo );
	model.put("fvo", list);
		return "/board/freeboardviewform";
	}
	
	
	@Auth(role="")
	@RequestMapping( "/delete" )
	public String delete( Model model, @RequestParam long no) {
		boardService.deleteBoard(no);
		return "redirect:/freeboard/list";
	}	

	@Auth(role="")
	@RequestMapping( "/updateform" )
	public String updateform( Model model,@RequestParam long no ) {
		FreeboardVo vo =boardService.getByNo(no);
		model.addAttribute("vo",vo);
		return "/board/freeboardmodifyform";
	}
	
	@Auth(role="")
	@RequestMapping( "/update" )
	public String update( @ModelAttribute FreeboardVo vo ) {
		boardService.updateBoard(vo);
		return "redirect:/freeboard/list";
	}
	/*@RequestMapping("/comment")
	public String comment(Model model,@RequestParam long no){
		FreecommentVo vo=freecommentService.getByNo(no);
		model.addAttribute("vo", vo);
		return "/board/freeboardviewform";
	}*/
	
}
