package com.tis.ridinghan;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tis.chat.model.ChatVO;
import com.tis.chat.service.ChatService;
import com.tis.common.CreateRandomCode;
import com.tis.place.domain.DirectionVO;
import com.tis.place.domain.PlaceVO;
import com.tis.place.service.PlaceService;
import com.tis.plan.model.PagingVO;
import com.tis.plan.model.PlanVO;
import com.tis.plan.service.PlanService;
import com.tis.user.model.MemberVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class PlanController {
   
   @Inject
   private PlanService planService;
   @Inject
   private ChatService chatService;
   @Inject
   private PlaceService placeService;
   
   @RequestMapping(value="/plan",method=RequestMethod.GET)
   public String showPlanList(@ModelAttribute PagingVO paging,
         HttpServletRequest req, Model m) {
      
       //�뵆�옖由ъ뒪�듃 �럹�씠吏�////////////////////////
         int totalCount=planService.getTotalCount(paging);
         paging.setTotalCount(totalCount);
         paging.setPageSize(10);
         paging.setPagingBlock(5);
         paging.init();
         
         List<PlanVO> arr=planService.showPlanList(paging);
         m.addAttribute("planArr",arr);
         log.info("planArr = "+arr);
         
         String myctx = req.getContextPath();
         String pageNavi = paging.getPageNavi(myctx, "plan");
         
         m.addAttribute("totalCount", totalCount);
         m.addAttribute("paging", paging);
         m.addAttribute("pageNavi", pageNavi);
         m.addAttribute("findKeyword",req.getParameter("findKeyword"));
      
      return "plan/planMain";
   }      
   
   @RequestMapping(value="/plan/makePlan",method=RequestMethod.POST)
   public String CreatePlan(@RequestParam("sharePlan") boolean sharePlan,
         @ModelAttribute PlanVO pv, Model m, HttpServletRequest req, HttpSession ses){
      MemberVO user=(MemberVO)ses.getAttribute("user");
      pv.setUser_no(user.getUser_no());
      log.info("pv = "+pv);
      
      int n=planService.createFirstPlan(pv);
      if(n>0) {
         PlanVO myInfo=planService.planMyInfo(user.getUser_no());
         n=planService.createPlanInfo(myInfo);
            if(n>0) {
               if(sharePlan==true) {
                  String room_code=new CreateRandomCode().createRandomCode();
                  ChatVO chat=new ChatVO();
                  chat.setChat_title(myInfo.getPlan_title());
                  chat.setChat_text("|start|");
                  chat.setChat_wtime(null);
                  chat.setChat_img("bikeicon.jpg");
                  chat.setChat_user_no(user.getUser_no());
                  chat.setRoom_code(room_code);
                  chat.setChat_info(myInfo.getPlan_about());
                  log.info("chat : "+chat);
               n=chatService.createChat(chat, user);
               }
               String loc="../plan";
               m.addAttribute("loc", loc); 
                  
                  return "message";
               }
               String msg="플랜 생성에 실패함...";
               String loc="javascript:history.back()";
               
               m.addAttribute("msg", msg);
               m.addAttribute("loc", loc); 
               
               return "message";
         }
         String msg="플랜 생성에 실패함...";
         String loc="javascript:history.back()";
         
         m.addAttribute("msg", msg);
         m.addAttribute("loc", loc); 
         
         return "message";
      }
	/*
	 * @RequestMapping(value="/plan/planCode",method=RequestMethod.GET)
	 * @ResponseBody public List<PlanVO> checkPlanCode(@RequestParam("val") int plan_code) 
	 * throws Exception{
	 * List<PlanVO> arr=planService.showPlan(plan_code);
	 * log.info("planVO = "+arr);
	 * return arr; 
	 * }
	 */
   @RequestMapping(value="/plan/planView",method=RequestMethod.GET)
   public String showPlan(@RequestParam("plan_code") int plan_code,
		   @ModelAttribute Model m) {
       List<PlanVO> arr=planService.showPlan(plan_code);
       m.addAttribute("planArr", arr);
       return "plan/planView";
   }

   @RequestMapping("/plan/callPlaceList")
      public String placeList(@ModelAttribute com.tis.place.domain.PagingVO paging, HttpServletRequest req, Model m) {
         int totalCount = placeService.getTotalPlaceCount();

         paging.setTotalCount(totalCount);
         paging.init();
         log.info("paging: " + paging);

         List<PlaceVO> pList = placeService.getAllPlaceList(paging);
         String myctx = req.getContextPath();

         String pageNavi = paging.getPageNavi(myctx, "placeList");

         m.addAttribute("totalCount", totalCount);
         m.addAttribute("placeArr", pList);
         m.addAttribute("paging", paging);
         m.addAttribute("pageNavi", pageNavi);

         return "plan/callPlaceList";
         // "WEB-INF/views/place/placeList.jsp"
      } // ---------------------------------
   
    @RequestMapping("/plan/callDirectionList")
      public String directionList(@ModelAttribute com.tis.place.domain.PagingVO paging, HttpServletRequest req, Model m) {
         int totalCount = placeService.getTotalDirectionCount();

         paging.setTotalCount(totalCount);
         paging.init(); 
         log.info("paging: " + paging);

         List<DirectionVO> dList = placeService.getAllDirectionList(paging);
         String myctx = req.getContextPath();

         String pageNavi = paging.getPageNavi(myctx, "directionList");

         m.addAttribute("totalCount", totalCount);
         m.addAttribute("directionArr", dList);
         m.addAttribute("paging", paging);
         m.addAttribute("pageNavi", pageNavi);

         return "plan/callDirectionList";
         // "WEB-INF/views/place/directionList.jsp"
      } // ---------------------------------
    
    @RequestMapping(value="/plan/addPlan")
    @ResponseBody
    public Map<String,Object> addPlan(@RequestParam(value="place_no", defaultValue="", required=false) int place_no,
    		@RequestParam(value="title", defaultValue="", required=false) String place_title,
    		@ModelAttribute HttpSession ses)
    		throws Exception{
    	log.info("어디까지 왔나ㅡㅡ");
    	Map<String,Object> map=new HashMap<>();
    	PlanVO pv=new PlanVO();
    	MemberVO user=(MemberVO)ses.getAttribute("user");
    	log.info("또 어디 숨었나");
        pv.setUser_no(user.getUser_no());
        //pv.setPlace_no(place_no);
        pv.setPlace_title(place_title);
        planService.addPlace(pv);
        log.info("pv : "+pv);
        
    	map.put("pv","애않되ㅡㅡ");
        return map;
    }
 
   }