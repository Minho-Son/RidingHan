package com.tis.plan.mapper;

import java.util.List;

import com.tis.plan.model.PagingVO;
import com.tis.plan.model.PlanVO;

public interface PlanMapper {
	
	PlanVO planMyInfo(int user_no);
	int createPlanInfo(PlanVO pv);
	int getTotalCount(PagingVO paging);
	List<PlanVO> showPlan(String plan_code);
	List<PlanVO> showPlanList(PagingVO paging);
	int createPlan(PlanVO pv);

}
