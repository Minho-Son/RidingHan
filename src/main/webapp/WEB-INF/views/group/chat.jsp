<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" import="com.tis.ridinghan.*"%>
 
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
			ws.send(100+"|${room_code}"+200+"|"+nick);
			$("#textArea").append("<b>"+nick+"님이 채팅방에 참여했습니다.</b>")
			$("#sendText").click(function(){
				var msg=$('input[name=textInput]').val().trim("@!|");
				var room=$("#chatTitle");
				
				if(msg!=""){
					ws.send(msg+"@!|"+""+"@!|"+room);
					var sentMsg="<div class='response'><p class='text'>"
								+msg+"</p></div><br><p class='response-time time'>"
								"15h04</p>";
					$("#sent").append(sentMsg);
					$("#textArea").scrollTop(99999999);
					$("#textInput").val("");
					$("#textInput").focus();
				}
			})
			$("#textInput").keypress(function(event){
				console.log(event.keyCode)
				if(event.keyCode==13){
					event.preventDefault();
					var msg=$('input[name=textInput]').val().trim("@!|");
					var room=$("#chatTitle");

					if(msg!=""){
						ws.send(msg+"@!|"+""+"@!|"+room);
						var sentMsg="<div class='response'><p class='text'>"
							+msg+"</p></div><br><p class='response-time time'>"
							"15h04</p>";
						$("#sent").append(sentMsg);
						$("#textArea").scrollTop(99999999);
						$("#textInput").val("");
						$("#textInput").focus();
						}
				}
			})
		}
			//서버로부터 받은 메시지
			ws.onmessage=function(msg){
				var data=msg.data;
				var receivedMsg="<div class='photo' style='background-image:/asset/images/face.png;'><div class='online'>"
								+data+"</div></div><p class='response-time time'> 15h04</p>";
				$("#received").append(receivedMsg);
				$("#textArea").scrollTop(99999999);
			
				var jsonData2=JSON.parse(msg.data)
				if(jsonData2.list!=null){
					$("#listPeople").html(jsonData2.list)
				}
				var jsonData3=JSON.parse(msg.data);
				if(jsonData3.room!=null){
				}
				
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
          <div class="messages-chat" id="textArea">
          
            <div class="message" name="received" id="received">
            </div>     
                  
            <div class="message" name="sent" id="sent">
			</div>
          <div class="footer-chat">
            <i class="icon1 fa fa-smile-o clickable" style="font-size:25pt;" aria-hidden="true"></i>
            <input type="text" class="write-message" name="textInput" id="textInput" placeholder="메시지를 입력하세요"></input>
            <i class="icon2 send fa fa-paper-plane-o clickable" id="sendText" aria-hidden="true"></i>
            </div>
          </div>
        </section>     
        </body>
        </html>