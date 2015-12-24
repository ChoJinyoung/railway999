<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/railway999/assets/css/bootstrap-responsive.css">
<link rel="stylesheet" href="/railway999/assets/css/bootstrap.css" media="screen">
<link rel="stylesheet" href="/railway999/assets/css/custom.min.css">
<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="/railway999/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="/railway999/assets/js/custom.js"></script>
<title>로그인 : 은하철도999</title>
<script>
	var _gaq = _gaq || [];
	_gaq.push([ '_setAccount', 'UA-23019901-1' ]);
	_gaq.push([ '_setDomainName', "bootswatch.com" ]);
	_gaq.push([ '_setAllowLinker', true ]);
	_gaq.push([ '_trackPageview' ]);
	(function() {
		var ga = document.createElement('script');
		ga.type = 'text/javascript';
		ga.async = true;
		ga.src = ('https:' == document.location.protocol ? 'https://ssl'
				: 'http://www')
				+ '.google-analytics.com/ga.js';
		var s = document.getElementsByTagName('script')[0];
		s.parentNode.insertBefore(ga, s);
	})();
</script>
<script type="text/javascript">

$(function() {
	$("#login-form1").submit(function() {
		if ($("#inputEmail1").val() == "") {
			alert("이메일을 입력해주세요");
			$("#inputEmail1").focus();
			return false;
		}
		if ($("#inputPassword1").val() == "") {
			alert("비밀번호를 입력하세요.");
			$("#inputPassword1").focus();
			return false;
		}

		return true;
	});

	$("#loginsubmit1").click(function() {
		var email = $("#inputEmail1").val();
		var password = $("#inputPassword1").val();
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
<!-- 상단네비게이션 import -->
<c:import url="/WEB-INF/views/include/header.jsp"></c:import>
<!-- 본문 시작 -->
<div class="container">
	<div class="col-lg-12">
		<div class="page-header">
			<h2 id="forms">로그인</h2><br>
			<label id="forms">&nbsp;은하철도999에 오신 것을 환영합니다.</label>
		</div>
	</div>
	
	<form id="login-form1" class="form-horizontal" method="post" action="/railway999/member/login">
				<div class="form-group"><label for="inputEmail" class="col-lg-2 control-label">ID</label>
					<div class="col-lg-10">
						<input name="email" type="text" class="form-control" id="inputEmail1" placeholder="Email">
					</div>
				</div>
				<div class="form-group"><label for="inputPassword" class="col-lg-2 control-label">Password</label>
					<div class="col-lg-10">
						<input name="password" type="password" class="form-control" id="inputPassword1" placeholder="Password">
					</div>
				</div>
			<div id="error"></div>
                 <button id="loginsubmit1" type=submit class="btn btn-primary">로그인</button>                
        </form>
<!-- Footer import -->		
<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
</div>
</body>
</html>