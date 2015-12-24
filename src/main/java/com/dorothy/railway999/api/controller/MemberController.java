package com.dorothy.railway999.api.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dorothy.railway999.service.MemberService;
import com.dorothy.railway999.vo.MemberVo;

@Controller("APIMemberController")
@RequestMapping("/api/member")
public class MemberController {
	@Autowired
	MemberService memberService;
	
	@ResponseBody
	@RequestMapping("/logincheck")
	public Map<String, Object> loginCheck(@ModelAttribute MemberVo vo){
		MemberVo memberVo = memberService.login(vo);
		System.out.println(memberVo);
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("result", "success");
		map.put("data", memberVo);
		return map;
	}
}
