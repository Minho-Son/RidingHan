package com.tis.board.model;

import java.io.Serializable;

import lombok.Data;

@Data
public class BoardVO implements Serializable {
	 
	private int board_idx;
	   private String board_title;
	   private int board_user_no;
	   private String board_pwd;
	   private String board_content;
	   private java.sql.Date board_wdate;
	   private String bimage;
	   private String board_img;
	   private String user_id;
}
