<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/top"/>
<script type="text/javascript">   
$(document).ready(function() {
	$("#makegroup").click(function() {
    	$("#groupModal").modal();
    });
});
	
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
		alert(plan_title.val());
		alert(sharePlan.val());
		//f.submit();
	})
})
	
</script>
 <div id="container">
         <div class="inbx">
            <div class="inner3">
               <div class="group-left">
                  <p class="gicon">라이딩 플랜</p>
                  <form class="form-inline">
                     <input type="text" name="search" id="search" class="form-control col-md-9" placeholder="검색">
                     <input type="button" class="searchbtn-bl btn-sm-1" value="수정" />
                  </form>
                  <button type="button" id="makegroup" class="btn btn-success col-12">플랜 만들기 +</button>
                  <p class="txt_blue">나만의 플랜</p>
                  <a class="txt_black">서울사이버대학교</a>
                  <a class="txt_black">곰돌이 눈알붙이기 동아리</a>

                  <a class="txt_blue">최근 그룹 플랜</a>
                  <a class="txt_black">사이버대학 총학생회</a>
                  <a class="txt_black">사이버대학 취업사관학교</a>
               </div>
               <div class="group-right">
                  <div class="group-box">
                     <div class="profile"></div>
                     <div class="group-txt">
                        <span>잠실나루에서 홍대까지 가실 분 구합니다(3명)</span>
                        <b>멤버 3명</b>
                     </div>
                     <button type="button" class="enter">가입</button>
                  </div>
               </div>
               <br class="clear">
            </div>
         </div>
      </div>

      <hr />

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
                     <button type="button" href="">가져오기+</button>
                  </h6>
                  <hr />
                  <!-- if test로 불러올 것.... -->
                  <span class="departure" name="place_direction_no" id="place_direction_no" ><img src="">
                  	
                  </span>
                  <br/>
               </div>

               <!-- Modal footer -->
               <div class="checks">
					<input type="checkbox" id="sharePlan" value="sharePlan" />
					<label for="checks"> 그룹으로 공유하기</label>
					<label id="msg" style="fontSize: 8pt; color: red;"></label>
				</div>
               <div class="modal-footer">
               	  <button type="button" class="btn btn-success" data-dismiss="modal" id="makePlan">플랜 만들기</button>
                  <button type="button" class="btn btn-success" data-dismiss="modal" id="sharePlan">그룹으로 공유</button>
               </div>

            </div>
         </div>
      </div>
      </form>
