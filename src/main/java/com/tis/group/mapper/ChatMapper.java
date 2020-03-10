package com.tis.group.mapper;

import java.util.List;
import java.util.Map;

import com.tis.group.model.ChatVO;
import com.tis.group.model.Chat_MemberVO;
import com.tis.group.model.PagingVO;
import com.tis.user.model.MemberVO;

public interface ChatMapper{
	List<ChatVO> showChatList (PagingVO paging);
	int getTotalCount();
	int createChat(ChatVO cvo);
	int createChatMember(MemberVO vo);
	Chat_MemberVO chkMemberinRoom(Map<String, Object> map);
	int addChatMember(Map<String, Object> map);
	ChatVO chatRoomInfo(String room_code);
	//List<ChatVO> showChat(String room_code);
	List<Chat_MemberVO> chatMemberList(String room_code);
}