<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script type="text/javascript">

$(function() {
	$("#login-form").submit(function() {
		if ($("#inputEmail").val() == "") {
			alert("이메일을 입력해주세요");
			$("#inputEmail").focus();
			return false;
		}
		if ($("#inputPassword").val() == "") {
			alert("비밀번호를 입력하세요.");
			$("#inputPassword").focus();
			return false;
		}

		return true;
	});

	$("#loginsubmit").click(function() {
		var email = $("#inputEmail").val();
		var password = $("#inputPassword").val();
		//ajax통신
		$.ajax({
			url : "/railway999/api/member/logincheck",
			type : "get",
			dataType : "json",
			data : "email=" + email + "&password=" + password,
			contentType : 'application/json',
			success : function(response) {
				console.log(response);
				if (response.result == "fail") {
					console.error(response.message);
					return;
				}
				if (response.data == null) {
					alert("이메일 또는 비밀번호가 잘못되었습니다.");
					return;
				}
			},
			error : function(jqXHR, status, e) {
				console.log(status + " : " + e);
			}
		});
	});
});  
</script>
</head>
<body>
<!-- 로그인 팝업 -->
<div id="modalLogin" class="modal fade">
	<div class="modal-dialog"><div class="modal-content">
		<!-- header -->
		<div class="modal-header">
			<!-- 닫기(x) 버튼 -->
			<button type="button" class="close" data-dismiss="modal">×</button>
			<!-- header title -->
			<h4 class="modal-title">로그인</h4>
		</div>
		<!-- body -->
		<form id="login-form" class="form-horizontal" method="post" action="/railway999/member/login">
			<div class="modal-body">
				<div class="form-group"><label for="inputEmail" class="col-lg-2 control-label">ID</label>
					<div class="col-lg-10">
						<input name="email" type="text" class="form-control" id="inputEmail" placeholder="Email">
					</div>
				</div>
				<div class="form-group"><label for="inputPassword" class="col-lg-2 control-label">Password</label>
					<div class="col-lg-10">
						<input name="password" type="password" class="form-control" id="inputPassword" placeholder="Password">
					</div>
				</div>
				
			</div>
			<div id="error"></div>
				<!-- footer -->
			<div class="modal-footer">
                 <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                 <button id="loginsubmit" type=submit class="btn btn-primary">로그인</button>                
            </div>
        </form>
	</div></div>
</div>

<!-- 상단 네비게이션 ================================================== -->
	<div class="navbar navbar-default navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
			
				<!-- 프로젝트 이름 -->
				<a href="/railway999/" class="navbar-brand">은하철도999</a>
				<button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#navbar-main">
					<span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
				</button>
			</div>
			<div class="navbar-collapse collapse" id="navbar-main">			
				<ul class="nav navbar-nav">
					<!-- 첫번째 메뉴 -->
					<li class="dropdown"><a class="dropdown-toggle btn" data-toggle="dropdown" href="#" id="themes">은하철도999<span class="caret"></span></a>
						<ul class="dropdown-menu" aria-labelledby="themes">
							<li><a href="#intro" class="btn">999 소개</a></li>
							<li><a href="#howtouse" class="btn">999 사용법</a></li>
						</ul></li>
						
					<!-- 두번째 메뉴 -->	
					<li><a href="/railway999/scheduleMain/search" class="btn">검색 및 추가</a></li>
					
					<!-- 세번째 메뉴 -->
					<li><a href="/railway999/scheduleMain/myschedule" class="btn">나의 여행스케줄</a></li>
					
					<!-- 네번째 메뉴 -->
					<li class="dropdown"><a class="dropdown-toggle btn" data-toggle="dropdown" href="#" id="download">게시판 <span class="caret"></span></a>
						<ul class="dropdown-menu" aria-labelledby="time-search">
							<li><a href="/railway999/notice"  class="btn">공지사항</a></li>
							<li><a href="/railway999/qboard" class="btn">질문게시판</a></li>
							<li><a href="/railway999/freeboard" class="btn">자유게시판</a></li>
						</ul></li>
				</ul>
			<c:choose>
			<c:when test="${empty AuthMember }">
				<!-- 로그인, 회원가입 -->
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#" class="btn" data-toggle="modal" data-target="#modalLogin">로그인</a></li>
					<li><a href="/railway999/member/joinform" class="btn" >회원가입</a></li>
				</ul>
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test='${"admin" eq AuthMember.role }'>
						<ul class="nav navbar-nav navbar-right">
							<li><a href="/railway999/member/admin" class="btn" >관리자</a></li>
							<li><a href="/railway999/member/logout" class="btn" >로그아웃</a></li>
							<li><a href="/railway999/member/modifyform" class="btn">회원정보수정</a></li>
						</ul>
					</c:when>
					<c:otherwise>
						<ul class="nav navbar-nav navbar-right">
							<li><a href="/railway999/member/logout" class="btn" >로그아웃</a></li>
							<li><a href="/railway999/member/modifyform" class="btn">회원정보수정</a></li>
						</ul>
					</c:otherwise>
				</c:choose>	
				<!-- 로그아웃, 회원정보수정 -->
				
			</c:otherwise>
		</c:choose>
			</div>
		</div>
	</div>
</body>
</html>