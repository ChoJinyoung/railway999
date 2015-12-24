package com.dorothy.railway999.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.railway999.dao.QboardDao;
import com.dorothy.railway999.vo.QboardVo;



@Service
public class QboardService {
	
	private final int pageSize = 10;
	private final int blockSize = 5;
	
	@Autowired
	private QboardDao qboardDao;
	
	public Map<String, Object> list(Integer page, String kwd) {
	
		int start;
		int currentBlock;
		Integer currentPage = page;
		Integer nextBlock;
		Integer preBlock;
		Integer startPage;
		Integer endPage;
		Integer totalPage;
		Integer total;
		
		Map<String, Object> listData = new HashMap<String, Object>();
		Map<String, Object> queryMap = new HashMap<String, Object>();
		List<QboardVo> qboardList;
				
		total = qboardDao.totalCount(queryMap);
		totalPage = (int)Math.ceil((double)total / pageSize);
	
		if(page > totalPage){
			currentPage = totalPage;
		}
		if(page < 1){
			currentPage = 1;
		}
		
		currentBlock = (currentPage + blockSize-1) / blockSize;
		
		startPage = (currentBlock - 1) * blockSize + 1;
		endPage = startPage + blockSize - 1;
		
		nextBlock = endPage + 1;
		preBlock = startPage - 1;
		
		if(preBlock == 0){
			preBlock = null;
		}
		if(nextBlock > totalPage){
			nextBlock = null;
		}
		
		start = (currentPage - 1) * pageSize + 1;
		queryMap.put("start", start);
		queryMap.put("size", pageSize);

		qboardList = qboardDao.getList(queryMap);
		
		listData.put("totalPage", totalPage);
		listData.put("startPage", startPage);
		listData.put("endPage", endPage);
		listData.put("preBlock", preBlock);
		listData.put("nextBlock", nextBlock);
		listData.put("currentPage", currentPage);
		listData.put("total", total);
		listData.put("pageSize", pageSize);
		listData.put("kwd", kwd);
		listData.put("list", qboardList);
		

		return listData;
	}

	public void writeQboard ( QboardVo vo ) {
	qboardDao.insert( vo );
	}
	
	public void updateQboard ( QboardVo vo ) {
	qboardDao.update( vo );
	}
	
	public void deleteQboard ( long no ) {
	qboardDao.delete( no );
	}
	 
	public QboardVo viewQboard ( long no ) {
		QboardVo vo = qboardDao.view(no);
		qboardDao.updateViewCount(no);
		return vo;
		
	}
	
	public List<QboardVo> QMainList (){
		return qboardDao.getMainList();
	}
	
	public QboardVo modify( long no){
		return qboardDao.getContent(no);
		
	}	
}
