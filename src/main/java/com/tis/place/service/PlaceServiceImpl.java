package com.tis.place.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tis.place.domain.DirectionVO;
import com.tis.place.domain.DirectionViewVO;
import com.tis.place.domain.PagingVO;
import com.tis.place.domain.PlaceVO;
import com.tis.place.mapper.PlaceMapper;

@Service(value = "placeServiceImpl")
public class PlaceServiceImpl implements PlaceService{

	@Autowired
	private PlaceMapper placeMapper;
	
	@Override
	public int registerPlace(PlaceVO place) {
		return placeMapper.registerPlace(place);
	}

	@Override
	public int getTotalPlaceCount() {
		return placeMapper.getTotalPlaceCount();
	}

	@Override
	public List<PlaceVO> getAllPlaceList(PagingVO paging) {
		return placeMapper.getAllPlaceList(paging);
	}

	@Override
	public PlaceVO findPlaceByTitle(String title) {
		return placeMapper.findPlaceByTitle(title);
	}

	@Override
	public PlaceVO findPlaceByPlaceid(String place_no) {
		return placeMapper.findPlaceByPlaceid(place_no);
	}

	@Override
	public PlaceVO findPlaceByCoordinate(double latitude, double longitude) {
		Map<String, Double> map=new HashMap<>();
		map.put("latitude", latitude);
		map.put("longitude", longitude);
		return placeMapper.findPlaceByCoordinate(map);
	}

	@Override
	public int registerDirection(DirectionVO direction) {
		return placeMapper.registerDirection(direction);
	}

	@Override
	public int getTotalDirectionCount() {
		return placeMapper.getTotalDirectionCount();
	}

	@Override
	public List<DirectionVO> getAllDirectionList(PagingVO paging) {
		return placeMapper.getAllDirectionList(paging);
	}

	@Override
	public DirectionViewVO findDirectionByDirectionid(String direction_no) {
		return placeMapper.findDirectionByDirectionid(direction_no);
	}

	@Override
	public DirectionViewVO findDirectionByGpxfile(String gpxfile) {
		return placeMapper.findDirectionByGpxfile(gpxfile);
	}

}
