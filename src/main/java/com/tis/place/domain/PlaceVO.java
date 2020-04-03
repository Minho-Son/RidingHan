package com.tis.place.domain;

import lombok.Data;

@Data
public class PlaceVO {
	
	private int place_no;
	private String title;
	private double latitude;
	private double longitude;
	private String road_address;
	private String jibun_address;
	private int p_user_no;

}
