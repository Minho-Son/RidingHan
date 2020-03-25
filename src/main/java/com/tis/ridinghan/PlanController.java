package com.tis.ridinghan;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.tis.plan.model.PlanVO;
import com.tis.plan.service.PlanService;
import com.tis.user.model.MemberVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class PlanController {
	
	@Inject
	private PlanService planService;
	
	@RequestMapping(value="/plan",method=RequestMethod.GET)
	public String showPlanList() {
		
		return "place/planMain";
	}
	
	
	
	@RequestMapping(value="/plan/makePlan",method=RequestMethod.POST)
	public String CreatePlan(
			@ModelAttribute PlanVO pv, Model m, HttpServletRequest req, HttpSession ses){
		MemberVO user=(MemberVO)ses.getAttribute("user");
		log.info("vo = "+user);
		pv.setUser_no(user.getUser_no());
		log.info("pv = "+pv);
		
		int n=planService.createPlan(pv);
		if(n<0) {
			String msg="플랜 저장에 실패하였습니다..";
			String loc="javascript:history.back()";
			
			m.addAttribute("msg", msg);
			m.addAttribute("loc", loc); 
			
			return "message";
		}else {
			String loc="../plan";
			m.addAttribute("loc", loc); 
			
			return "message"; 
		}
	}
}
