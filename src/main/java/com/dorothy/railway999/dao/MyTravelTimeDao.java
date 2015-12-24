package com.dorothy.railway999.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dorothy.railway999.vo.MyTravelTimeVo;

@Repository
public class MyTravelTimeDao {
	@Autowired
	SqlSession sqlSession;
	
	
	public List<MyTravelTimeVo> list(long no){
		List<MyTravelTimeVo> list=sqlSession.selectList("travel.list",no);
		return list;
	}
	
	public void insert(MyTravelTimeVo vo){
		sqlSession.insert("travel.insert",vo);
	}
	
	public long delete(long travelNo){
		return sqlSession.delete("travel.delete", travelNo);
	}	
	
	public long update(MyTravelTimeVo vo){
		return sqlSession.update("travel.modify", vo);
	}
	
	public MyTravelTimeVo get(long no){
		MyTravelTimeVo myTravelTimeVo=sqlSession.selectOne("travel.listByTravelNo",no);
		return myTravelTimeVo;		
	}

}
