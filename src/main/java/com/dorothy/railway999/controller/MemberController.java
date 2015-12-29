package com.dorothy.railway999.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dorothy.railway999.annotation.Auth;
import com.dorothy.railway999.service.MemberService;
import com.dorothy.railway999.vo.MemberVo;


@Controller
@RequestMapping( "/member")

public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping( "/joinform" )
	public String joinform(){
		return "/member/joinform";
	}
	
	@RequestMapping("/loginform")
	public String loginform(){
		return "/member/loginform";
	}
	
	@RequestMapping( "/join" )
	public String join( @ModelAttribute MemberVo vo ){
		memberService.join( vo );
		return "/member/joinsuccess";
	}
	
	@Auth(role ="")
	@RequestMapping( "/modifyform" )
	public String modifyForm( HttpSession session , Model model ){
		MemberVo vo = (MemberVo) session.getAttribute("AuthMember");
		model.addAttribute( "vo", vo );
		return "/member/modifyform";
	}	
	
	@Auth(role ="")
	@RequestMapping( "/update" )
	public String update(HttpSession session, @ModelAttribute MemberVo vo ){		
		MemberVo mVo = (MemberVo)session.getAttribute("AuthMember");
		vo.setNo(mVo.getNo());
		memberService.update(vo);
		return "redirect:/member/modifyform";
	}
	
	@Auth( role="Admin")
	@RequestMapping("/admin" )
	public String memberlist(Model model){
		model.addAttribute("list", memberService.memerList() );
		return "/member/admin";
	}
	
	
	
/*	@Auth( role="")
	@ResponseBody
	@RequestMapping("/admin" )
	public Map<String, Object> rolechange(@ModelAttribute MemberVo vo){
		
		MemberVo memberVo = memberService.
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put( "result", "success" );
		map.put( "data", memberVo );
		return "map";
	}*/
		
}
