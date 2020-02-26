<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.tis.ridinghan.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<c:import url="/top"/>

<script src="../asset/js/jquery.min.js"></script>
<!DOCTYPE>
<script type="text/javascript">

	var flag=false;
	
	function message(str){
		var obj=document.getElementById("msg");
		obj.innerHTML=str;
		}
	
	$(function(){
		
		$('#btnEdit').click(function(){
			if(!$('#user_name').val()){
				var str='※ 이름을 입력해주세요';
				message(str);
				return;
			}
			if(!nameChk($('#user_name').val())){
				var str='※ 올바른 형식의 이름이 아닙니다';
				message(str);
				return;
			}
			if(!$('#nickName').val()){
				var str='※ 닉네임을 입력해주세요';
				message(str);
				return;
			}
			if(!nickChk($('#nickName').val())){
				var str='※ 올바른 형식의 닉네임이 아닙니다';
				message(str);
				return;
			}
			if($('#nickName').val()!="${user.nickName}"){
				if(flag==false){
					var str='※ 닉네임 중복검사를 해주세요';
					message(str);
					return;
				}
			}
			if(!$('#pwd').val()){
				var str='※ 비밀번호를 입력해주세요';
				message(str);
				return;
			}
			if($('#newPwd').val()!=""){
				if(!pwdChk($('#newPwd').val())){
					var str='※ 새 비밀번호는 영문,숫자,특수문자를 포함 8-13자로 해주세요';
					message(str);
					return;
				}
				if(!$('#newPwd2').val()){
					var str='※ 새 비밀번호 확인을 입력해주세요';
					message(str);
					return;
				}
				if($('#newPwd').val()!=$('#newPwd2').val()){
					var str='※ 변경할 비밀번호와 똑같이 입력해주세요';
					message(str);
					return;
				}	
			}
			$('#mf').submit();
		});//btnEdit-------------
		
		
		$('#btnDelUser').click(function(){
			alert('탈퇴 하시겠습니까');
		});//btnDelUser-------------
		
		$('#nickChk').click(function(){
			var val=$('#nickName').val();
			if(!val){
				var str='※ 닉네임을 입력해주세요';
				message(str);
				return;
			}
			if(!nickChk($('#nickName').val())){
				var str='※ 올바른 형식의 닉네임이 아닙니다';
				message(str);
				return;
			}else{
				//alert($('#nickName').val());
				$.ajax({
					type:'GET',
					url:'../nickcheck?nickName='+val,
					dataType:'json',
					cache:false,
					success:function(res){
						if(res.nickOkay>0){
							var str=val+"은 사용 가능한 닉네임입니다"
							message(str);
							flag=true;
							return;
						}else{
							var str=val+"은 사용할 수 없는 닉네임입니다"
							message(str);
							flag=false;
							return;
						}
					},
					error:function(e){
						alert('error: '+e.status);
					}
				})
			}
		})//nickChkRepet()---------------------
		
		function pwdChk(val){
			var pattern=/[A-Za-z]+[\w!_.]{7,12}/;
			var b=pattern.test(val);
			return b;
		}
		function nameChk(val){
			var pattern=/^[가-힣\s]{2,10}$/;
			var b=pattern.test(val);
			return b;
		}		
		function nickChk(val){
			var pattern=/^[\w가-힣\s]{2,10}$/;
			var b=pattern.test(val);
			return b;
		}
	});
	
</script>

<!-- 마이페이지 -->
      <div id="container">
         <div class="inbx">
            <div class="inner4">
               <div class="group-left">
                  <p class="micon">마이페이지</p>
                  <p style="color:#72787F">환영합니다 <b style="color:#337AF2">${user.user_name}</b>님</p>
                  <!-- '성정민'에 회원 이름 나오도록 -->
                  <hr />
                  <p class="mtxt_blue">계정</p>
                  <a class="txt_black">회원정보수정</a>
                  <br />
                  <a class="mtxt_blue">나의 여행</a>
                  <a class="txt_black">즐겨찾기</a>
                  <a class="txt_black">진행중인 여행</a>
                  <a class="txt_black">여행 히스토리</a>

               </div>
               <div class="group-right">
                  <h6 class="mtitle">회원정보수정</h6>
                  <p class="txt_black">기본정보</p>
                  <hr />
                  <form class="modifyform form-inline" id="mf" action="myInfoEdit" method="POST">
                  <label class="mtxt_gray col-md-4">아이디</label>
                  <label class="mtxt_black col-md-6" id="user_id" name="user_id">${user.user_id}</label>
                  <br /><br />
                  <div>
                     <label class="mtxt_gray col-md-4" for="user_name">이름</label>
                     <input type="text" id="user_name" name="user_name"
                     class="form-control col-md-6" value="${user.user_name}">
                  </div>
                  <div>
                     <label class="mtxt_gray col-md-4" for="modify-nickname">닉네임</label>
                     <input type="text" id="nickName" name="nickName"
                     class="form-control col-md-4" value="${user.nickName}">
                     <input type="button" class="modifybtn btn-sm-2" id="nickChk" value="중복확인"/>
                  </div>
                  <div>
                     <label class="mtxt_gray2 col-md-4" for="pwd">이전 비밀번호</label>
                     <input type="password" id="pwd" name="pwd"
                     class="form-control col-md-6">
                  </div>
                  <div>
                     <label class="mtxt_gray2 col-md-4" for="newPwd">새 비밀번호</label>
                     <input type="password" id="newPwd" name="newPwd"
                     class="form-control col-md-6">
                  </div>
                  <div>
                     <label class="mtxt_gray2 col-md-4" for="newPwd2">새 비밀번호 확인</label>
                     <input type="password" id="newPwd2" name="newPwd2"
                     class="form-control col-md-6">
                  </div>
                  <br>
                  <p class="mtxt_gray2">본인인증</p>
                  <p class="mtxt_gray2">인증 완료되었습니다. (인증일: 2020-01-15)</p>
                  <!-- 가입날자 표시 -->
                  <br />
                  <label id="msg" style="fontSize:8pt;color:red;"></label>
                  <br>
                  <div style="text-align:center">
                  	 <button type="button" id="btnEdit" class="btn btn-success col-5">수정</button>
                     <button type="button" id="btnDelUser" class="btn btn-outline-success col-5">회원탈퇴</button>
                  </div>
				</form>
               </div>
               <br class="clear">
            </div>
         </div>
      </div>
<c:import url="/foot"/>