package com.tis.board.model;

import java.io.Serializable;
import java.sql.Timestamp;

import com.tis.user.model.MemberVO;

import lombok.Data;

@Data
public class ReplyVO implements Serializable {
   
   
   private Integer reply_idx;
   private String reply_content;
   private String reply_wname; 
   private java.sql.Date wdate;
   private Integer board_idx_fk;
   private String reply_id;
   
   
}////////////////////////////////////////