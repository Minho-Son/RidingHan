package com.tis.plan.model;

import java.sql.Date;

import lombok.Data;

@Data
public class PlanVO {
	Integer plan_no;
	Integer user_no;
	String plan_title;
	String plan_about;
	Integer place_direction_no;
	Date plan_wtime;
}
