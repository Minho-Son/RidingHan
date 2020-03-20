package com.tis.plan.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Plan_InfoVO {
	Integer plan_info_no;
	Integer plan_no;
	Integer user_no;
	Date plan_join;
	Date plan_quit;
	Integer plan_state;
	
}
