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

import com.tis.group.model.ChatVO;
import com.tis.group.service.ChatService;
import com.tis.ridinghan.ChatController;

import lombok.extern.log4j.Log4j;

@Log4j
public class WebSocketHandler extends TextWebSocketHandler {
	
	@Autowired
	ChatService  chatservice;
	ChatController chatcontroller;
	
	//메시지를 날리기 위한 웹소켓전용 세션
	private List<WebSocketSession> sesList=new ArrayList<>();
	//실제 세션의 아이디정보, 웹소켓정보
	private Map<WebSocketSession,String> mapList=new HashMap<>();
	//실제 세션의 아이디정보, 방정보
	private Map<WebSocketSession,Object> roomList=new HashMap<>();
	
	private Map<String,String> map=new HashMap<>();
	
	//연결되었을 때
	@Override
	public void afterConnectionEstablished(WebSocketSession ses) throws Exception{
		log.info("채팅방 연결 성공");
		sesList.add(ses);
		
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
		String tokens[]=str.split("@!\\|");
		
		String room_code;
		String nickName;
		
		//log.info("room_code : "+room_code);
		if(tokens!=null) {
			switch(tokens[0]) {
			case "100":
				room_code=tokens[1];
				nickName=tokens[2];
				ChatVO roomInfo=chatservice.chatRoomInfo(room_code);
				//log.info("roomInfo : "+roomInfo);
				roomList.put(ses, roomInfo);
				log.info(nickName+"님이"+roomInfo.getChat_title()+"방에 입장했습니다.");
				break;
			case "200":	
				String text=tokens[1];
				if(!text.equals("")&&!(text.trim().isEmpty())) {
					for(WebSocketSession webSocketSession:sesList) {
						String rcode=((ChatVO)(roomList.get(webSocketSession))).getRoom_code();
						log.info("rcode>>"+rcode);					
						if(((ChatVO)roomList.get(ses)).getRoom_code().equals(rcode)){
							if(!ses.getId().equals(webSocketSession.getId())) {
								if(webSocketSession.isOpen())
								webSocketSession.sendMessage(new TextMessage(text));
							}
						}
					}
				}
				break;
			}
		}//if---------------------
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession ses, CloseStatus status) throws Exception{
		
		
	}
	
	
}