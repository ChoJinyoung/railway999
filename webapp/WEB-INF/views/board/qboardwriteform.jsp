<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/railway999/assets/css/bootstrap-responsive.css">
<link rel="stylesheet" href="/railway999/assets/css/bootstrap.css" media="screen">
<link rel="stylesheet" href="/railway999/assets/css/custom.min.css">
<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="/railway999/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="/railway999/assets/js/custom.js"></script>

<title>Q&A</title>
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
<!-- 본문 시작 -->
<div class="container">
	<!-- 페이지 이름 : Q&A --> 
 	<div class="row">        
		<div class="page-header">
			<h2 id="forms">Q&A</h2><br>
			<label id="forms">&nbsp;&nbsp;999 회원님들께서 궁금하신 사항들을 질문해주세요.</label>
		</div>
	</div>
 	<!-- side 네비게이션 -->
    <c:import url="/WEB-INF/views/include/navigation.jsp"></c:import>
    <!-- 글쓰기 폼 -->
    <br>
 <div class="col-lg-10">
	<div class="well bs-component ">   
    <form class="form-horizontal" method ="post" action="/railway999/qboard/insert">
        <c:if test="${not empty AuthMember}">
    		<input type="hidden" name="memberno" value='${AuthMember.no}'>
    	</c:if>
		<fieldset>
			<div class="form-group">
				<div class="col-lg-12">
					<input type="text" class="form-control" placeholder="제목" name="title">
				</div>
			</div>
			<div class="form-group">
			<div class="col-lg-12">
				<textarea class="form-control" rows="10" id="textArea" placeholder="내용" name="content"></textarea>
				</div><br>
            <p class="submitcontent pull-left"><br>
            <a href="/railway999/qboard/list" class="btn btn-default btn-sm">취소</a>
            <button type="submit" class="btn btn-primary btn-sm" value="등록">등록</button>
            </p>
			</div>
		</fieldset>
	</form>
	</div>
</div>
	<!-- Footer import -->		
	<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
</div>


</body>
</html>