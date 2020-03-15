package com.tis.place.service;

import java.util.List;

import com.tis.place.domain.PagingVO;
import com.tis.place.domain.PlanVO;

public interface PlanService {
	
	int registerPlan(PlanVO plan);
	int getTotalCount();
	List<PlanVO> getAllPlaceList(PagingVO paging);
	// java에서는 메소드 오버로딩이 가능하지만 xml에서는 같은 이름이 허용되지 않기에 변경함
	PlanVO findPlanByTitle(String title);
	PlanVO findPlanByPlanid(String planid);
	PlanVO findPlanByCoordinate(double latitude, double longitude);
	
}
