<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#container{
		background-color:pink;
		 width: 1000px;
		 height: 800px;
		 margin: auto;
	}
	.f-left{
		background-color:powderblue;
		width:220px;
		height:750px;
		float:left;
		display:block;
		margin: 20px;
	}
	.f-right{
		background-color:yellow;
		width:700px;
		height:750px;
		float :right;
		display:block;
		margin:20px;
	}
	.inner1{
		background-color:green;
		width:220px;
		height:600px;
		
	}
	.all-list{
		background-color:red;
		width:670px;
		height:640px;
		float:left;
		display:block;
		margin:15px;
	}
	
</style>
</head>
<body>
	<div id="container">
		<div class="f-left">
			<div class="inner1">
				<h2>참여중인 채팅목록</h2>
				<hr>
			</div>
			<div>
				<h2><input type="button" value="채팅방 만들기"></h2>
			</div>
		</div>
		
		<div class="f-right">
			<h2>전체 채팅 목록</h2>
			<hr>
			<div class="all-list">
				<!-- <여기서 반복문> -->
				<div>dd</div>
				<!-- </여기까지> -->
			</div>
		</div>
	</div>
</body>
</html>