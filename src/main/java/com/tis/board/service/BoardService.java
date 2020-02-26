package com.tis.board.service;

import java.util.List;

import com.tis.board.model.BoardVO;
import com.tis.board.model.PagingVO;

public interface BoardService {
	
	int insertBoard(BoardVO board);
	int getTotalCount();
	
	List<BoardVO> getAllBoardList(int start,int end);
	List<BoardVO> getAllBoardList(PagingVO paging);
	
	BoardVO selectBoardView(int bidx);
	
	BoardVO findBoardByIdx(String idx);
	BoardVO findBoardByUserid(String userid);
	int editBoard(BoardVO boardVo);
	int deleteBoard(int board_idx);
	
}
