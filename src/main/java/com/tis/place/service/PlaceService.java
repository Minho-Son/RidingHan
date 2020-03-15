package com.tis.place.service;

import java.util.List;

import com.tis.place.domain.DirectionVO;
import com.tis.place.domain.DirectionViewVO;
import com.tis.place.domain.PagingVO;
import com.tis.place.domain.PlaceVO;

public interface PlaceService {
	
	int registerPlace(PlaceVO place);
	int getTotalPlaceCount();
	List<PlaceVO> getAllPlaceList(PagingVO paging);
	// java에서는 메소드 오버로딩이 가능하지만 xml에서는 같은 이름이 허용되지 않기에 변경함
	PlaceVO findPlaceByTitle(String title);
	PlaceVO findPlaceByPlaceid(String placeid);
	PlaceVO findPlaceByCoordinate(double latitude, double longitude);
	
	int registerDirection(DirectionVO direction);
	int getTotalDirectionCount();
	List<DirectionVO> getAllDirectionList(PagingVO paging);
	DirectionViewVO findDirectionByDirectionid(String direction_no);
	DirectionViewVO findDirectionByGpxfile(String gpxfile);
	
}
