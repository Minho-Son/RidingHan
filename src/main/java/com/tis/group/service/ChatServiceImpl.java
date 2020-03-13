package com.tis.group.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.tis.group.mapper.ChatMapper;
import com.tis.group.model.ChatVO;
import com.tis.group.model.Chat_MemberVO;
import com.tis.group.model.PagingVO;
import com.tis.user.model.MemberVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Service(value="chatServiceImpl")
public class ChatServiceImpl implements ChatService {
	
	@Inject
	private ChatMapper chatMapper;
	
	@Override
	public List<ChatVO> showChatList(PagingVO paging) {
		return this.chatMapper.showChatList(paging);
	}
	@Override
	public int getTotalCount() {
		return this.chatMapper.getTotalCount();
	}
	@Override
	public int createChat(ChatVO cvo, MemberVO mvo) {
		int n=this.chatMapper.createChat(cvo);
		if(n>0) {
			n=createChatMember(mvo);
			return n;//채팅방 정보 생성 실패
		}else {
			return n;
		}
	}
	@Override
	public int createChatMember(MemberVO vo) {
		int n=this.chatMapper.createChatMember(vo);
		return n;
	}
	@Override
	public int chkMemberinRoom(Map<String, Object> map) {
		Chat_MemberVO cm=this.chatMapper.chkMemberinRoom(map);
		if(cm==null) {
			int n=addChatMember(map);
			if(n>0) {
				//log.info("채팅방에 멤버추가");
				return n;//채팅방에 멤버 추가
			}
			return n;//채팅방 멤버추가 실패
		}
		//log.info("채팅방에 이미 멤버 있음");
		return 1;//이미 멤버가 있음
	}
	@Override
	public int addChatMember(Map<String, Object> map) {
		return this.chatMapper.addChatMember(map);
	}
	@Override
	public ChatVO chatRoomInfo(String room_code) {
		return this.chatMapper.chatRoomInfo(room_code);
	}
	@Override
	public String userNotoNick(int user_no) {
		return this.userNotoNick(user_no);
	}
	@Override
	public List<ChatVO> showAllChat(String room_code){
		return this.chatMapper.showAllChat(room_code);
	}
	@Override
	public List<Chat_MemberVO> chatMemberList(String room_code){
		return this.chatMapper.chatMemberList(room_code);
	}
	@Override
	public int addChatText(ChatVO cvo) {
		return this.chatMapper.addChatText(cvo);
	}
	@Override
	public void deleteChat(Map<String, Object> map) {
		this.chatMapper.deleteChat(map);
	}
	@Override
	public void quitChatMember(Map<String, Object> map) {
		this.chatMapper.quitChatMember(map);
	}

}
