<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/top"/>
<script src="asset/js/jquery.min.js"></script>
<!DOCTYPE>
<script type="text/javascript">   
	$(document).ready(function() {
         $("#makeplan").click(function() {
            $("#planModal").modal();
         });
	});
</script>
 <div id="container">
         <div class="inbx">
            <div class="inner3">
               <div class="plan-left">
                  <p class="gicon">그룹</p>
                  <form class="form-inline">
                     <input type="text" name="serch" id="serch" class="form-control col-md-9" placeholder="검색">
                     <input type="button" class="serchbtn-bl btn-sm-1" value="수정" />
                  </form>
                  <button type="button" id="makeplan" class="btn btn-success col-12">플랜 만들기 +</button>
                  <p class="txt_blue">관리 중인 플랜</p>
                  <a class="txt_black">서울사이버대학교</a>
                  <a class="txt_black">곰돌이 눈알붙이기 동아리</a>

                  <a class="txt_blue">최근 등록된 플랜</a>
                  <a class="txt_black">사이버대학 총학생회</a>
                  <a class="txt_black">사이버대학 취업사관학교</a>
               </div>
               <div class="plan-right">
                  <div class="plan-box">
                     <div class="profile"></div>
                     <div class="plan-txt">
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

      <!--그룹게시판---------------------------------->
      <div id="container">
         <div class="inbx">
            <div class="inner3">
               <div class="plan-left">
                  <p class="gicon">그룹</p>
                  <form class="form-inline">
                     <input type="text" name="serch" id="serch" class="form-control col-md-9" placeholder="검색">
                     <input type="button" class="serchbtn-bl btn-sm-1" value="수정" />
                  </form>
                  <button type="button" id="myBtn" class="btn btn-success col-12">그룹만들기 +</button>
                  <p class="txt_blue">관리 중인 플랜</p>
                  <a class="txt_black">서울사이버대학교</a>
                  <a class="txt_black">곰돌이 눈알붙이기 동아리</a>

                  <a class="txt_blue">최근 등록된 플랜</a>
                  <a class="txt_black">사이버대학 총학생회</a>
                  <a class="txt_black">사이버대학 취업사관학교</a>
               </div>

               <div class="plan-right">
                  <div class="boardinner">
                     <h6 class="modal-title title">곰돌이 눈알 붙이기 동아리</h6>
                     <hr />
                     <div class="context">
                        <h6 class="txt_gray">길을 열락의 대한 이것이야말로 이상의 무한한 부패를 무엇을 우리의 아름다우냐? 앞이 천자만홍이 아름답고 하였으며, 평화스러운 꽃이 뿐이다. 청춘은 웅대한 바로 듣는다.</h6>
                     </div>
                     <div class="mapview">
                        <c:import url="/map"/>
                     </div>
                     <div class="map-setting">
                        <span class="departure">출발지</span>
                        <button type="button" class="mappick"><img src="asset/images/mappick.png" alt="chooseAdress"></button>
                        <br />
                        <hr />
                        <span class="arrival">도착지</span>
                        <button type="button" submit="" class="mappick"><img src="asset/images/mappick.png" alt="chooseAdress"></button>
                     </div>
                  </div>
                  <button type="button" id="gochat" class="btn btn-success col-3">채팅하기</button>
               </div>
               <br class="clear">
            </div>
         </div>
      </div>

      <!--그룹추가 모달+--------------------------->
      <!-- The Modal -->
      <div class="modal fade" id="planModal">
         <div class="modal-dialog">
            <div class="modal-content">

               <!-- Modal Header -->
               <div class="modal-header">
                  <h6 class="modal-title">플랜 만들기+</h6>
                  <button type="button" class="close" data-dismiss="modal">×</button>
               </div>

               <!-- Modal body -->
               <div class="modal-body">
                  <p class="comment">나만의 플랜을 만들어 저장하거나 다양한 사람들과 함께 공유할 수 있습니다<br>경로를 지정해 대화를 나누거나 함께 여행을 떠나보세요.</p>
                  <h6 class="title">그룹 이름 입력</h6>
                  <input type="Gname" name="Gname" id="Gname" class="form-control">

                  <h6 class="title">그룹 소개</h6>
                  <textarea type="Gcomment" class="form-control" rows="3" id="Gcomment"></textarea>
                  <hr />
                  <h6 class="title">경로 추가
                     <button type="button" submit="">경로 가져오기</button>
                  </h6>
                  <br />
                  <span class="departure">출발지</span>
                  <button type="button" class="mappick"><img src="asset/images/mappick.png" alt="chooseAdress"></button>
                  <br />
                  <span class="arrival">도착지</span>
                  <button type="button" submit="" class="mappick"><img src="asset/images/mappick.png" alt="chooseAdress"></button>
                  <div class="mapexsize">
                     <img class="mapex" src="asset/images/campaign/map.PNG" alt="mapex">
                  </div>
                  <hr />
                  <h6 class="title">비밀번호 설정</h6>
                  <input type="password" name="Gpwd" id="Gpwd" class="form-control col-md-7">
               </div>

               <!-- Modal footer -->
               <div class="modal-footer">
                  <button type="button" class="btn btn-success" data-dismiss="modal">새 그룹 만들기</button>
               </div>

            </div>
         </div>
      </div>
