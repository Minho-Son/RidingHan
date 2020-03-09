<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.oreilly.servlet.*, com.oreilly.servlet.multipart.*, com.tis.ridinghan.*"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/top"/>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/asset/css/bootstrap.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>채팅</title>
<!--채팅방---------------------------------->
<script>
var socket;
var nick="${user.nickName}";
$(document).ready(function() { 
    $('#makeChat').click(function(){
       $("#chatModal").modal();
    })
 });

//채팅방 만들기 눌렀을 때 유효성 체크
function message(str) {
		var obj = document.getElementById("msg");
		obj.innerHTML = str;
	}
$(function(){	
	$('#makeChatEnd').click(function(){
		if (!($('#chat_title').val())) {
			var str = '※ 방 제목을 입력해주세요';
			message(str);
			return;
		}
		if (!($('#chat_info').val())) {
			var str = '※ 방 공지사항을 입력해주세요';
			message(str);
			return;
		}
		//alert($('#chat_title').val());
		f.submit();
	})
})

//채팅방으로 현재 방 코드 보내기
function joinChat(tmp){
	var val=tmp.name;
	//alert(val);
	//var val=$('#joinChat').attr('name');
	var w=window.open("about:blank","_blank","width=600, height=500, left=0, top=0");
	$.ajax({
		type:'get',
		url:'chat/chatRoom',
		data:{"room_code":val},
		dataType:'html',
		success:function(res){
			//alert(res);
			w.location.href="/RidingHan/chat/chatRoom?room_code="+val;
		},
		error:function(e){
			alert('error: '+e.status);
		}	
	})
}

</script>

<div id="container">

		<div class="s-content">
			<div class="inner3">
				<div class="group-left">
					<p class="cicon">채팅</p>
					<input type="text" name="search" id="search" class="form-control"
						placeholder="검색">
					<button type="button" id="makeChat" class="btn btn-success col-12">채팅
						만들기 +</button>
					<p class="txt_blue">참여중인 채팅 목록</p><br>
					<c:forEach var="chattitle" items="${chatArr}">
						<a class="txt_black">${chattitle.chat_title}</a><br>
					</c:forEach>
				</div>

				<c:if test="${chatArr==null || empty chatArr}">
					<tr>
						<td colspan="5"><b>현재 채팅방이 없습니다.</b></td>
					</tr>
				</c:if>
				<c:if test="${chatArr !=null || not empty chatArr }">
					<div class="group-right">
						<c:forEach var="chat" items="${chatArr}">
							<div class="group-box">
								<a href="#"> <img
									style="width: 70px; height: 70px; z-index: -1; display: inline-block; border-radius: 35px; float: left;"
									src="asset/images/chat/${chat.chat_img}">
								</a>

								<div class="group-txt">
									${chat.chat_title} <br>
									<div style="font-size: 10px;">
										<fmt:formatDate value="${chat.chat_wtime}"
											pattern="yy.MM.dd" />
									</div>

									<span
										style="font-size: 12px; position: absolute; bottom: 0; z-index: 9;">
										${chat.chat_wtime} </span>

								</div>
								<input type="button" name="${chat.room_code}" id="joinChat" class="enter" onclick="joinChat(this)" value="참여" />

							</div>
						</c:forEach>
						<table  style="background-color:powderblue">
						<tr>
						<td colspan="6" class="text-center" style="width:800px">${pageNavi}</td>
						<td colspan="2" class="text-right">총 채팅방 수  <b>${totalCount}</b>
						</td>
					</tr>
					</table>
					</div>
				</c:if>
				<br class="clear">
			</div>
	</div>
</div>

<!--채팅 추가 모달+------------ enctype="multipart/form-data"--------------->
	<form id="f" method="post" action="chat/newChat">
      <div class="modal fade" id="chatModal">
         <div class="modal-dialog">
            <div class="modal-content">
               <!-- Modal Header -->
               <div class="modal-header">
                  <h6 class="modal-title">채팅 만들기+</h6>
                  <button type="button" class="close" data-dismiss="modal">×</button>
               </div>

               <!-- Modal body -->
               <div class="modal-body">
                  <p class="comment">낯선 사람과 만난다는건 언제나 즐거운 일이죠.<br />채팅방을 만들어 대화를 시작합니다.</p>

                  <div style="text-align:center">
                     <h6 class="title">채팅방 대표 이미지 등록</h6>
                     <input type="file" name="chat_img" id="chat_img" class="form-control">
                  </div>

                  <hr />
                  <h6 class="title">채팅방 이름 입력</h6>
                  <input type="roomname" name="chat_title" id="chat_title" class="form-control">
                  <h6 class="title">공지사항</h6>
                  <textarea type="Gcomment" class="form-control" name="chat_info" id="chat_info" rows="3" id="Gcomment"></textarea>
                  <label id="msg" style="fontSize: 8pt; color: red;"></label>
               </div>
               <!-- Modal footer -->
               <div class="modal-footer">
                  <button type="button" class="btn btn-success" id="makeChatEnd">채팅방 만들기</button>
               </div>
            </div>
         </div>
      </div>
     </form>
<c:import url="/foot"/>