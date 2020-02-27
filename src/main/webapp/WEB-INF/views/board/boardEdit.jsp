<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="../top.jsp" /> 

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/bootstrap.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>게시글 보기</title>

<form name="edit" action="boardEdit" method="POST">
<input type="hidden" name="board_idx" value="${bi.board_idx }">
<div class="container">
<div align="center">
<div class="row">
	<div class="col-md-8 col-md-offset-2"><br>
	
		<table class="table table-boarded">
			<tr>
				<td width="20%">글번호</td>
				<td width="30%">
					${bi.board_idx }
				</td>
				<td width="20%">작성일</td>
				<td width="30%">
					${bi.board_wdate }
				</td>
			</tr>
			<tr>
				<td width="20%">작성자</td>
				<td width="30%">
					${bi.board_user_no}
				</td>
			</tr>
			
			<tr>
				<td width="20%">제목</td>
				<td colspan="3" align="left">
					<input type="text" name="board_title" value="${bi.board_title }">
				</td>
			</tr>
			<tr height="60">
				<td width="20%">글내용</td>
				<td colspan="3" align="left" style="word-break:break-all">
					<input type="text" name="board_content" value="${bi.board_content }">
				</td>
			</tr>
			<tr>
				<td width="20%">첨부파일 </td>
				<td colspan="3">
				<input type="text" name="board_img" value=${bi.board_img }>[bytes]
				</td>
			</tr>
			<tr>
				<td width="30%">변경 할 비밀번호
				<input type="password" name="board_pwd">
				</td>
			</tr>
			<tr>
				<td colspan="4" align=center>
				<a href="board">글목록</a>| <a href="#" onclick="goEdit()">수정 완료</a>|
				
			</tr>
		</table>
		<input type="hidden" name="board_idx" value="${bi.board_idx}">
		
	
	</div>
</div>

</div>

</div>
</form>
<script>
	function goEdit(){
		edit.submit();
	}
	
</script>

<jsp:include page="../foot.jsp" /> 