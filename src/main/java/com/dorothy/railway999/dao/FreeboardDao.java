package com.dorothy.railway999.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dorothy.railway999.vo.FreeboardVo;
import com.dorothy.railway999.vo.FreecommentVo;
 


@Repository
public class FreeboardDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<FreeboardVo> getList(Long page, Integer pageSize) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put( "page", page );
		map.put( "pageSize", pageSize );
		
		List<FreeboardVo> list = sqlSession.selectList( "freeboard.selectList", map);
		return list;
 
		
	}
	
	public List<FreeboardVo> getMainList(){
		return sqlSession.selectList("freeboard.mainlist");
	}
	
	
	public void insert( FreeboardVo vo ) {
		sqlSession.insert( "freeboard.insert", vo );
	}
	
	public void delete( Long freeboardNo ) {
		Map<String, Long> map = new HashMap<String, Long>(); 
		map.put( "freeboardNo", freeboardNo );
		sqlSession.delete( "freeboard.delete", map );
	}
	
	public FreeboardVo get(long no) {
		FreeboardVo vo = sqlSession.selectOne("freeboard.selectByNo",no);
		return vo;
	}
	
	public void update( FreeboardVo vo ) {
		sqlSession.update( "freeboard.update", vo );
	}
	
	public void ViewCount( Long no ) {
		sqlSession.update( "freeboard.ViewCount", no );
	}
	
	public List<FreecommentVo> getComment(long no){
		List<FreecommentVo> list=sqlSession.selectList("freecomments.selectbyfreeboardno", no);
		return list;
	}
	
	public List<FreecommentVo> CommentList(long no) {
		List<FreecommentVo> list = sqlSession.selectList( "freecomments.commentList",no);
		return list;
	}
	
	public FreecommentVo Coinsert( FreecommentVo vo ) {
		
		sqlSession.insert( "freecomments.insert", vo );
		
		FreecommentVo freecommentVo = sqlSession.selectOne( "freecomments.selectbyno", vo.getFreecommentsNo() );
		return freecommentVo;
	}
	

	public int delete( FreecommentVo vo ) {
		return sqlSession.delete( "freecomments.delete", vo );
	}
	public Long getCount() {
		Long count = sqlSession.selectOne( "freeboard.selectCount");
		
		return count;
	}
	
 
}
