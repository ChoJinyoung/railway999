package com.dorothy.railway999.controller;


import java.util.List;






import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dorothy.railway999.service.FreeBoardService;
import com.dorothy.railway999.service.NoticeService;
import com.dorothy.railway999.service.QboardService;
import com.dorothy.railway999.vo.FreeboardVo;
import com.dorothy.railway999.vo.MemberVo;
import com.dorothy.railway999.vo.NoticeVo;
import com.dorothy.railway999.vo.QboardVo;



@Controller
public class MainController {
	@Autowired
	NoticeService noticeService;
	@Autowired
	QboardService qboardService;
	@Autowired
	FreeBoardService freeboardService;
	
	
	@RequestMapping( {"" , "/main"})
	public String main(HttpSession session, ModelMap model){

		List<NoticeVo> list=noticeService.mainList();
		List<QboardVo> qlist = qboardService.QMainList();
		List<FreeboardVo> flist = freeboardService.FMainList();
		 MemberVo Vo =  (MemberVo)session.getAttribute("AuthMember");
		 model.put("memberVo", Vo);
		 model.put("list", list);
		 model.put("qlist", qlist);
		 model.put("flist", flist);
		return "/main/main";
	}
}
