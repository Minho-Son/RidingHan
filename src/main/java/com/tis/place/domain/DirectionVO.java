package com.tis.place.domain;

import lombok.Data;

@Data
public class DirectionVO {
	private int direction_no;
	private String title;
	private int place_from;
	private int place_to;
	private double distance;
	private String gpxfile;
	private int d_user_no;
	
}
