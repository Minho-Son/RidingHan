package com.tis.group.service;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.tis.group.mapper.ChatMapper;
import com.tis.group.model.ChatVO;
import com.tis.group.model.Chat_MemberVO;
import com.tis.group.model.PagingVO;
import com.tis.user.model.MemberVO;

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
				return n;
			}
			return n;//채팅방 멤버추가 실패
		}
		return 1;
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
	public List<ChatVO> showChat(String room_code){
		return this.chatMapper.showChat(room_code);
	}
	@Override
	public List<Chat_MemberVO> chatMemberList(String room_code){
		return this.chatMapper.chatMemberList(room_code);
	}

}
