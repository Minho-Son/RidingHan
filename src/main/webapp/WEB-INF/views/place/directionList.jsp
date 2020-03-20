<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/top" />

<dev>
<br>
</dev>
<div class="container">
   <div class="row">
      <div class="col-md-12 col-md-offset-0 table-responsive">
         <h1 class="text-primary text-center">등록 경로 정보</h1>
         <table class="table table-striped">
            <tr class="success">
               <th>번호</th>
               <th>경로이름</th>
               <th>줄발번호</th>
               <th>도착번호</th>
               <th>경로거리</th>
               <th>gpx파일이름</th>
            </tr>
            <!-- --------------------------- -->
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
            <!-- --------------------------- -->
            <tr>
               <td></td>
               <td></td>
               <td colspan="2" class="text-center">${pageNavi}</td>
               <td colspan="2" class="text-right">총 등록 장소수 : <b>${totalCount}
                     개</b>
               </td>
            </tr>
         </table>
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

<c:import url="/foot" />