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
	public int createPlan(PlanVO pv) {
		return planMapper.createPlan(pv);
	}
	@Override
	public int getTotalCount() {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public List<PlanVO> getAllPlaceList(PagingVO paging) {
		// TODO Auto-generated method stub
		return null;
	}
}