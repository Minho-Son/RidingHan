<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.tis.ridinghan.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String myctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">

<meta http-equiv="content-type" content="text/html;charset=UTF-8" />

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<meta name="format-detection" content="telephone=no">
<meta name="format-detection" content="email=no">
<link rel="exerd icon" href="<%=myctx%>/asset/images/favicon.ico">
<title>LetsRun</title>
<meta name="description" content="mypet">
<meta name="keywords" content="mypet">

<!--자바스크립트 / CSS-->
<link href="<%=myctx%>/asset/css/style.css" rel="stylesheet">
<!--script src="<--%=myctx%>/asset/js/jquery.min.js"></script-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="<%=myctx%>/asset/js/common.js"></script>
<script src="<%=myctx%>/asset/js/custom.js"></script>

<!--부트스트랩-->
<link rel="stylesheet" href="<%=myctx%>/asset/css/bootstrap.min.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>

<body>
	<!-- ===== wrap ====== -->
	<div id="wrap" class="index">

		<!-- ===== header ====== -->
		<header id="header2">
			<div class="inner2">
				<h1 class="logo">
					<a href="<%=myctx%>/index"></a>
				</h1>
				<div class="utill2">

					<a href="<%=myctx%>/chat" target="_self" class="doc">채팅</a> <a
						href="<%=myctx%>/map" target="_self" class="sup">나의 여행</a>
				</div>
				<div class="lang2">
					<c:if test="${user eq null}">
						<a href="<%=myctx%>/login" class="active">로그인</a>
					</c:if>
					<c:if test="${user ne null}">
						<a href="<%=myctx%>/logout" class="active">로그아웃</a>
					</c:if>
					<a href="<%=myctx%>/signup">회원가입</a> <a href="<%=myctx%>/mypage">마이페이지</a>
				</div>
			</div>
		</header>
		<!-- ===== /header ====== -->
				<div id="gnbWrap">
			<ul id="gnb">
				<li class="active" data-menuanchor="intro"><a href="index.html#intro">HOME</a></li>
				<li data-menuanchor="index01"><a href="index.html#index01">START RIDING</a></li>
				<li data-menuanchor="index02"><a href="index.html#index02">MY TRAVEL</a></li>
				<li data-menuanchor="index05"><a href="index.html#index05">CAMPAIGN</a></li>
			</ul>
		</div>
		
		<div class="bt-mn">
			<a href="#none"><i></i><i></i><i></i><span>메뉴</span></a>
		</div>

		<!-- ===== lm ====== -->
		<div id="lm">
			<div class="inner">
				<div class="hd">
					<a href="#none" class="close">닫기</a>
				</div>
				<ul class="menu">
					<li><em>Menu</em>
						<ul>
							<li><a href="<%=myctx%>/board">게시판</a></li>
							<li><a href="<%=myctx%>/map">마이 라이딩</a></li>
							<li><a href="<%=myctx%>/map" target="_blank">나의 여행</a></li>
							<li><a href="<%=myctx%>/mypage" target="_blank">마이페이지</a></li>
							<li><a href="policy.html">개인 정보 정책 </a></li>
							<li><a href="service.html">서비스 약관</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
		<!-- ===== /lm ====== -->
		