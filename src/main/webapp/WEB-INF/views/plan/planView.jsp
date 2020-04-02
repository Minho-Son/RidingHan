<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String myctx = request.getContextPath();
%>
<!--자바스크립트 / CSS-->
<link href="<%=myctx%>/asset/css/style.css" rel="stylesheet">
<script src="<%=myctx%>/asset/js/jquery.min.js"></script>
<!-- <script src="https://ajax.googleapiscom/ajax/libs/jquery/3.4.1/jquery.min.js"></script> -->
<script src="<%=myctx%>/asset/js/common.js"></script>
<script src="<%=myctx%>/asset/js/custom.js"></script>

<!--부트스트랩-->
<link rel="stylesheet" href="<%=myctx%>/asset/css/bootstrap.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

<style type="text/css">

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
 
 
 <form id="pf" method="POST" action="plan/makePlan">
      <div class="modal fade" id="groupModal">
         <div class="modal-dialog">
            <div class="modal-content">

               <!-- Modal Header -->
               <div class="modal-header">
                  <h6 class="modal-title">${planList.plan_title}</h6>
                  <button type="button" class="close" data-dismiss="modal"></button>
               </div>

               <!-- Modal body -->
               <div class="modal-body">
               <c:forEach var="planList" items="${planArr}">
                  <h6 class="title">플랜 소개</h6>
                  <input type="Gname" name="plan_title" id="plan_title" value="${planList.plan_about}" class="form-control">
                  <h6 class="title">플랜 멤버</h6>
                  <textarea type="Gcomment" name="plan_about" id="plan_about" value="${planList.user_no}"
                  class="form-control" rows="1"></textarea>
                  <hr />
                  <h6 class="title">경로 또는 장소
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
			   </c:forEach>
               </div>
               <!-- Modal footer -->
               <div class="modal-footer">
               	  <button type="button" class="btn btn-success" id="close">닫기</button>
               </div>

            </div>
         </div>
      </div>
      </form>