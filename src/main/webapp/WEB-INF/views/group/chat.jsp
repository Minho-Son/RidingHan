<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" import="com.tis.ridinghan.*"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">

<meta http-equiv="content-type" content="text/html;charset=UTF-8" />

<head>
<meta charset="UTF-8">
<% String myctx=request.getContextPath(); %>

<!--자바스크립트 / CSS-->
  
   <!--script src="asset/js/jquery.min.js"></script-->
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
   <script src="<%=myctx %>/asset/js/common.js"></script>
   <script src="<%=myctx %>/asset/js/custom.js"></script>

   <!--부트스트랩-->
   <link rel="stylesheet" href="<%=myctx %>/asset/css/bootstrap.min.css" />
   <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	 <%-- <link href="<%=myctx %>/asset/css/chatstyle.css" rel="stylesheet"> --%>
   <link href="<%=myctx%>/asset/css/chatstyle.css" rel="stylesheet">
</head>
<script type="text/javascript">
	var socket=null;
	var nick="${user.nickName}";
	$(document).ready(function(){
		ws=new WebSocket("ws://localhost:9090/RidingHan/echo");
		
		$("#textInput").focus();
		
		//메세지 보내기
		ws.onopen=function(){
			ws.send(100+"@!|${room_code}@!|"+nick);
			$("#chat").append("<b>"+nick+"님이 채팅방에 참여했습니다.</b>")
			$("#sendText").click(function(){
				var msg=$('input[name=textInput]').val();
				var room=$("#chatTitle").text();
				if(msg!=""){
					ws.send(200+"@!|"+msg+"@!|"+room);
					var sentMsg="<div class='message'><div class='response'><p class='text'>"+msg+"</p></div></div><br>";

					$("#chat").append(sentMsg);
					$("#chat").scrollTop(99999999);
					$("#textInput").val("");
					$("#textInput").focus();
				}
			})
			$("#textInput").keypress(function(event){
				if(event.keyCode==13){
					event.preventDefault();
					var msg=$('input[name=textInput]').val();
					var room=$("#chatTitle").text();;
					if(msg!=""){
						ws.send(200+"@!|"+msg+"@!|"+room);
						var sentMsg="<div class='message'><div class='response'><p class='text'>"+msg+"</p></div></div><br>";
						$("#chat").append(sentMsg);
						$("#chat").scrollTop(99999999);
						$("#textInput").val("");
						$("#textInput").focus();
					}
				}
			})
		}
			//서버로부터 받은 메시지
			ws.onmessage=function(msg){
				//alert(msg);
				var data=msg.data;
				//alert(data);
				var receivedMsg="<div class='message text-only' style='margin:0;'><p class='text'>"+data+"</p></div></div><br>";
				$("#chat").append(receivedMsg);
				$("#chat").scrollTop(99999999);
			
				/* var jsonData2=JSON.parse(msg.data)
				if(jsonData2.list!=null){
					$("#listPeople").html(jsonData2.list)
				}
				var jsonData3=JSON.parse(msg.data);
				if(jsonData3.room!=null){
				} */
				
			}
			
			ws.onclose=function(event){
				
			}
	})
	
</script>
<body>
  <section id="chat">
          <div class="header-chat">
            <i class="icon fa fa-user-o" aria-hidden="true"></i>
            <p class="name" id="chatTitle">${chatInfo.chat_title} 채팅방</p>
            <input type="button" style="align:right;" class="btn btn-primary" id="exitChat" name="exitChat" value="나가기">
          </div>
          <div id="chatArea">
          	<c:if test="${allChat==null||empty allChat}">
          		<tr>
					<td colspan="5"><b>그룹원들과 자유롭게 채팅을 나눠보세요.</b></td>
				</tr>
			</c:if>
	          <div class="messages-chat" id="chat">
	          	<c:if test="${allChat!=null||not empty allChat}">
	          		<c:forEach var="chat" items="${allChat}">
	          			<div class='message'><div class='response'><p class='text'>${allChat.chat_text}</p></div></div><br>
	          		</c:forEach>
	          	</c:if>	
	          </div>
		  </div>
          <div class="footer-chat" style="position:fixed; background-color:white">
            <i class="icon1 fa fa-smile-o clickable" style="font-size:25pt;" aria-hidden="true"></i>
            <input type="text" class="write-message" name="textInput" id="textInput" placeholder="메시지를 입력하세요"></input>
            <i class="icon2 send fa fa-paper-plane-o clickable" id="sendText" aria-hidden="true"></i>
          </div>
        </section>     
        </body>
        </html>