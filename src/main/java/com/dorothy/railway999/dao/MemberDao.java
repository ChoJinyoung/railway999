package com.dorothy.railway999.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dorothy.railway999.vo.MemberVo;



@Repository
public class MemberDao {

	@Autowired
	SqlSession sqlSession;

	public void insert(MemberVo vo) {
		sqlSession.insert("member.insert", vo);
	}

	public MemberVo get(MemberVo vo) {
		MemberVo memberVo = sqlSession.selectOne("member.Login", vo);
		return memberVo;
	}

	public MemberVo get(Long no) {
		MemberVo memberVo = sqlSession.selectOne("member.no", no);
		return memberVo;
	}

	public void update(MemberVo vo) {
		sqlSession.update("member.Update", vo);
	}

	public MemberVo get(String email) {
		MemberVo memberVo = sqlSession.selectOne("email", email);
		return memberVo;
	}

	public List<MemberVo> getMemberList(){
		MemberVo memberVo = new MemberVo();
		memberVo.setRole("member");
		return sqlSession.selectList("member.List", memberVo );
	}
	
	public List<MemberVo> listPage(long page){
		Map<String, Object> map=new HashMap<String, Object>();
		MemberVo memberVo = new MemberVo();
		memberVo.setRole("member");
		map.put("memberVo", memberVo);
		map.put("page", page);
		return sqlSession.selectList("member.listpage", map );
	}

	public void drop(long no) {
		sqlSession.delete("member.Drop", no );		
	}
	 
}
