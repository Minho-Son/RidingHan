package com.tis.plan.model;

import java.sql.Date;

import lombok.Data;

@Data
public class PlanVO {
	Integer plan_no;
	Integer user_no;
	String plan_title;
	Date plan_start_time;
	Date plan_finish_time;
	Integer saved_place_no;
	Integer plan_order;
}
