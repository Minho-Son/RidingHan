package com.tis.plan.model;

import java.sql.Date;

import lombok.Data;

@Data
public class PlanVO {
	private Integer plan_no;
	private Integer user_no;
	private String plan_title;
	private String plan_about;
	private int place_no;
	private int direction_no;
	private Date plan_wdate;
	private String plan_wdateStr;
	private String plan_code;
	
	private String place_title;
	private String direction_title;	
	private int share_ornot;
	
}
