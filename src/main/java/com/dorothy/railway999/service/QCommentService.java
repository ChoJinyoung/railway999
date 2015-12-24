package com.dorothy.railway999.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.railway999.dao.QboardDao;
import com.dorothy.railway999.vo.QcommentsVo;

@Service
public class QCommentService {
	
	@Autowired
	private QboardDao qboardDao;
	
	public List<QcommentsVo> listMessage(long no) {
		List<QcommentsVo> list = qboardDao.CommentList(no);
		return list;
	}
	
	public QcommentsVo writeMessage( QcommentsVo vo ) {
		return qboardDao.Coinsert(vo);
	}
	
	public void deleteMessage ( QcommentsVo vo ) {
		qboardDao.Codelete(vo);
	}
}
