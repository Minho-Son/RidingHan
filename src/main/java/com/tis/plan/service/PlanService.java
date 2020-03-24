package com.tis.plan.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.tis.plan.model.PagingVO;
import com.tis.plan.model.PlanVO;

@Service
public interface PlanService {
	
	int createPlan(PlanVO pv);
	int getTotalCount();
	List<PlanVO> getAllPlaceList(PagingVO paging);
	// java에서는 메소드 오버로딩이 가능하지만 xml에서는 같은 이름이 허용되지 않기에 변경함	
}
