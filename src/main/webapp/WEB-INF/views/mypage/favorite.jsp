<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String myctx = request.getContextPath();
%>
<c:import url="/top" />
<c:import url="/mypageTop" />
<!-- ===== 로그인 ====== -->
<script type="text/javascript">
	function showFavorite() {
		window.open("favorite.html", "chatpop",
				"width=600, height=800, top=0, resizable=no")
	}
</script>

<!-- 즐겨찾기 -->
<div class="mgroup-right">
	<h6 class="mtitle" style="margin-bottom: 0">즐겨찾기</h6>
	<div class="select-mcate">
		<input type="button" class="serchbtn-bl btn-sm-1" value="전체" /> <input
			type="button" class="serchbtn-wh btn-sm-1" value="경로" /> <input
			type="button" class="serchbtn-wh btn-sm-1" value="장소" />
	</div>
	<div class="group-box2">
		<a onclick="showFavorite()">
			<div class="profile2" href="${chat.chat_url}">
				<img src="asset/images/chat/${chat.chat_image}">
			</div>
			<div class="group-txt2">
				<p class="mtxt_black">즐겨찾기한 경로</p>
				<br />
				<p class="mtxt_gray3">즐겨찾기한 경로에 대한 설명</p>
				<p class="mtxt_small_blue">송파구 송파대로 맛있는 국밥집</p>
				<img class="m-arrow" src="./asset/images/blt_open.png" />
				<p class="mtxt_small_blue">송파구 송파대로 345</p>
				<p class="mtxt_small_gray">2020-02-24</p>
			</div>
		</a>
		<button type="button" id="m-cancle" class="m-cancle">삭제</button>
	</div>
</div>
</div>
</div>