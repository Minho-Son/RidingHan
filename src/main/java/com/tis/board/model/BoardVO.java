package com.tis.board.model;

import java.io.Serializable;

import lombok.Data;

@Data
public class BoardVO implements Serializable {
	 
	private int board_idx;
	private String board_title;
	private String board_userid;
	private String board_pwd;
	private String board_content;
	private java.sql.Date wdate;
	private String bimage;
	private String board_image;
}
