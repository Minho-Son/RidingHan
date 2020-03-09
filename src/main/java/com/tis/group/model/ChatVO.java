package com.tis.group.model;

import lombok.Data;

@Data
public class ChatVO {
	private Integer chat_no;
	private String chat_title;
	private String chat_text;
	private java.sql.Timestamp chat_wtime;
	private String chat_img;
	private Integer chat_user_no;
	private String room_code;
	private String chat_info;
}
