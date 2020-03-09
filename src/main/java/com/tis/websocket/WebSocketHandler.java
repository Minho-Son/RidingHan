package com.tis.websocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.tis.group.service.ChatService;

import lombok.extern.log4j.Log4j;

@Log4j
public class WebSocketHandler extends TextWebSocketHandler {
	
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
		sesList.add(ses);
		System.out.println("채팅방 연결 성공...");
		
		/*
		 * vo=(MemberVO)hses.getAttribute("user"); System.out.println(vo); String
		 * room_code=(String)hses.getAttribute("room_code");
		 * 
		 * Map<String,Object> map=new HashMap<>(); map.put("user_no", vo.getUser_no());
		 * map.put("room_code", room_code);
		 * 
		 * ChatVO roomNow=chatservice.chatRoomInfo(room_code);
		 * 
		 * roomList.put(ses, roomNow.getChat_title());
		 * System.out.println(vo.getNickName()+"님이 "+roomNow.getChat_title()
		 * +"방에 들어왔습니다.");
		 * 
		 * //chat_member에 유저 추가 chatservice.addChatMember(map);
		 */
		
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession ses, TextMessage msg) throws Exception{
		log.info(ses.getId()+"로부터 "+msg.getPayload()+"받음");
		String str=msg.getPayload();
		String tokens[]=str.split("\\|");
		String room_code=tokens[1];
		String nickName=tokens[2];
		
		if(!msg.getPayload().equals("")||!(msg.getPayload().trim().isEmpty())) {
			for(WebSocketSession webSocketSession:sesList) {
				if(room_code.equals(roomList.get(webSocketSession))) {
					if(!ses.getId().equals(webSocketSession.getId())) {
						webSocketSession.sendMessage(new TextMessage(JsonData()));
					}
				}
			}
		}
		
		 /* switch(tokens[0]) { case "100": log.info("방번호: "+tokens[1]);
		 * 
		 * break; }
		 */
		
		
		
		/*
		 * for(WebSocketSession sess:sesList) { sess.sendMessage(new TextMessage
		 * (sess.getPrincipal().getName()+"|"+msg.getPayload())); }
		 */
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession ses, CloseStatus status) throws Exception{
		
		
	}
	
	
}
