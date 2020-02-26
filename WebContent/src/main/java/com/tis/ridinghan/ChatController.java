package com.tis.ridinghan;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tis.common.CommonUtil;
import com.tis.group.model.ChatVO;
import com.tis.group.model.PagingVO;
import com.tis.group.service.ChatService;
import com.tis.user.model.MemberVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ChatController {
	
	@Autowired
	private CommonUtil util;
	
	@Inject
	private ChatService chatService;
	
	@RequestMapping(value="/chat",method=RequestMethod.GET)
	public String showChatList(@ModelAttribute PagingVO paging,
			HttpServletRequest req, Model m) {
			
		//페이징 처리////////////////////////
		int totalCount=chatService.getTotalCount();
		paging.setTotalCount(totalCount);
		paging.setPageSize(10);
		paging.setPagingBlock(5);
		paging.init();
		
		ChatVO cv=new ChatVO();
		List<ChatVO> arr=chatService.showChatList(paging);
		
		String myctx=req.getContextPath();
		String pageNavi=paging.getPageNavi(myctx, "chat");
		
		m.addAttribute("totalCount",totalCount);
		m.addAttribute("chatArr",arr);
		m.addAttribute("paging",paging);
		m.addAttribute("pageNavi",pageNavi);
		
		return "group/chatMain";
	}
	
	@RequestMapping(value="/chat/newChat",method=RequestMethod.POST)
	public String createChat(@ModelAttribute ChatVO cv, Model m, HttpSession ses) {
		
		log.info("cv = "+cv);
		
		MemberVO user=(MemberVO)ses.getAttribute("user");
		cv.setChat_text("|chat start|");
		cv.setChat_user_no(user.getUser_no());	
		log.info("cv = "+cv);
		
		int n=0;
			n=this.chatService.createChat(cv);
			
		if(n<0) {
			String msg="방 만들기에 실패했습니다.";
			String loc="javascript:history.back()";
			
			m.addAttribute("msg", msg);
			m.addAttribute("loc", loc);
			
			return "message";
		}else {
			String msg="방 만들기에 성공했습니다.";
			String loc="../chat/chatRoom";
			
			m.addAttribute("msg", msg);
			m.addAttribute("loc", loc);
			
			return "message";
		}
	}
	
	@GetMapping("../chat/chatRoom")
	public String showChatRoom(@ModelAttribute ChatVO cv, Model m, HttpSession ses) {
		return "group/chat";
	}
}
