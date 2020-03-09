package com.tis.ridinghan;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.tis.common.CommonUtil;
import com.tis.common.CreateRandomCode;
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
			
		//채팅리스트 페이징////////////////////////
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
		if(cv.getChat_img()==null||cv.getChat_img().trim().isEmpty()) {
			cv.setChat_img("noimage.jpg");
		}
		cv.setChat_text("|start|");
		cv.setChat_user_no(user.getUser_no());	

		String room_code=new CreateRandomCode().createRandomCode();
		cv.setRoom_code(room_code);
		
		log.info("cv = "+cv);
		
		int n=0;
			n=this.chatService.createChat(cv, user);
			
		if(n<0) {
			String msg="채팅방 만들기에 실패하였습니다..";
			String loc="javascript:history.back()";
			
			m.addAttribute("msg", msg);
			m.addAttribute("loc", loc);
			
			return "message";
		}else {
			String msg="환영합니다."+user.getNickName()+"님";
			String loc="../chat/chatRoom";
			
			m.addAttribute("msg", msg);
			m.addAttribute("loc", loc);
			
			return "message";
		}
	}
	
	@RequestMapping(value="/chat/chatRoom", method=RequestMethod.GET)
	public String enterChatRoom(
			@RequestParam(value="room_code", defaultValue="", required=false) String room_code,
			 Model m, HttpSession ses) {
		log.info("room_code="+room_code);
		MemberVO vo=(MemberVO)ses.getAttribute("user");
		int user_no=vo.getUser_no();
		
		Map<String,Object> map=new HashMap<>();
		map.put("user_no", user_no);
		map.put("room_code", room_code);
		ses.setAttribute("room_code", room_code);
		
		//채팅방에 멤버가 없을 때에만 목록에 추가하기 -> 아직 구현안함
		
		if(!room_code.equals("")|!(room_code.trim().equals(""))) {
				int n=chatService.addChatMember(map); 
				if(n>0) {
					ChatVO chatInfo=chatService.chatRoomInfo(room_code); //채팅방 정보
					List<ChatVO> chatList=chatService.showChat(room_code); //채팅방 대화 내용
					ses.setAttribute("chatInfo", chatInfo);
					ses.setAttribute("chatList", chatList);
					
					return "group/chat";
				}else {
					String msg="멤버 추가 실패";
					String loc="javascript:history().back";
					m.addAttribute("msg", msg);
					m.addAttribute("loc", loc);
					return "message";
				}
		}else {
			String msg="방 정보가 없습니다";
			String loc="javascript:history().back";
			m.addAttribute("msg", msg);
			m.addAttribute("loc", loc);
			return "message";
		}
	}
}
