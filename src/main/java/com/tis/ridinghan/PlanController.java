package com.tis.ridinghan;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tis.plan.model.PagingVO;
import com.tis.plan.service.PlanService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class PlanController {
	
	@RequestMapping(value="/plan",method=RequestMethod.GET)
	public String showPlanList() {
		
		return "plan/planMain";
	}
}
