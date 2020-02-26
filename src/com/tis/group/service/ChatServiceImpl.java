package com.tis.group.service;

import java.sql.Timestamp;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.tis.group.mapper.ChatMapper;
import com.tis.group.model.ChatVO;
import com.tis.group.model.PagingVO;

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
	public int createChat(ChatVO vo) {
		return this.chatMapper.createChat(vo);
	}

}
