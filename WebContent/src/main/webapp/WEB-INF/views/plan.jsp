<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:import url="/top"/>
<script src="asset/js/jquery.min.js"></script>
<!DOCTYPE>
<script type="text/javascript"></script>

<!--그룹게시판---------------------------------->
      <div id="container">
         <div class="inbx">
            <div class="s-content">
               <div class="inner3">
                  <div class="group-left">
                     <p class="gicon">그룹</p>
                     <input type="text" name="serch" id="serch" class="form-control" placeholder="검색">
                     <button type="button" id="myBtn" class="btn btn-success col-12">그룹만들기 +</button>
                     <p class="txt_blue">관리 중인 그룹</p>
                     <a class="txt_black">서울사이버대학교</a>
                     <a class="txt_black">곰돌이 눈알붙이기 동아리</a>

                     <a class="txt_blue">가입한 그룹</a>
                     <a class="txt_black">사이버대학 총학생회</a>
                     <a class="txt_black">사이버대학 취업사관학교</a>
                  </div>

                  <div class="group-right">
                     <div class="boardinner">
                        <h6 class="modal-title title">곰돌이 눈알 붙이기 동아리</h6>
                        <hr />
                        <div class="context">
                           <h6 class="txt_gray">길을 열락의 대한 이것이야말로 이상의 무한한 부패를 무엇을 우리의 아름다우냐? 앞이 천자만홍이 아름답고 하였으며, 평화스러운 꽃이 뿐이다. 청춘은 웅대한 바로 듣는다.</h6>
                        </div>
                        <div class="mapview">
                            <c:import url="/mapAPI.jsp"/>                        </div>
                        <div class="map-setting">
                           <span class="departure">출발지</span>
                           <button type="button" class="mappick"><img src="asset/images/mappick.png" alt="chooseAdress"></button>
                           <br />
                           <hr />
                           <button type="button" submit="" class="addpath"><img src="asset/images/plus2.png" alt="add" /></button>
                           <span class="addpathtxt"> 중간 경유지 보기</span>
                           <!--if 버튼이 눌릴 시 중간 경유지 추가창 하나 더 뜸-->
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
      </div>
      
<c:import url="/foot"/>