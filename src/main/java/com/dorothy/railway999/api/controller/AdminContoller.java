package com.dorothy.railway999.api.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dorothy.railway999.annotation.Auth;
import com.dorothy.railway999.service.MemberService;
import com.dorothy.railway999.vo.MemberVo;

@Controller
@RequestMapping("/api/admin")
public class AdminContoller {
	
	@Autowired
	MemberService memberService;
	
	@Auth( role="Admin")
	@ResponseBody
	@RequestMapping("/drop")
	public Map<String, Object> drop(@RequestParam(value="no",required=true,defaultValue="")long no){
		memberService.drop(no); 
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("result", "success");
		map.put("data", no);
		return map;
	}
	
	@Auth(role="Admin")
	@ResponseBody
	@RequestMapping("/list")
	public Map<String, Object> list(){
		Map<String, Object> map=new HashMap<String, Object>();
		List<MemberVo> list= memberService.memerList();
		map.put("result", "success");
		map.put("data", list);
		return map;
	}
	
	@Auth(role="Admin")
	@ResponseBody
	@RequestMapping("/listpage")
	public Map<String, Object> listPage(@RequestParam(value="page",required=true,defaultValue="")long page){
		Map<String, Object> map=new HashMap<String, Object>();
		List<MemberVo> list= memberService.listPage(page);
		map.put("result", "success");
		map.put("data", list);
		return map;
	}
}
