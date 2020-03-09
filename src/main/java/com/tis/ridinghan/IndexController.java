package com.tis.ridinghan;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller(value="IndexController")
public class IndexController {
	
	@RequestMapping("/top")
	public void showTop() {
		
	}
	
	@RequestMapping("/mypageTop")
	public void showMypageTop() {
		
	}
	
	@RequestMapping("/foot")
	public void showFoot() {
		
	}
	
	@RequestMapping("/carousel")
	public void showCarousel() {
		
	}
	
	@RequestMapping("/index")
	public String hello(Model m) {
		m.addAttribute("msg","Annotation을 이용한 방식의 spring");
		return "index";//뷰네임을 문자열로 변환
		//"WEB-INF/views/index.jsp를 찾아감
	}
	
	@RequestMapping(value="/map", method=RequestMethod.GET)
	public String showMap() {
		return "map";
	}
}
