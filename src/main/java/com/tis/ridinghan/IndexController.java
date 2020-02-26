package com.tis.ridinghan;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller(value="IndexController")
public class IndexController {
	
	@RequestMapping("/top")
	public void showTop() {
		
	}
	
	@RequestMapping("/foot")
	public void showFoot() {
		
	}
	
	@RequestMapping("/carousel")
	public void showCarousel() {
		
	}
	
	@RequestMapping("/index")
	public String hello(Model m) {
		m.addAttribute("msg","юс╫ц Index");
		return "shop_index";
	}

}
