package com.tis.group.service;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import com.tis.group.model.ChatVO;
import com.tis.group.model.PagingVO;
import com.tis.ridinghan.Int;
import com.tis.user.model.MemberVO;

public interface ChatService {
	List<ChatVO> showChatList (PagingVO paging);
	int getTotalCount();
	int createChat(ChatVO cvo, MemberVO mvo);
	int createChatMember(MemberVO vo);
	int addChatMember(Map<String, Object> map);
	ChatVO chatRoomInfo(String room_code);
	List<ChatVO> showChat(String room_code);
	
}
