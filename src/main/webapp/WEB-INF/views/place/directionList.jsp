<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String myctx = request.getContextPath();
%>

<c:import url="/top" />

<style>
/* Map 플레이스 리스트 */
.picon {
   font-weight: 400;
   font-size: 1.18rem;
   color: #1B1B1F;
   margin: 25px 0 10px 0;
}

#container .picon::before {
   content: '';
   width: 35px;
   height: 30px;
   display: inline-block;
   background: url('<%=myctx%>/asset/images/mappick.png') 50% 50% no-repeat;
   vertical-align: -7px;
   margin-right: 5px;
}

.maplist-group {
   width: 100%;
   background-color: #fffff;
   margin: auto;
   padding: 16px 23px;
}
</style>


<div id="container">
   <div class="inbx">
      <div class="inner3">
         <div class="maplist-group"
            style="background-color: #fff; padding: 16px 23px;">
            <p class="picon">등록된 장소</p>
            <hr>
            <p class="texttt">
               총 등록장소 <b class="mtxt_blue" style="display: inline-block">${totalCount}</b>개

            
            <p>
               <br>
            <table class="table" style="font-size: 14px">
               <thead style="background-color: #F7F8F9">
                  <tr>
                     <th>번호</th>
                     <th>경로이름</th>
                     <th>줄발번호</th>
                     <th>도착번호</th>
                     <th>경로거리</th>
                     <th colspan="2">gpx파일이름</th>
                  </tr>
               </thead>
               <!-- --------------------------- -->
               <tbody>
                  <c:forEach var="direction" items="${directionArr}">
                     <tr>
                        <td>${direction.direction_no}</td>
                        <td>${direction.title}</td>
                        <td><fmt:formatNumber value="${direction.place_from}"
                              pattern="###.#####" /></td>
                        <td><fmt:formatNumber value="${direction.place_to}"
                              pattern="###.#####" /></td>
                        <td><fmt:formatNumber value="${direction.distance}"
                              pattern="###,###.#" /></td>
                        <td>${direction.gpxfile}</td>
                        <td>
                           <!-- href속성값에 자바스크립트 함수를 넣을 때는 반드시 함수 앞에 "javascript:" 접두어를 붙여주자 -->
                           <a href="javascript:select('${direction.direction_no}')">선택</a>
                        </td>
                     </tr>
                  </c:forEach>
               </tbody>
            </table>
            <!-- --------------------------- -->
            <hr>
            <table style="width: auto; margin: auto">
               <tr>
                  <td>${pageNavi}</td>
               </tr>
            </table>
         </div>
      </div>
      </div>

      <!-- 등록할 장소 처리시 사용할 form -->
      <form name="frm" method="post">
         <input type="hidden" name="direction_no">
         <!-- hidden data -->
      </form>
   </div>
   <script>
      function select(direction_no) {
         //정말 등록하시겠습니까 물어보기
         var yn = confirm(direction_no + "번 경로를 선택 하시겠습니까?");
         //frm폼의 direction_no value값으로 direction_no값을 넣어주자.
         if (yn) {
            frm.direction_no.value = direction_no;
            frm.action = "viewDirection";
            frm.method = 'post';
            frm.submit();
         }
      }
   </script>