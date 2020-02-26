package com.tis.group.mapper;

import java.sql.Timestamp;
import java.util.List;

import com.tis.group.model.ChatVO;
import com.tis.group.model.PagingVO;
import com.tis.user.model.MemberVO;

public interface ChatMapper{
	List<ChatVO> showChatList (PagingVO paging);
	int getTotalCount();
	int createChat(ChatVO vo);
}