package com.dorothy.railway999.service;
 

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dorothy.railway999.dao.FreeboardDao;
import com.dorothy.railway999.vo.FreeboardVo;


 

@Service
public class FreeBoardService {
	private final int LIST_PAGESIZE = 10;
	private final int LIST_BLOCKSIZE = 5;
	
	@Autowired
	private FreeboardDao freeboardDao;
	
	public Map<String, Object> listBoard(Long page) {
		
		//1. calculate pager's basic data 
		long totalCount = freeboardDao.getCount();
		long pageCount = (long)Math.ceil( (double)totalCount / LIST_PAGESIZE );
		long blockCount = (long)Math.ceil( (double)pageCount / LIST_BLOCKSIZE );
		long currentBlock = (long)Math.ceil( (double)page / LIST_BLOCKSIZE ); 
		
		//2. page validation
		if( page < 1 ) {
			page = 1L;
			currentBlock = 1;
		} else if( page > pageCount ) {
			page = pageCount;
			currentBlock = (int)Math.ceil( (double)page / LIST_BLOCKSIZE );
		}
		
		//3. calculate pager's data
		long startPage = (currentBlock == 0 ) ? 1 : ( currentBlock - 1 ) * LIST_BLOCKSIZE + 1;
		long endPage = ( startPage - 1 ) + LIST_BLOCKSIZE;
		long prevPage = ( currentBlock > 1 ) ? ( currentBlock - 1 ) * LIST_BLOCKSIZE : 0;
		long nextPage = ( currentBlock < blockCount ) ? currentBlock * LIST_BLOCKSIZE + 1 : 0;

		//4. fetch list
		List<FreeboardVo> list = freeboardDao.getList( page, LIST_PAGESIZE );
		
		//5. pack all information of list
		Map<String, Object> map = new HashMap<String, Object>();
		map.put( "boardList", list );
		map.put( "firstItemIndex", totalCount - ( page - 1 ) * LIST_PAGESIZE );
		map.put( "currentPage", page );
		map.put( "startPage", startPage );
		map.put( "endPage", endPage );
		map.put( "pageCount", pageCount );
		map.put( "prevPage", prevPage );
		map.put( "nextPage", nextPage );
		
		return map;
	}
	
	
	public List<FreeboardVo> FMainList(){
		return freeboardDao.getMainList();
	}
	
	public void writeBoard( FreeboardVo vo ){
		freeboardDao.insert( vo );
	}
	
	public FreeboardVo getByNo(long no){
		FreeboardVo vo=freeboardDao.get(no);
		return vo;
	}
	public void updateBoard(FreeboardVo vo){
		freeboardDao.update(vo);
	}
	
	public void deleteBoard( Long no){
		freeboardDao.delete( no);
	}	

	public FreeboardVo viewBoard( Long no ){
		FreeboardVo vo = freeboardDao.get( no );
		freeboardDao.ViewCount( no );
		return vo;
	}
}