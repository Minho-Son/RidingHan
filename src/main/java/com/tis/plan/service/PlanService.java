package com.tis.plan.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.tis.plan.model.PagingVO;
import com.tis.plan.model.PlanVO;

@Service
public interface PlanService {
	
	PlanVO planMyInfo(int user_no);
	int createPlanInfo(PlanVO pv);
	int getTotalCount(PagingVO paging);
	List<PlanVO> showPlan(String plan_code);
	List<PlanVO> showPlanList(PagingVO paging);
	int createPlan(PlanVO pv);
}
