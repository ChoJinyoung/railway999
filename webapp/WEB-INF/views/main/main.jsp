<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/railway999/assets/css/bootstrap-responsive.css"><link rel="stylesheet" href="/railway999/assets/css/bootstrap.css" media="screen"><link rel="stylesheet" href="/railway999/assets/css/custom.min.css">
<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="/railway999/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="/railway999/assets/js/custom.js"></script>
<title>은하철도999</title>
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
</head>
<body>
<!-- 상단네비게이션 import -->
<c:import url="/WEB-INF/views/include/header.jsp"></c:import>	

<!-- 이미지 슬라이드 -->
<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
	<!-- Indicators -->
	<ol class="carousel-indicators">
		<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
		<li data-target="#carousel-example-generic" data-slide-to="1"></li>
		<li data-target="#carousel-example-generic" data-slide-to="2"></li>
		<li data-target="#carousel-example-generic" data-slide-to="3"></li>
	</ol>
	<!-- Wrapper for slides -->
	<div class="carousel-inner" role="listbox">
	<div class="item active">
		<img src="/railway999/assets/img/railro01.jpg" alt="...">
		<div class="carousel-caption"></div>
	</div>
	<div class="item">
		<img src="/railway999/assets/img/railro02.jpg" alt="...">
		<div class="carousel-caption"></div>
	</div>
	<div class="item">
		<img src="/railway999/assets/img/railro03.jpg" alt="...">
		<div class="carousel-caption"></div>
	</div>
	<div class="item">
		<img src="/railway999/assets/img/railro04.jpg" alt="...">
		<div class="carousel-caption"></div>
	</div>
	</div>
</div>
<!-- 공지 -->
<div id="boards" class="form-group">
<br>
	<div id="boards" class="col-lg-4">
		<table class="table table-hover table-bordered">
			<thead>
				<tr class="active">
					<th>공지사항 <a href="/railway999/notice" class="more pull-right">더보기 > &nbsp;</a></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list }" var="vo" varStatus="status">
				<tr class="active">
				<td id="mainnotice"><a href="/railway999/notice/viewform?no=${vo.no }">[공지]&nbsp; ${vo.title }</a></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
	</div>
	<div id="boards" class="col-lg-4">
		<table class="table table-hover table-bordered">
			<thead><tr class="active"><th>질문게시판<a href="/railway999/qboard" class="more pull-right">더보기 > &nbsp;</a></th></tr></thead>
			<tbody>
				<c:forEach items="${qlist }" var="vo" varStatus="status">
				<tr class="active">
				<td id="mainnotice"><a href="/railway999/qboard/viewform/${vo.qboardno }">&nbsp; ${vo.title }</a></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div id="boards" class="col-lg-4">
		<table class="table table-hover table-bordered">
			<thead><tr class="active"><th>자유게시판<a href="/railway999/freeboard" class="more pull-right">더보기 > &nbsp;</a></th></tr></thead>
			<tbody>
				<c:forEach items="${flist }" var="vo" varStatus="status">
				<tr class="active">
				<td id="mainnotice"><a href="/railway999/freeboard/viewform?no=${vo.freeboardNo }">&nbsp; ${vo.freeboardTitle }</a></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<!-- 999소개 -->
<div class="row">
	<div id="intro" class="col-lg-12">
		<img src="/railway999/assets/img/main_intro.png">

	</div>
</div>

<div class="container">
	<!-- Footer import -->		
	<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
</div>
</body>
</html>