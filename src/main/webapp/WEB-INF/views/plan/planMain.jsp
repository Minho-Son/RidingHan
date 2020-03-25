<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/top" />
<script type="text/javascript">   
$(document).ready(function() {
	$("#makegroup").click(function() {
    	$("#groupModal").modal();
    });
});

function callList(){
	window.open("plan/callPlaceList","_blank","width=540, height=800, left=0, top=0");
}

function joinPlan(tmp){
	var val=tmp.name;
	var w=window.open("about:blank","_blank","width=540, height=800, left=0, top=0");
	$.ajax({
		type:'GET',
		url:'plan/planView?plan_code='+val,		
		dataType:'html',
		success:function(res){
			w.location.href="/RidingHan/plan/planView";
		},
		error:function(e){
	         alert('error: '+e.status);
		}
	})
	
}
	
//플랜 생성 시 유효성 체크
function message(str){
	var obj=document.getElementById("msg");
	obj.innerHTML=str;
	}
$(function(){
	$('#makePlan').click(function(){
		if (!$('#plan_title').val()){
			var str = '※ 플랜의 제목을 입력해주세요';
			message(str);
			return;
		}
		if(!$('#plan_about').val()){
			var str = '※ 플랜 소개를 입력해주세요';
			message(str);
			return;
		}
		pf.submit();
	})
})
	
</script>
 <div id="container">
         <div class="inbx" style="background-color:white">
            <div class="inner3">
               <div class="group-left">
                  <p class="gicon">라이딩 플랜</p>
                  <form class="form-inline">
                     <input type="text" name="search" id="search" class="form-control col-md-9" placeholder="검색">
                     <input type="button" class="searchbtn-bl btn-sm-1" value="수정" />
                  </form>
                  <button type="button" id="makegroup" class="btn btn-success col-12">플랜 만들기 +</button>
                  <p class="txt_blue">최근 플랜 목록</p>
                  <c:if test="${planArr==null || empty planArr}">
	                  <tr>
	                  <td colspan="5"><b>현재 플랜이 없습니다.</b></td>
	               	</tr>
               	  </c:if>
               	  <c:if test="${planArr!=null || not empty planArr}">
            			<hr>
               	  	<c:forEach var="planList" items="${planArr}">
                  		<a class="txt_black">${planList.plan_title}</a>
                  	</c:forEach>
                  </c:if>					
               </div>
               	   <div class="group-right">
               	   <p>총 <b class="mtxt_blue"
               	   style="display:inline-block">${totalCount}</b>개의 플랜이 있습니다<p>
               <c:forEach var="planList2" items="${planArr}">
              
                  <div class="group-box">
                     <div class="profile"></div>
                     <div class="group-txt">
                        <span>${planList2.plan_title}</span>
                        <b>${planList2.plan_about}</b>
                     </div>
                     <button type="button" class="enter" id="${planList2.plan_code}" name="${planList2.plan_code}" onclick="joinPlan(this)">참여</button>
                  </div>
               </c:forEach>
                 <hr>
                  <table style="width:auto;margin:auto">
                  <tr>
                     <td>${pageNavi}</td>
                  </tr>
            	  </table>
               <br class="clear">
            </div>
         </div>
         
      </div>
      </div>

      

      <!--플랜추가 모달+--------------------------->
      <!-- The Modal -->
      <form id="pf" method="POST" action="plan/makePlan">
      <div class="modal fade" id="groupModal">
         <div class="modal-dialog">
            <div class="modal-content">

               <!-- Modal Header -->
               <div class="modal-header">
                  <h6 class="modal-title">플랜 만들기+</h6>
                  <button type="button" class="close" data-dismiss="modal">×</button>
               </div>

               <!-- Modal body -->
               <div class="modal-body">
                  <p class="comment">나만의 플랜을 만들어 관리하거나 다양한 사람들과 함께 공유할 수 있습니다<br>경로를 지정해  함께 여행을 떠나보세요.</p>
                  <h6 class="title">플랜 이름</h6>
                  <input type="Gname" name="plan_title" id="plan_title" class="form-control">

                  <h6 class="title">플랜 소개</h6>
                  <textarea type="Gcomment" name="plan_about" id="plan_about" 
                  class="form-control" rows="1"></textarea>
                  <hr />
                  <h6 class="title">경로 또는 장소 추가
                     <button type="button" onclick="callList()">가져오기+</button>
                  </h6>
                  <hr />
                  <!-- if test로 불러올 것.... -->
                  <span class="departure" style="margin-left:10px" name="" id="" >
                  	서울숲 => 뚝섬한강공원
                  </span><br/>
                  <span class="departure" style="margin-left:10px" name="" id="" >
                  	국회의사당역 9호선
                  </span><br/>
                  <span class="departure" style="margin-left:10px" name="" id="" >
                  	영등포역3번출구 => 가을단풍길(노량진공원길)	
                  </span><br/>
               </div>

               <!-- Modal footer -->
               <div class="checks" style="margin-left:25px">
					<input type="checkbox" id="sharePlan" name="sharePlan"/>
					<label for="sharePlan"> 그룹으로 공유하기</label>
               	    <label id="msg" style="fontSize: 8pt; color: red; align:left;"></label>
				</div>
               <div class="modal-footer">
               	  <button type="button" class="btn btn-success" id="makePlan">플랜 만들기</button>
               </div>

            </div>
         </div>
      </div>
      </form>
