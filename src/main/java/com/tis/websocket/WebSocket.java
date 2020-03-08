package com.tis.websocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import org.apache.log4j.spi.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.tis.group.service.ChatService;
import com.tis.user.model.MemberVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class WebSocket extends TextWebSocketHandler {
	
	@Autowired
	ChatService  chatservice;
	
	//private static final Logger logger=LoggerFactory.getLogger(WebSocket.class);
	
	//메시지를 날리기 위한 웹소켓전용 세션
	private List<WebSocketSession> sesList=new ArrayList<>();
	//실제 세션의 아이디정보, 웹소켓정보
	private Map<WebSocketSession,String> mapList=new HashMap<>();
	//실제 세션의 아이디정보, 방정보
	private Map<WebSocketSession,String> roomList=new HashMap<>();
	
	//연결되었을 때
	@Override
	public void afterConnectionEstablished(WebSocketSession ses) throws Exception{
		log.info("채팅방 연결 성공");
		
		Map<String,Object> map=ses.getAttributes();
		MemberVO vo=(MemberVO)map.get("user_no");
	}
	
}
