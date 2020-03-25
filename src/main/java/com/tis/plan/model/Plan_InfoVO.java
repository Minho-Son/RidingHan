package com.tis.plan.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Plan_InfoVO {
	private Integer plan_info_no;
	private Integer plan_code;
	private Integer user_no;
	private Date plan_join;
	private Date plan_quit;
	
}
