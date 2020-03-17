<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="../top.jsp" />

<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet"
   href="<%=request.getContextPath()%>/asset/css/bootstrap.min.css" />
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>게시판</title>
<!--게시판---------------------------------->
<script>
   $(document).ready(function() {
      $('#insertboard').click(function() {
         $("#boardModal").modal();
      })
   });

   function showPopup() {
      var url = "http://localhost:3333/";
      window.open(url, "chatpop", "width=600, height=500, left=0, top=0");
   }
</script>

<div id="container">

   <div class="s-content">
   	<div class="inbx">
      <div class="inner3">
         <div class="group-left">
            <p class="cicon">Q&A게시판</p>
            <form class="form-inline" name="findKeyword" action="searchBoard">
               <input type="text" name="findKeyword" id="findKeyword"
                  class="form-control col-md-9" placeholder="검색">
               <button type="submit" id="" class="serchbtn-bl">검색</button>
            </form>
            <p class="txt_blue">최근 게시글</p>
            <c:forEach var="board" items="${boardArr}" begin='0' end='4'>
               <a href="boardView?board_idx=${board.board_idx}" class="txt_black">- ${board.board_title}</a>
            </c:forEach>
         </div>

         <c:if test="${boardArr==null || empty boardArr}">
            <tr>
               <td colspan="5"><b>현재 게시글이 없습니다.</b></td>
            </tr>
         </c:if>
         <c:if test="${boardArr !=null and not empty boardArr }">
            <div class="group-right">  
               <table class="table" style="font-size:14px">
               	<thead>
               		<tr>
	               		<th>글번호</th>
	               		<th>제목</th>
	               		<th>글쓴이</th>
	               		<th>날짜</th>
	               		<th>조회수</th>
               		</tr>
               	</thead>
               	<tbody>
               		<c:forEach var="board" items="${boardArr}">
               		<tr >
               			<td>${board.board_idx}</td>
               			<td><a href="boardView?board_idx=${board.board_idx}">${board.board_title}</a></td>
               			<td>${board.user_id}</td>
               			<td><fmt:formatDate value="${board.board_wdate}" pattern="yyyy.MM.dd" /></td>
               			<td>${board.board_title}</td>
               		</tr>
               		</c:forEach>
               	</tbody>
               </table>
               <br><br><hr>
               <table style="background-color: powderblue">
                  <tr>
                     <td colspan="5" class="text-center" style="width: 300px">${pageNavi}</td>
                     <td colspan="2" class="text-right">총 게시글 수 <b>${totalCount}</b>
                     </td>
                  </tr>
               </table>
            	<button type="button" id="insertboard" style="float:right"
               class="btn btn-success col-3">질문남기기 +</button>
               
               
            </div>
         </c:if>
         <br class="clear">
      </div>
   </div>
</div>
</div>
<!--채팅 추가 모달+--------------------------->
<div class="modal fade" id="boardModal">
   <div class="modal-dialog">
      <div class="modal-content">

         <!-- Modal Header -->
         <form action="boardInsert" method="post" enctype="multipart/form-data">
            <div class="modal-header">
               <h6 class="modal-title">게시글 쓰기+</h6>
               <button type="button" class="close" data-dismiss="modal">×</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
               <p class="comment">
                  낯선 사람과 만난다는건 언제나 즐거운 일이죠.<br />게시판을 만들어 정보를 공유합시다.
               </p>

               <!-- <div style="text-align:center">
                     <h6 class="title">채팅방 대표 이미지 등록</h6>
                     <div class="photo" style="background-image: url(asset/images/face.png);"></div><br />
                  </div>
 -->
               <hr />
               <h6 class="title">게시판 제목 등록</h6>
               <input type="Gname" name="board_title" id="board_title"
                  class="form-control">
               <h6 class="title">게시판 내용</h6>
               <textarea type="Gcomment" class="form-control" rows="3"
                  id="board_content" name="board_content"></textarea>
                <div style="text-align:left">
                     <h6 class="title">파일 등록[1]</h6>
                     <input type="file" name="myfile" id="myfile" class="form-control">
                  </div>
                 
            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
               <input type="password" name="board_pwd" id="board_pwd"
                  placeholder="게시글 비밀번호">
               <button type="submit" class="btn btn-success">게시판 만들기</button>
            </div>
         </form>
      </div>
   </div>
</div>
<jsp:include page="../foot.jsp" />