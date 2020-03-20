package com.tis.ridinghan;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletContext;
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
import org.springframework.web.multipart.MultipartFile;

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

	///////////////////////// 회원가입
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String showUserForm() {
		return "signup";
	}

	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String userJoin(@ModelAttribute MemberVO mv, Model m) {
		log.info("user==" + mv + ", user.getName() : " + mv.getUser_name());
		log.info("userService==" + this.userService);
		int n = 0;
		n = this.userService.createMember(mv);

		String msg = (n > 0) ? "회원가입 완료" : "회원가입 실패";
		String loc = (n > 0) ? "login" : "javascript:history.back()";

		m.addAttribute("msg", msg);
		m.addAttribute("loc", loc);

		return "message";
	}

	///////////////////////// 중복체크
	@GetMapping(value = "/idcheck", produces = "application/json; charset=UTF-8;")
	public @ResponseBody Map<String, Integer> idCheck(@RequestParam("user_id") String user_id) {
		MemberVO idOkay = this.userService.memberChkByEmail(user_id);
		int n = (idOkay != null) ? -1 : 1;
		Map<String, Integer> map = new HashMap<>();
		map.put("idOkay", n);
		return map;
	}

	@GetMapping(value = "/nickcheck", produces = "application/json; charset=UTF-8;")
	public @ResponseBody Map<String, Integer> nickCheck(@RequestParam("nickName") String nickName) {
		MemberVO nickOkay = this.userService.memberChkByNick(nickName);
		int n = (nickOkay != null) ? -1 : 1;
		Map<String, Integer> map = new HashMap<>();
		map.put("nickOkay", n);
		return map;
	}

/////////////////////////마이페이지 창
	@GetMapping("/mypage")
	public String showMypageForm() {
		return "/mypage/mypageMain";
	}

////////////////////////마이페이지 레프트 바
	@RequestMapping("/mypageTop")
	public void showMypageTop() {

	}

////////////////////////진행중인 여행
	@GetMapping("/mypage/travelingList")
	public String showTravelingList(Model m, HttpSession ses) {
		return "mypage/travelingList";
	}

////////////////////////여행 히스토리
	@GetMapping("/mypage/travelingHistory")
	public String showTravelingHistory(Model m, HttpSession ses) {
		return "mypage/travelingHistory";
	}

////////////////////////즐겨찾기
	@GetMapping("/mypage/favorite")
	public String showMyFavorite(Model m, HttpSession ses) {
		return "mypage/favorite";
	}

/////////////////////////회원정보 수정
	@GetMapping("/mypage/myInfo")
	public String showMyInfo(Model m, HttpSession ses) {
		return "mypage/memberInfo";
	}

	@RequestMapping(value = "/mypage/myInfoEdit", method = RequestMethod.POST)
	public String myInfoEdit(
			@RequestParam String newPwd,
			@RequestParam("mypfile") MultipartFile mypfile,
			@RequestParam(defaultValue="") String old_mypfile,
			@ModelAttribute MemberVO mv, Model m, HttpSession ses, HttpServletResponse res) throws NotUserException {

		ServletContext sc=ses.getServletContext();
		String upDir=sc.getRealPath("/asset/images/user");
		log.info("upDir="+upDir);
		
		//////// 비밀번호 체크
		MemberVO user = (MemberVO) ses.getAttribute("user");
		boolean pwdisCorrect = user.getPwd().equals(mv.getPwd());

		if (pwdisCorrect == false) {
			throw new NotUserException("비밀번호가 일치하지 않습니다.");
		} else {
			System.out.println("패스워드 일치함");
			if (!newPwd.isEmpty()) {
				mv.setPwd(newPwd);
			}else {
				mv.setPwd(user.getPwd());
			}
			mv.setUser_id(user.getUser_id());
			
			//프로필 이미지 업로드
			String user_img=mypfile.getOriginalFilename();
			if(mypfile.isEmpty()&&old_mypfile.isEmpty()) {
				mv.setUser_img("noimage.jpg");
			}else {
				try {
					mypfile.transferTo(new File(upDir,user_img));
					mv.setUser_img(user_img);	
					
					File delF=new File(upDir,old_mypfile);
					boolean b=delF.delete();
					log.error("예전파일 "+old_mypfile+" 삭제 처리 여부 : "+b);
				}catch(Exception e) {
					log.error("파일 업로드 중 에러 : "+e.getMessage());
				}
			}
			
			int n = userService.editMember(mv);
			System.out.println("mv = " + mv);

			String msg = (n > 0) ? "회원정보 수정 완료" : "회원정보 수정 실패";
			String loc = (n > 0) ? "myInfo" : "javascript:history.back()";

			m.addAttribute("msg", msg);
			m.addAttribute("loc", loc);

			return "message";
		}//else------------------------------------------------------
	}
}
