package com.dorothy.railway999.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.railway999.dao.FreeboardDao;
import com.dorothy.railway999.vo.FreecommentVo;



 
@Service
public class FreecommentService {
	
	@Autowired
	private FreeboardDao freeboardDao;
	
	public FreecommentVo writeMessage( FreecommentVo vo ) {
		return freeboardDao.Coinsert(vo);
	}
	
	public boolean deleteMessage( FreecommentVo vo ) {
		int count = freeboardDao.delete( vo );
		return count == 1;
	}
	
	public List<FreecommentVo> listMessage(long no) {
		List<FreecommentVo> list = freeboardDao.CommentList(no);
		return list;
	}
	
	public List<FreecommentVo> getByNo(long no){
		List<FreecommentVo> list=freeboardDao.getComment(no);
		return list;
	}
}
