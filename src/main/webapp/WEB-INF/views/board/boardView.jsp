<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="../top.jsp" />

<div id="container">
   <div class="s-content">
      <div class="inbx">
         <div class="inner3">
            <div class="group-left">
               <p class="cicon">Q&A게시판</p>
               <form class="form-inline" name="findKeyword" action="searchBoard">
                  <input type="text" name="findKeyword" id="findKeyword"
                     class="form-control col-md-9" placeholder="검색">
                  <button type="submit" id="" class="serchbtn-bl">검색</button>
               </form>
               <p class="txt_blue">많이 찾는 질문글</p>
                <c:forEach var="board" items="${Top5BoardList}" begin='0' end='4'>
               <a href="boardView?board_idx=${board.board_idx}" class="txt_black">- ${board.board_title}</a>
            </c:forEach>
            </div>

            <div class="group-right">
               <div class="boardinner">
                  <c:if test="${bi eq null }">
                     <br>
                     <br>
                     <br>
                     <br>
                     <br>
                     <br>
                     <br>
                     <h2
                        style="width: 500px; height: 500px; margin: auto; color: #337AF2">
                        게시글이 존재하지 않습니다&nbsp; ;(</h2>
                  </c:if>
                  <br>
                  <c:if test="${bi ne null }">
                     <form name="bf" method="post">
                        <p class="board_title">${bi.board_title }</p>

                        <table class="table" style="font-size: 14px">
                           <tr>
                              <th>글번호</th>
                              <td>${bi.board_idx}</td>
                              <th>작성일</th>
                              <td>${bi.board_wdate}</td>
                           </tr>
                           <tr>
                              <th>작성자</th>
                              <td>${bi.user_nick}</td>
                              <th>조회수</th>
                              <td>${bi.readnum}</td>
                           </tr>
                           <tr>
                              <td colspan="4" align="left" class="board_content">
                                 ${bi.board_content}</td>
                           </tr>
                           <tr>
                              <th>첨부파일</th>
                              <td colspan="3" align="left" style="word-break: break-all">
                                 <c:if
                                    test="${fn:endsWith(bi.originFilename,'.JPG') or fn:endsWith(bi.originFilename,'.PNG') or fn:endsWith(bi.originFilename,'.png')
                                    or fn:endsWith(bi.originFilename,'.jpg') }">
                                    <img width="80px" class="img img-thumbnail"
                                       src="./asset/images/board/${bi.filename}">
                                 </c:if> 
                                 <a href="#"
                                 onclick="goDown('${bi.filename}','${bi.originFilename}')">${bi.originFilename}
                                    &nbsp;</a> [${bi.filesize}bytes]
                              </td>
                           </tr>
                           <tr>
                              <th>비밀번호</th>
                              <td><input class="col-md-8" type="password"
                                 name="board_pwd"></td>
                           </tr>
                        </table>
                        <hr>
                        <a href="board" class="serchbtn-bl2" style="line-height: 33px">전체글</a>
                        <a href="#" onclick="del()" class="serchbtn-bl"
                           style="float: right; margin-left: 5px; line-height: 33px">삭제</a>
                        <a href="#" onclick="edit()" class="serchbtn-bl"
                           style="float: right; line-height: 33px">편집</a> <input
                           type="hidden" name="board_idx" value="${bi.board_idx}">
                     </form>
                  </c:if>
               </div>
               <!-- <button type="button" id="gochat" class="btn btn-success col-3">채팅하기</button> -->
            </div>
            <br class="clear">
         </div>
      </div>
   </div>


   <script>
      function del() {
         if (!bf.board_pwd.value) {
            alert('비밀번호를 입력하세요');
            return;
         }
         bf.action = "boardDel";
         bf.submit();
      }
      function edit() {
         if (!bf.board_pwd.value) {
            alert('비밀번호를 입력하세요');
            return;
         }
         bf.action = "boardEditForm";
         bf.submit();
      }
      var goDown = function(fname, origin) {
         location.href = "fileDown?filename=" + encodeURIComponent(fname)
               + "&origin=" + encodeURIComponent(origin);

      }
   </script>

   <jsp:include page="../foot.jsp" />