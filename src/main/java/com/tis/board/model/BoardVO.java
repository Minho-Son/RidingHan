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
      private String originFilename;
      private String filename;
      private long filesize;
      
      private int refer;
      private int lev;
      private int sunbun;
      private int isFile;
      
      //24시간 이내 글을위한 프로퍼티
      private int newImg;
}