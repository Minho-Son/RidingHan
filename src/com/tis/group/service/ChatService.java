package com.tis.group.service;

import java.sql.Timestamp;
import java.util.List;

import com.tis.group.model.ChatVO;
import com.tis.group.model.PagingVO;

public interface ChatService {
	List<ChatVO> showChatList (PagingVO paging);
	int getTotalCount();
	int createChat(ChatVO vo);
	
}
