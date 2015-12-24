package com.dorothy.railway999.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dorothy.railway999.vo.NoticeVo;



@Repository
public class NoticeDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public void insert(NoticeVo vo) {
		sqlSession.insert("notice.insert" , vo );
	}

	public void update(NoticeVo vo) {
		sqlSession.update("notice.update", vo );
	}

	public void delete(NoticeVo vo) {
		sqlSession.delete("notice.delete", vo );
		
	}
	
	public NoticeVo view(NoticeVo vo) {
		return sqlSession.selectOne("notice.view" , vo );
		
		
	}
	
	public List<NoticeVo> getList(){
		return sqlSession.selectList("notice.list");
	}

	public List<NoticeVo> getList(Map<String, Object> listMap){
		return sqlSession.selectList("notice.list", listMap);
	}
	
	public List<NoticeVo> mainList(){
		return sqlSession.selectList("notice.mainlist");
	}
	
	
	public NoticeVo getContent(NoticeVo vo){
		return sqlSession.selectOne( "notice.getbyNo", vo );
	}

	public int totalCount(Map<String, Object> listMap) {
		return sqlSession.selectOne( "notice.total", listMap);
	}
}
