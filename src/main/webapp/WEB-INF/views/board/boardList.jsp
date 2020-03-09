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
		<div class="inner3">
			<div class="group-left">
				<p class="cicon">게시판</p>
				<form class="form-inline">
					<input type="text" name="serch" id="serch"
						class="form-control col-md-7" placeholder="검색">
					<button type="button" id="" class="">검색</button>
				</form>

				<button type="button" id="insertboard"
					class="btn btn-success col-12">게시글 쓰기 +</button>
				<p class="txt_blue">최근 게시글</p>
				<br>
				<c:forEach var="board" items="${boardArr }" begin="0" end="4">
					<a href="boardView?board_idx=${board.board_idx}" class="txt_black">${board.board_title}</a>
					<br>
				</c:forEach>
			</div>

			<c:if test="${boardArr==null || empty boardArr}">
				<tr>
					<td colspan="5"><b>현재 게시글이 없습니다.</b></td>
				</tr>
			</c:if>
			<c:if test="${boardArr !=null and not empty boardArr }">
				<div class="group-right">
					<c:forEach var="board" items="${boardArr}">
						<div class="group-box">
							<img
								style="width: 70px; height: 70px; z-index: -1; display: inline-block; border-radius: 35px; float: left;"
								src="resources/images/${board.board_img}">
							
							<div class="group-txt">
								<a href="boardView?board_idx=${board.board_idx }">${board.board_title}</a>
								<br>
								<div style="font-size: 10px;">
									<fmt:formatDate value="${board.board_wdate}" pattern="yy.MM.dd" />
								</div>

								<span
									style="font-size: 12px; position: absolute; bottom: 0; z-index: 9;">
									${board.board_wdate} </span>

							</div>


						</div>
					</c:forEach>
					<table style="background-color: powderblue">
						<tr>
							<td colspan="6" class="text-center" style="width: 800px">${pageNavi}</td>
							<td colspan="2" class="text-right">총 게시글 수 <b>${totalCount}</b>
							</td>
						</tr>
					</table>
				</div>
			</c:if>
			<br class="clear">
		</div>
	</div>
</div>

<!--채팅 추가 모달+--------------------------->
<div class="modal fade" id="boardModal">
	<div class="modal-dialog">
		<div class="modal-content">

			<!-- Modal Header -->
			<form action="boardInsert" method="post">
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