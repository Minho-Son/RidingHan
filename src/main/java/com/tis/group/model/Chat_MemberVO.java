package com.tis.group.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class Chat_MemberVO {
	private Integer chat_member_no;
	private String room_code;
	private Integer user_no;
	private Timestamp chat_jtime;
	private Integer plan_no;
}
