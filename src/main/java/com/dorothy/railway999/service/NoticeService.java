package com.dorothy.railway999.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.railway999.dao.NoticeDao;
import com.dorothy.railway999.vo.NoticeVo;




@Service
public class NoticeService {
	
	private final int pageSize = 10;
	private final int blockSize = 5;

	@Autowired
	NoticeDao noticeDao;

	public Map<String, Object> list(Integer page) {
		
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
		Map<String, Object> listMap = new HashMap<String, Object>();
		List<NoticeVo> noticeList;
	
		
		total = noticeDao.totalCount(listMap);
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
		listMap.put("start", start);
		listMap.put("size", pageSize);
		noticeList = noticeDao.getList(listMap);
		
		listData.put("totalPage", totalPage);
		listData.put("startPage", startPage);
		listData.put("endPage", endPage);
		listData.put("preBlock", preBlock);
		listData.put("nextBlock", nextBlock);
		listData.put("currentPage", currentPage);
		listData.put("total", total);
		listData.put("pageSize", pageSize);
		listData.put("list", noticeList);
		
		return listData;
	}
	
	public void writeNotice(NoticeVo vo) {
		noticeDao.insert( vo );
	}

	public void updateNotice(NoticeVo vo) {
		noticeDao.update( vo );
	}

	public void deleteNotice(NoticeVo vo) {
		noticeDao.delete( vo );
	}
	
	public NoticeVo viewNotice(NoticeVo vo) {
		return noticeDao.view( vo );
		
	}
	
	public NoticeVo modify(NoticeVo vo){
		return noticeDao.getContent(vo);
	}
	
	public List<NoticeVo> mainList(){
		List<NoticeVo> list=noticeDao.mainList();
		return list;
	}

		
	
}
	
