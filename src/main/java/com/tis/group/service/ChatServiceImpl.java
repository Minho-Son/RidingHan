package com.tis.group.service;

import java.sql.Timestamp;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.tis.group.mapper.ChatMapper;
import com.tis.group.model.ChatVO;
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
			return n;
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
	public int addChatMember(int user_no) {
		return this.chatMapper.addChatMember(room_code);
	}
	@Override
	public ChatVO chatRoomInfo(String room_code) {
		return this.chatMapper.chatRoomInfo(room_code);
	}
	@Override
	public List<ChatVO> showChat(String room_code){
		return this.chatMapper.showChat(room_code);
	}

}
