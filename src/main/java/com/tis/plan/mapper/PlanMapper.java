package com.tis.plan.mapper;

import java.util.List;

import com.tis.plan.model.PagingVO;
import com.tis.plan.model.PlanVO;

public interface PlanMapper {
	
	int createFirstPlan(PlanVO pv);
	PlanVO planMyInfo(int user_no);
	int createPlanInfo(PlanVO pv);
	int getTotalCount(PagingVO paging);
	List<PlanVO> showPlan(int plan_code);
	List<PlanVO> showPlanList();

}
