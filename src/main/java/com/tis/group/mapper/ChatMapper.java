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
	int getTotalCount(PagingVO paging);
	List<ChatVO> getSearchList(PagingVO paging);
	
	int createChat(ChatVO cvo);
	int createChatMember(MemberVO vo);
	Chat_MemberVO chatMyInfo(Map<String, Object> map);
	int addChatMember(Map<String, Object> map);
	ChatVO chatRoomInfo(String room_code);
	List<ChatVO> showAllChat(Chat_MemberVO vo);
	
	String userNotoNick(int user_no);
	List<Chat_MemberVO> chatMemberList(String room_code);
	int addChatText(ChatVO cvo);
	int quitChatMember(Map<String, Object> map);
	Chat_MemberVO chkMemberIs(Map<String, Object> map);
	int deleteChatRoom(String room_code);
}