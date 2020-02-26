<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
 
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
	 <%-- <link href="<%=myctx %>/asset/css/style.css" rel="stylesheet"> --%>
   <link href="./style.css" rel="stylesheet">
</head>
<body>
  <section id="chat">
          <div class="header-chat">
            <i class="icon fa fa-user-o" aria-hidden="true"></i>
            <p class="name">채팅방 이름</p>
          </div>
          <div class="messages-chat">
            <div class="message">
              <div class="photo" style="background-image: url(asset/images/face.png);">
                <div class="online"></div>
              </div>
              <p class="text"> Hi, how are you ? </p> 
            </div>
            <div class="message text-only">
              <p class="text"> What are you doing tonight ? Want to go take a drink ?</p>
            </div>
            <p class="time"> 14h58</p>
            <div class="message text-only">
              <div class="response">
                <p class="text"> Hey Megan ! It's been a while 😃</p>
              </div>
            </div>
            <div class="message text-only">
              <div class="response">
                <p class="text"> When can we meet ?</p>
              </div>
            </div>
            <p class="response-time time"> 15h04</p>
            <div class="message">
              <div class="photo" style="background-image:url(asset/images/face.png);">
                <div class="online"></div>
              </div>
              <p class="text"> 9 pm at the bar if possible 😳</p>
            </div>
            <p class="time"> 15h09</p>
          </div>
          <div class="footer-chat">
            <i class="icon1 fa fa-smile-o clickable" style="font-size:25pt;" aria-hidden="true"></i>
            <input type="text" class="write-message" placeholder="Type your message here"></input>
            <i class="icon2 send fa fa-paper-plane-o clickable" aria-hidden="true"></i>
          </div>
        </section>
       
    
       
        </body>
        </html>