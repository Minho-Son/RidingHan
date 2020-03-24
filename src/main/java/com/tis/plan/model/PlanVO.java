package com.tis.plan.model;

import java.sql.Date;

import lombok.Data;

@Data
public class PlanVO {
	private Integer plan_no;
	private Integer user_no;
	private String plan_title;
	private String plan_about;
	private Integer place_no;
	private Integer direction_no;
	private Date plan_wtime;
	
	private boolean sharePlan;
}
