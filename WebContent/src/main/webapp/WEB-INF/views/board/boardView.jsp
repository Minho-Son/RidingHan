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
${bi}
<div class="container">
<div align="center">
<div class="row">
	<div class="col-md-8 col-md-offset-2">
		
			<h2>게시판 글 내용 보기</h2>
		
		<c:if test="${bi eq null }">
			<h1>게시글이 존재하지 않습니다</h1>
		</c:if>
		<br>
		<c:if test="${bi ne null }">
		<form name="bf" method="post">
		<table class="table table-boarded">
			<tr>
				<td width="20%">글번호</td>
				<td width="30%">
					${bi.board_idx }
				</td>
				<td width="20%">작성일</td>
				<td width="30%">
					${bi.wdate }
				</td>
			</tr>
			<tr>
				<td width="20%">작성자</td>
				<td width="30%">
					${bi.board_userid}
				</td>
			</tr>
			
			<tr>
				<td width="20%">제목</td>
				<td colspan="3" align="left">
					${bi.board_title }
				</td>
			</tr>
			<tr height="60">
				<td width="20%">글내용</td>
				<td colspan="3" align="left" style="word-break:break-all">
					${bi.board_content }
				</td>
			</tr>
			<tr>
				<td width="20%">첨부파일 </td>
				<td colspan="3">
				[bytes]
				</td>
			</tr>
			<tr>
				<td width="30%">비밀번호
				<input type="password" name="board_pwd" >
				</td>
			</tr>
			<tr>
				<td colspan="4" align=center>
				<a href="board">글목록</a>|<a href="#" onclick="edit()">편집</a>|
				<a href="#" onclick="del()">삭제</a>
			</tr>
		</table>
		<input type="hidden" name="board_idx" value="${bi.board_idx}">
		</form>
	</c:if>
	</div>
</div>

</div>
</div>
<script>
	function del(){
		if(!bf.board_pwd.value){
			alert('비밀번호를 입력하세요');
			return;
		}
		bf.action="boardDel";
		bf.submit();
	}
	function edit(){
		if(!bf.board_pwd.value){
			alert('비밀번호를 입력하세요');
			return;
		}
		bf.action="boardEditForm";
		bf.submit();
	}
</script>

<jsp:include page="../foot.jsp" /> 