package com.tis.place.mapper;

import java.util.List;

import com.tis.place.domain.PagingVO;
import com.tis.place.domain.PlaceVO;

public interface PlaceMapper {
	int registerPlace(PlaceVO place);
	int getTotalCount();
	List<PlaceVO> getAllPlaceList(int start, int end);
	List<PlaceVO> getAllPlaceListPaging(PagingVO paging);
	// java에서는 메소드 오버로딩이 가능하지만 xml에서는 같은 이름이 허용되지 않기에 변경함
	PlaceVO findPlaceByTitle(String title);
	PlaceVO findPlaceByPlaceid(String Placeid);

}
