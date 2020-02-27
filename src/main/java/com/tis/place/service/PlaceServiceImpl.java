package com.tis.place.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tis.place.mapper.PlaceMapper;
import com.tis.place.domain.PagingVO;
import com.tis.place.domain.PlaceVO;

@Service(value = "placeServiceImpl")
public class PlaceServiceImpl implements PlaceService{

	@Autowired
	private PlaceMapper placeMapper;
	
	@Override
	public int registerPlace(PlaceVO place) {
		return this.placeMapper.registerPlace(place);
	}

	@Override
	public int getTotalCount() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<PlaceVO> getAllPlaceList(int start, int end) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PlaceVO> getAllPlaceListPaging(PagingVO paging) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PlaceVO findPlaceByTitle(String title) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PlaceVO findPlaceByPlaceid(String Placeid) {
		// TODO Auto-generated method stub
		return null;
	}

}
