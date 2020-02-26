package com.tis.ridinghan;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tis.common.CommonUtil;
import com.tis.user.model.MemberVO;
import com.tis.user.model.NotUserException;
import com.tis.user.service.UserService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class UserController {
	
	@Autowired
	private CommonUtil util;
	
	@Inject
	private UserService userService;
	
	/////////////////////////회원가입
	@RequestMapping(value="/signup",method=RequestMethod.GET)
	public String showUserForm() {
		return "signup";		
	}
	@RequestMapping(value="/signup",method=RequestMethod.POST)
	public String userJoin(@ModelAttribute MemberVO mv, Model m) {
		log.info("user=="+mv+", user.getName() : "+mv.getUser_name());
		log.info("userService=="+this.userService);
		int n=0;
			n=this.userService.createMember(mv);

		String msg=(n>0)?"회원가입 완료":"회원가입 실패";
		String loc=(n>0)?"login":"javascript:history.back()";
		
		m.addAttribute("msg",msg);
		m.addAttribute("loc",loc);	
		
		return "message";
	}
	
	/////////////////////////중복체크
	@GetMapping(value="/idcheck", produces="application/json; charset=UTF-8;")
	public @ResponseBody Map<String, Integer> idCheck(
			@RequestParam("user_id") String user_id){
		MemberVO idOkay=this.userService.memberChkByEmail(user_id);
		int n=(idOkay!=null)? -1:1;
		Map<String, Integer>map=new HashMap<>();
		map.put("idOkay", n);
		return map;
	}
	
	@GetMapping(value="/nickcheck", produces="application/json; charset=UTF-8;")
	public @ResponseBody Map<String, Integer> nickCheck(
			@RequestParam("nickName") String nickName){
		MemberVO nickOkay=this.userService.memberChkByNick(nickName);
		int n=(nickOkay!=null)? -1:1;
		Map<String, Integer>map=new HashMap<>();
		map.put("nickOkay", n);
		return map;
	}
	
	
	@GetMapping("/mypage/myInfo")
	public String showMyInfo(Model m, HttpSession ses) {
		return "mypage/memberInfo";
	}
	
	@RequestMapping(value="/mypage/myInfoEdit",method=RequestMethod.POST)
	public String myInfoEdit(
			@RequestParam(defaultValue="false") String newPwd,
			@ModelAttribute MemberVO mv, Model m, HttpSession ses, HttpServletResponse res
			) throws NotUserException {
			
		////////비밀번호 체크
		MemberVO user=(MemberVO) ses.getAttribute("user");
		boolean input=user.getPwd().equals(mv.getPwd());

		if(input==false) {
			throw new NotUserException("비밀번호가 일치하지 않습니다.");
		}else {
			System.out.println("일치함");
			if(newPwd!=null) {
				mv.setPwd(newPwd);
			}
			mv.setUser_id(user.getUser_id());
			int n=0;
			n=userService.editMember(mv);
			System.out.println("mv = "+mv);
			
			String msg=(n>0)?"회원정보 수정 완료":"회원정보 수정 실패";
			String loc=(n>0)?"myInfo":"javascript:history.back()";
			
			m.addAttribute("msg",msg);
			m.addAttribute("loc",loc);	
			
			return "message";
		}	
	}
}
	