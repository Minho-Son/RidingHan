package com.tis.board.mapper;

import java.util.List;

import com.tis.board.model.BoardVO;
import com.tis.board.model.PagingVO;

public interface BoardMapper {
	
	int insertBoard(BoardVO board);
	int getTotalCount();
	
	List<BoardVO> getAllBoardList(int start,int end);
	List<BoardVO> getAllBoardListPaging(PagingVO paging);
	
	BoardVO findBoardByIdx(String idx);
	BoardVO findBoardByUserid(int board_user_no);
	BoardVO selectBoardView(int bidx);
	int editBoard(BoardVO boardVo);
	int deleteBoard(int board_idx);
	List<BoardVO> searchBoard(PagingVO paging);
}
