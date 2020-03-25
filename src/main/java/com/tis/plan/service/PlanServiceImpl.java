package com.tis.plan.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.tis.plan.mapper.PlanMapper;
import com.tis.plan.model.PagingVO;
import com.tis.plan.model.PlanVO;

@Service(value="planServiceImpl")
public class PlanServiceImpl implements PlanService {
	
	@Inject
	private PlanMapper planMapper;
	
	@Override
	public int createFirstPlan(PlanVO pv) {
		return planMapper.createFirstPlan(pv);
	}
	public PlanVO planMyInfo(int user_no) {
		return planMapper.planMyInfo(user_no);
	}
	@Override
	public int createPlanInfo(PlanVO pv) {
		return planMapper.createPlanInfo(pv);
	}
	@Override
	public int getTotalCount(PagingVO paging) {
		return planMapper.getTotalCount(paging);
	}
	@Override
	public List<PlanVO> showPlanList(PagingVO paging) {
		return planMapper.showPlanList(paging);
	}
	@Override
	public List<PlanVO> showPlan(int plan_code) {
		// TODO Auto-generated method stub
		return null;
	}
}
