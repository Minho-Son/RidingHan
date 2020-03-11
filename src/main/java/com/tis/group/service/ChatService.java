package com.tis.group.service;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import com.tis.group.model.ChatVO;
import com.tis.group.model.Chat_MemberVO;
import com.tis.group.model.PagingVO;
import com.tis.user.model.MemberVO;

public interface ChatService {
	List<ChatVO> showChatList (PagingVO paging);
	int getTotalCount();
	int createChat(ChatVO cvo, MemberVO mvo);
	int createChatMember(MemberVO vo);
	int chkMemberinRoom(Map<String, Object> map);
	int addChatMember(Map<String, Object> map);
	ChatVO chatRoomInfo(String room_code);
	List<ChatVO> showAllChat(String room_code);
	List<Chat_MemberVO> chatMemberList(String room_code);
	int addChatText(ChatVO cvo);
}
