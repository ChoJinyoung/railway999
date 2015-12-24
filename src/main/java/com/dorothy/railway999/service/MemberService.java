package com.dorothy.railway999.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.railway999.dao.MemberDao;
import com.dorothy.railway999.vo.MemberVo;



@Service
public class MemberService {

	@Autowired
	MemberDao memberDao;

	public void join(MemberVo vo) {
		memberDao.insert(vo);
	}

	public MemberVo login(MemberVo vo) {
		MemberVo memberVo = memberDao.get(vo);
		return memberVo;
	}

	public MemberVo getMember(Long no) {
		MemberVo memberVo = memberDao.get(no);
		return memberVo;
	}

	public void update(MemberVo vo) {
		memberDao.update(vo);
	}

	public MemberVo getMember(String email) {
		MemberVo memberVo = memberDao.get(email);
		return memberVo;
	}

	public List<MemberVo> memerList(){
		return memberDao.getMemberList();
	}
	
	public List<MemberVo> listPage(long page){
		return memberDao.listPage(page);
	}

	public void drop(long no) {
		memberDao.drop(no);		
	}
	
}
