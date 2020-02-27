package com.tis.ridinghan;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.tis.board.model.BoardVO;
import com.tis.board.model.PagingVO;
import com.tis.board.service.BoardService;
import com.tis.user.model.MemberVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class BoardController {
	@Autowired
	private BoardService boardService;

	@RequestMapping(value = "/boardInsert", method = RequestMethod.POST)
	   public String insertBoard(@ModelAttribute BoardVO board, Model model, HttpSession ses) {
	   
	      MemberVO user=(MemberVO)ses.getAttribute("user");
	      if(user==null) {
	         String str="로그인 해야 이용가능합니다.";
	         String loc="login";
	         model.addAttribute("msg", str);
	         model.addAttribute("loc", loc);
	         
	         return "message";
	      }
	      board.setBoard_user_no(user.getUser_no());
	      board.setUser_id(user.getUser_id());
	      int n = 0;
	      n = this.boardService.insertBoard(board);

	      String str = (n > 0) ? "글쓰기 성공" : "글쓰기 실패";
	      String loc = (n > 0) ? "board" : "javascript:history.back()";
	      model.addAttribute("msg", str);
	      model.addAttribute("loc", loc);

	      return "message";
	   }
	@RequestMapping("/board")
	public String boardList(@ModelAttribute PagingVO paging, HttpServletRequest req, Model model) {
		int totalCount = boardService.getTotalCount();

		paging.setTotalCount(totalCount); // 총 게시글 수 세팅
		paging.setPageSize(10); // 한 페이지당 보여줄 회원목록 갯수
		paging.setPagingBlock(5); // 페이징 블럭
		paging.init(); // 페이징 처리 관련 연산수행

		List<BoardVO> bList = boardService.getAllBoardList(paging);

		String myctx = req.getContextPath();
		// 페이지 네비 문자열 받아오기
		String pageNavi = paging.getPageNavi(myctx, "board");

		model.addAttribute("totalCount", totalCount);
		model.addAttribute("boardArr", bList);
		model.addAttribute("paging", paging);
		model.addAttribute("pageNavi", pageNavi);

		return "board/boardList";
	}

	@GetMapping("/boardView")
	public String boardView(Model model, @RequestParam(defaultValue = "0") int board_idx) {
		// UserVO loginUser=(UserVO)ses.getAttribute("loginUser");
		// int idx_fk=loginUser.getIdx();

		BoardVO board = (BoardVO) boardService.selectBoardView(board_idx);
//		log.info(board);
		model.addAttribute("bi", board);
		return "board/boardView";
	}

	@PostMapping("/boardEditForm")
	public String boardEdit(Model model, @RequestParam(defaultValue = "0") int board_idx,
			@RequestParam(defaultValue = "0") String board_pwd) {
		BoardVO vo = (BoardVO) boardService.selectBoardView(board_idx);
		model.addAttribute("bi", vo);
		if (vo.getBoard_pwd().equals(board_pwd)) {
			return "board/boardEdit";
		}else {
			String str = "비밀번호가 틀렸습니다.";
			String loc = "javascript:history.back()";
			model.addAttribute("msg", str);
			model.addAttribute("loc", loc);
			return "message";
		}
		
	}

	@PostMapping("/boardEdit")
	public String boardEditEnd(Model model, @ModelAttribute BoardVO board) {
		
		int n = 0;
		n = this.boardService.editBoard(board);

		String str = (n > 0) ? "수정 성공" : "수정 실패";
		String loc = (n > 0) ? "board" : "javascript:history.back()";
		model.addAttribute("msg", str);
		model.addAttribute("loc", loc);

		return "message";
	}

	@PostMapping("/boardDel")
	public String boardDel(Model model, @RequestParam(defaultValue = "0") int board_idx,
			@RequestParam(defaultValue = "0") String board_pwd) {
		BoardVO vo = boardService.selectBoardView(board_idx);
		if (vo == null) {
			String str = "존재하지 않는 게시글 입니다.";
			String loc = "board";
			model.addAttribute("msg", str);
			model.addAttribute("loc", loc);
			return "message";
		}
		if (vo.getBoard_pwd().equals(board_pwd)) {

			int n = boardService.deleteBoard(board_idx);
			if (n > 0) {
				String str = "삭제 성공";
				String loc = "board";
				model.addAttribute("msg", str);
				model.addAttribute("loc", loc);
				return "message";
			}else {
				String str = "삭제 실패";
				String loc = "board";
				model.addAttribute("msg", str);
				model.addAttribute("loc", loc);
				return "message";
			}
		} else {
			String str = "비밀번호가 틀렸습니다.";
			String loc = "javascript:history.back()";
			model.addAttribute("msg", str);
			model.addAttribute("loc", loc);
			return "message";

		}

	}
}
