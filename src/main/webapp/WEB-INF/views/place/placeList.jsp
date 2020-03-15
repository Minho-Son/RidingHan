<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html><%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/top" />

<div><br></div>
<div class="container">
   <div class="row">
      <div class="col-md-12 col-md-offset-0 table-responsive">
         <h1 class="text-primary text-center">등록 장소 목록</h1>
         <table class="table table-striped">
            <tr class="success">
               <th>번호</th>
               <th>장소이름</th>
               <th>위도</th>
               <th>경도</th>
               <th>도로명주소</th>
               <th>지번주소</th>
            </tr>
            <!-- --------------------------- -->
            <c:forEach var="place" items="${placeArr}">
               <tr>
                  <td>${place.place_no}</td>
                  <td>${place.title}</td>
                  <td>
                     <fmt:formatNumber value="${place.latitude}" pattern="###.#####"/>
                  </td>
                  <td>
                     <fmt:formatNumber value="${place.longitude}" pattern="###.#####"/>
                  </td>
                  <td>${place.road_address}</td>
                  <td>${place.jibun_address}</td>
                  <td>
                     <!-- href속성값에 자바스크립트 함수를 넣을 때는 반드시 함수 앞에 "javascript:" 접두어를 붙여주자 -->
                     <a href="javascript:select('${place.place_no}')">선택</a>
                  </td>
               </tr>
            </c:forEach>
            <!-- --------------------------- -->
            <tr>
               <td></td>
               <td></td>
               <td colspan="2" class="text-center">${pageNavi}</td>
               <td colspan="2" class="text-right">
                  총 등록 장소수 : <b>${totalCount} 개</b>
               </td>
            </tr>
         </table>
      </div>
   </div>

   <!-- 등록할 장소 처리시 사용할 form -->
   <form name="frm" method="post">
      <input type="hidden" name="place_no">
      <!-- hidden data -->
   </form>
</div>
<script>
   function select(place_no) {
      //정말 선택하시겠습니까 물어보기
      var yn = confirm(place_no + "번 장소를 선택하시 겠습니까?");
      //frm폼의 place_no value값으로 place_no값을 넣어주자.
      if (yn) {
         frm.place_no.value = place_no;
         frm.action = "selectPlace";
         frm.method = 'post';
         frm.submit();
      }
   }
</script>

<c:import url="/foot" />

