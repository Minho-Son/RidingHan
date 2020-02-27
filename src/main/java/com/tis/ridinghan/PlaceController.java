package com.tis.ridinghan;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tis.place.domain.PagingVO;
import com.tis.place.domain.PlaceVO;
import com.tis.place.service.PlaceService;

import lombok.extern.log4j.Log4j;

@Controller 
@Log4j
public class PlaceController {
	
	@Autowired
	private PlaceService placeService;
	
	/*
	 * // "/signup" url로 get방식의 요청이 올 때 수행함
	 * 
	 * @RequestMapping(value="/registerPlace2", method=RequestMethod.GET) public
	 * String showPlaceForm() {
	 * 
	 * return "/index_map"; // "WEB-INF/views/index_map.jsp" }
	 */
	@RequestMapping(value="/registerPlace", method=RequestMethod.POST) 
	public String placeJoin(@ModelAttribute PlaceVO place, Model model) {
		log.info("place==="+place);
		log.info("placeService=="+this.placeService);
		int n=this.placeService.registerPlace(place);
		String str=(n>0)?"장소 등록 성공":"장소 등록 실패";
		String loc="javascript:history.back()";
		model.addAttribute("msg",str);
		model.addAttribute("loc",loc);
		return "message";
	}

}
