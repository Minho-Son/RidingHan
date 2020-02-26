package com.tis.user.model;

import java.io.Serializable;

import lombok.Data;

@Data
public class MemberVO implements Serializable {

	
	private int user_no;
	private String user_id;
	private String pwd;
	private String user_name;
	private String nickName;
	private int state;
	private java.sql.Timestamp joinDate;
	
}