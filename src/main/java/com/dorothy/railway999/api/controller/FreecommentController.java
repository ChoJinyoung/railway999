package com.dorothy.railway999.api.controller; 

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dorothy.railway999.annotation.Auth;
import com.dorothy.railway999.service.FreecommentService;
import com.dorothy.railway999.vo.FreecommentVo;
  
@Controller( "CommendAPIController" )
@RequestMapping( "/api/commend" )
public class FreecommentController {
	
	@Autowired 
	FreecommentService freecommentService;  
	
	@ResponseBody
	@RequestMapping( "/list" )
	public Map<String, Object> list(@RequestParam(value="no",required=true,defaultValue="")long no) {
		List<FreecommentVo> list = freecommentService.listMessage(no);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put( "result", "success" );
		map.put( "data", list );
		return map;
	}
	
	@Auth(role ="")
	@ResponseBody
	@RequestMapping(value="/insert", method = RequestMethod.POST )
	public Map<String, Object> insert( @ModelAttribute FreecommentVo vo ) {
		FreecommentVo freecommentVo = freecommentService.writeMessage( vo );
		Map<String, Object> map = new HashMap<String, Object>();
		map.put( "result", "success" );
		map.put( "data", freecommentVo );
		return map;
	}
	
	@Auth(role ="")
	@ResponseBody
	@RequestMapping( value = "/delete", method = RequestMethod.POST )
	public Map<String, Object> delete( @ModelAttribute FreecommentVo vo ) {
		boolean result = freecommentService.deleteMessage( vo );
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put( "result", "success" );
		map.put( "data", result );
		
		return map;
	}	
}