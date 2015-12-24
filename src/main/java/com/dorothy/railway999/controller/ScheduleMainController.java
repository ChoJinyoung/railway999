package com.dorothy.railway999.controller;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dorothy.railway999.annotation.Auth;
import com.dorothy.railway999.vo.MemberVo;



@Controller
@RequestMapping("/scheduleMain")
public class ScheduleMainController {
	
	@RequestMapping("/search")
	public String StationList(HttpSession session , Model model){
		MemberVo vo=(MemberVo) session.getAttribute("AuthMember");	
		model.addAttribute("vo",vo);
		return "/schedule/addschedule";
	}
	
	@RequestMapping("/myschedule")
	public String MyScheduleList(HttpSession session , Model model){
		MemberVo vo=(MemberVo)session.getAttribute("AuthMember");
		model.addAttribute("vo",vo);
		return "/schedule/myschedule";
	}
}




