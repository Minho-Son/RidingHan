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
		ws=new WebSocket("ws://localhost:9090/RidingHan/echo")
		$("#textInput").focus();
		
		//메세지 보내기
		ws.onopen=function(){
			$("#textArea").append("<b>"+nick+"님이 채팅방에 참여했습니다.</b>")
			$("#sendText").click(function(){
				var msg=$('input[name=textInput]').val().trim("@!|");
				var room=$("#chatTitle");
				
				if(msg!=""){
					ws.send(msg+"@!|"+""+"@!|"+room);
					$("#textArea").append("<div class='message text-only'><div class='response'><p class='text'>"+msg+"</p></div></div><br><p class='response-time time'> 15h04</p>");
					$("#textArea").scrollTop(99999999);
					$("#textInput").val("");
					$("#textInput").focus();
				}
			})
			$("textInput").keypress(function(event){
				if(event.which=="13"){
					event.preventDefault();
					var msg=$('input[name=textInput]').val().trim("@!|");
					var room=$("#chatTitle");

					if(msg!=""){
						ws.send(msg+"@!|"+""+"@!|"+room);
						$("#textArea").append("<div class='message text-only'><div class='response'><p class='text'>"+msg+"</p></div></div><br><p class='response-time time'> 15h04</p>");
						$("#textArea").scrollTop(99999999);
						$("#textInput").val("");
						$("#textInput").focus();
						}
				}
			})
			//서버로부터 받은 메시지
			ws.onmessage=function(msg){
				var jsonData=JSON.parse(msg.data);
				if(jsonData.msg!=null){
					$("#textArea").append("<div class='message text-only'><p class='text'>"+jsonData.msg+"</p></div>");
					$("#textArea").scrollTop(99999999);
				}
				if(jsonData.list!=null){
					
				}
				if(jsonData.room!=null){
					
				}
				
			}
			ws.onclose=function(event){
				
			}
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
            <div class="message">
              <div class="photo" style="background-image:/asset/images/face.png;">
                <div class="online"></div>
              </div>
              <p class="text">${user.nickName} Hi, how are you ? </p> 
            </div>
            <div class="message text-only">
              <p class="text"> What are you doing tonight ? Want to go take a drink ?</p>
            </div>
            <p class="time"> 14h58</p>               
            <div class="message">
          </div>
          <div class="footer-chat">
            <i class="icon1 fa fa-smile-o clickable" style="font-size:25pt;" aria-hidden="true"></i>
            <input type="text" class="write-message" name="textInput" id="textInput" placeholder="Type your message here"></input>
            <i class="icon2 send fa fa-paper-plane-o clickable" id="sendText" aria-hidden="true"></i>
            </div>
          </div>
        </section>     
        </body>
        </html>