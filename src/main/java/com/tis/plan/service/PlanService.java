package com.tis.plan.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.tis.plan.model.PagingVO;
import com.tis.plan.model.PlanVO;

@Service
public interface PlanService {
	
	int addPlace(PlanVO pv);
	PlanVO planMyInfo(int user_no);
	int createPlanInfo(PlanVO pv);
	int getTotalCount(PagingVO paging);
	List<PlanVO> showPlan(int plan_code);
	List<PlanVO> showPlanList(PagingVO paging);
	int createFirstPlan(PlanVO pv);
}
