package com.tis.plan.mapper;

import java.util.List;
import java.util.Map;

import com.tis.plan.model.PagingVO;
import com.tis.plan.model.PlanVO;

public interface PlanMapper {
	int registerPlan(PlanVO plan);
	int getTotalCount();
	List<PlanVO> getAllPlanList(int start, int end);
	List<PlanVO> getAllPlanListPaging(PagingVO paging);
	// java에서는 메소드 오버로딩이 가능하지만 xml에서는 같은 이름이 허용되지 않기에 변경함
	PlanVO findPlanByTitle(String title);
	PlanVO findPlanByPlanid(String planid);
	PlanVO findPlanByCoordinate(Map<String, Double> map);
	//////////////////////////
	int createPlan(PlanVO pv);

}
