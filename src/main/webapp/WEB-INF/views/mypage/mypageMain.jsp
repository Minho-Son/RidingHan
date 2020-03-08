<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String myctx=request.getContextPath();
%>
<c:import url="/top"/>
<!-- ===== 로그인 ====== -->
<script type="text/javascript">

      function showFavorite() {
         window.open("favorite.html", "chatpop", "width=600, height=800, top=0, resizable=no")
      }
   </script>

   <!-- 마이페이지 -->
      <div id="container">
         
            <div class="inner4">
               <div class="group-left">
                  <p class="micon">마이페이지</p>
                  <p style="color:#72787F">환영합니다 <b style="color:#337AF2">${user.user_name}</b>님</p>
                  <!-- '성정민'에 회원 이름 나오도록 -->
                  <hr />
                  <p class="mtxt_blue">계정</p>
                  <a href="<%=myctx%>/mypage/myInfo" class="txt_black">회원정보수정</a>
                  <br />
                  <p class="mtxt_blue">나의 여행</p>
                  <a class="txt_black">즐겨찾기</a>
                  <a class="txt_black">진행중인 여행</a>
                  <a class="txt_black">여행 히스토리</a>

               </div>
               <div class="mgroup-right">

                  <!-- 여행 히스토리 -->
                   <h6 class="mtitle">여행 히스토리</h6>
                  <div class="group-box2">
                     <a href="해당 그룹 화면으로 jsp이동 새창으로뜸" target="_blank">
                        <div class="profile2" href="a">
                           <img src="asset/images/chat/${chat.chat_image}">
                        </div>
                        <div class="group-txt2">
                           <p class="mtxt_black">다녀왔던 여행제목</p><br />
                           <p class="mtxt_gray3">다녀왔던 여행소개</p><br />
                           <p class="mtxt_small_blue">송파구 송파대로 맛있는 국밥집 </p>
                           <img class="m-arrow" src="../asset/images/blt_open.png" />
                           <p class="mtxt_small_blue">송파구 송파대로 345</p><br />
                           <p class="mtxt_small_gray">2020-02-24</p>
                        </div>
                     </a>
                     <button type="button" id="m-enter" class="m-enter">이동</button>
                  </div>

                  <!-- 진행중인 여행 -->
                  <!-- <h6 class="mtitle">진행중인 여행</h6>
                  <div class="group-box3>
                     <a href="해당 그룹 화면으로 jsp이동 새창으로뜸" target="_blank">
                        <div class="profile2" href="${chat.chat_url}">
                           <img src="asset/images/chat/${chat.chat_image}">
                        </div>
                        <div class="group-txt2">
                           <p class="mtxt_black">진행중인 여행제목</p><br />
                           <p class="mtxt_gray3">진행중인 여행소개</p><br />
                           <p class="mtxt_small_blue">송파구 송파대로 맛있는 국밥집 </p>
                           <img class="m-arrow" src="./asset/images/blt_open.png" />
                           <p class="mtxt_small_blue">송파구 송파대로 345</p><br />
                           <p class="mtxt_small_gray">2020-02-24</p>
                        </div>
                     </a>
                     <button type="button" id="m-enter" class="m-enter">이동</button>
                  </div> -->

                  <!-- 즐겨찾기 -->
                  <!-- <h6 class="mtitle" style="margin-bottom:0">즐겨찾기</h6>
                  <div class="select-mcate">
                     <input type="button" class="serchbtn-bl btn-sm-1" value="전체" />
                     <input type="button" class="serchbtn-wh btn-sm-1" value="경로" />
                     <input type="button" class="serchbtn-wh btn-sm-1" value="장소" />
                  </div>
                  <div class="group-box3">
                     <a onclick="showFavorite()">
                        <div class="profile2" href="${chat.chat_url}">
                           <img src="asset/images/chat/${chat.chat_image}">
                        </div>
                        <div class="group-txt2">
                           <p class="mtxt_black">즐겨찾기한 경로</p><br />
                           <p class="mtxt_gray3">즐겨찾기한 경로에 대한 설명</p>
                           <p class="mtxt_small_blue">송파구 송파대로 맛있는 국밥집 </p>
                           <img class="m-arrow" src="./asset/images/blt_open.png" />
                           <p class="mtxt_small_blue">송파구 송파대로 345</p>
                           <p class="mtxt_small_gray">2020-02-24</p>
                        </div>
                     </a>
                     <button type="button" id="m-cancle" class="m-cancle">삭제</button>
                  </div> -->

                  <!-- 마이페이지 기본화면 -->
                  <!--div style="text-align:center">
                     <a class="photo" style="background-image: url(asset/images/face.png);"></a><br />
                     <p class="txt01">성정민님 환영합니다</p>
                     <p class="txt02">정보, 개인정보 보호 및 보안 설정을 관리하여<br />나에게 맞는 방식으로<br /> 달려라 한강을 사용할 수 있습니다.</p>
                  </div-->

                  <!-- 회원정보 수정-->
                  <!--h6 class="mtitle">회원정보수정</h6>
                  <p class="txt_black">기본정보</p>
                  <hr />
                  <p class="mtxt_gray">아이디</p>
                  <p class="mtxt_black">여기에 아이디를 넣어다오</p>
                  <br /><br />
                  <form class="modifyform form-inline">
                     <label class="mtxt_gray" for="modify-name">이름</label>
                     <input type="text" id="modify-name"
                     class="form-control col-md-8" placeholder="현재이름">
                     <input type="button" class="modifybtn btn-sm-1" value="수정"/>
                  </form>
                  <form class="modifyform form-inline">
                     <label class="mtxt_gray" for="modify-email">이메일</label>
                     <input type="email" id="modify-email"
                     class="form-control col-md-8" placeholder="현재이메일">
                     <input type="button" class="modifybtn btn-sm-1" value="수정"/>
                  </form>
                  <form class="modifyform form-inline">
                     <label class="mtxt_gray" for="modify-nickname">닉네임</label>
                     <input type="text" id="modify-nickname"
                     class="form-control col-md-8" placeholder="현재닉네임">
                     <input type="button" class="modifybtn btn-sm-1" value="수정"/>
                  </form>
                  <form class="modifyform form-inline">
                     <label class="mtxt_gray2" for="modify-password">비밀번호</label>
                     <input type="password" id="modify-password"
                     class="form-control col-md-8">
                     <input type="button" class="modifybtn btn-sm-1" value="수정"/>
                  </form>
                  <p class="mtxt_gray2">본인인증</p>
                  <p class="mtxt_gray2">인증 완료되었습니다. (인증일: 2020-01-15)</p>
                  <br /><br />
                  <div style="text-align:center">
                     <button type="button" id="cancelbtn" class="btn btn-outline-success col-5">취소</button>
                     <button type="button" id="modifybtn2" class="btn btn-success col-5">수정</button>
                  </div-->
               </div>
            </div>
         </div>

      
<%-- <c:import url="/foot"/> --%>




