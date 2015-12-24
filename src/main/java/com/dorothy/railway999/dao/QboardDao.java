package com.dorothy.railway999.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dorothy.railway999.vo.QboardVo;
import com.dorothy.railway999.vo.QcommentsVo;

@Repository
public class QboardDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	// insert,delete, update,count,
	public void insert( QboardVo vo) {
		sqlSession.insert( "qboard.insert", vo);
	}
	
	//update
	public void update( QboardVo vo) {
		sqlSession.update("qboard.update", vo);
	}
	
	public void delete( long no) {
		sqlSession.delete("qboard.delete", no);
	}
	
	public List<QboardVo> getMainList(){
		return sqlSession.selectList("qboard.mainlist");
	}
	
	public int totalCount(Map<String, Object> queryMap){

		return sqlSession.selectOne("qboard.total", queryMap);
	}
	
	public QboardVo view(long no) {
		QboardVo vo = sqlSession.selectOne("qboard.selectByNo" , no );
		return vo;		
	}
	
	public void updateViewCount( long qboardno ) {
		sqlSession.update( "qboard.viewcnt", qboardno );
	}


	public List<QboardVo> getList(){

		return sqlSession.selectList("qboard.list");
	}
	
	
	public List<QboardVo> getList(Map<String, Object> queryMap){
		return sqlSession.selectList("qboard.listPage", queryMap);
	}
	
	public QboardVo getContent(long no){
		return sqlSession.selectOne("qboard.getByNo", no);
	}
	
	
	//comments
	public List<QcommentsVo> CommentList(long no) {
		List<QcommentsVo> list = sqlSession.selectList("qcomments.commentList", no);
		return list;
	}
	
	//coinsert
	public QcommentsVo Coinsert( QcommentsVo vo ) {
		
		sqlSession.insert( "qcomments.insert", vo );
	
		
		QcommentsVo qcommentsVo = sqlSession.selectOne( "qcomments.getbyno", vo.getQcommentsno() );
		
		return qcommentsVo;
	}
	
	//codelete
    public void Codelete (QcommentsVo vo ) {
    	sqlSession.delete("qcomments.delete", vo );
    	
	}
	
}
