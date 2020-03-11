package com.tis.ridinghan;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

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
	public String createChat(@RequestParam("myfile") MultipartFile myfile,
			@ModelAttribute ChatVO cv, Model m, HttpSession ses) {
		
		ServletContext sc=ses.getServletContext();
		String upDir=sc.getRealPath("/asset/images/chat");
		log.info("upDir="+upDir);
		MemberVO user=(MemberVO)ses.getAttribute("user");
		
		String chat_img=myfile.getOriginalFilename();
		if(myfile.isEmpty()) {
			cv.setChat_img("noimage.jpg");
		}else {
			try {
				myfile.transferTo(new File(upDir, chat_img));
				cv.setChat_img(chat_img);
			}catch(IOException e) {
				log.error("파일 업로드 중 에러 : "+e.getMessage());
			}
		}
		cv.setChat_text("|start|");
		cv.setChat_user_no(user.getUser_no());	

		String room_code=new CreateRandomCode().createRandomCode();
		cv.setRoom_code(room_code);
		
		log.info("cv = "+cv);
		
		int n=this.chatService.createChat(cv, user);
			
		if(n<0) {
			String msg="채팅방 만들기에 실패하였습니다..";
			String loc="javascript:history.back()";
			
			m.addAttribute("msg", msg);
			m.addAttribute("loc", loc);
			
			return "message";
		}else {
			String msg="환영합니다."+user.getNickName()+"님";
			String loc="../chat/chatRoom?room_code="+cv.getRoom_code();
			
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
		
		log.info(map);
		int n=chatService.chkMemberinRoom(map);//멤버가 방에 없을 때에만 목록에 추가
		if(n>0) {
			ChatVO chatInfo=chatService.chatRoomInfo(room_code); //채팅방 정보
			List<ChatVO> allChat=chatService.showAllChat(room_code); //채팅방 대화 내용
			m.addAttribute("chatInfo", chatInfo);
			m.addAttribute("chatList", allChat);
			return "group/chat";
		}else {
			String msg="멤버 추가 실패";
			String loc="javascript:history().back";
			m.addAttribute("msg", msg);
			m.addAttribute("loc", loc);
			return "message";
		}

	}
}
