<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/railway999/assets/css/bootstrap-responsive.css"><link rel="stylesheet" href="/railway999/assets/css/bootstrap.css" media="screen"><link rel="stylesheet" href="/railway999/assets/css/custom.min.css">
<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script><script src="/railway999/bower_components/bootstrap/dist/js/bootstrap.min.js"></script><script src="/railway999/assets/js/custom.js"></script>
<title>NOTICE</title>
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
	<!-- 페이지 이름 : notice --> 
 	<div class="row">        
		<div class="page-header">
			<h2 id="forms">공지사항</h2><br>
			<label id="forms">&nbsp;&nbsp;999 에서 공지사항을 알려드립니다.</label>
		</div>
	</div>
    <!-- side 네비게이션 -->
    <c:import url="/WEB-INF/views/include/navigation.jsp"></c:import>
    <!-------========Table=========-------->
    <br>
	<div class="span9">
    	<table class="table">	
        	<thead >
           	<tr class="notice" > 
              	<th id="titleview">[공지] ${notice.title }</th>
              	<th id="dateview"> 등록일 :&nbsp; ${notice.regDate } </th>
            </tr>
            </thead>
            <tbody>
             <tr>
            	<td colspan=2>
            	<div class="col-lg-12">
            		<div class="bs-component"><br>
            			<p>${notice.content }</p>
            		<br>
            		</div>
            	</div>
            	</td>
            </tr>
            <tr>
            <td></td>
            	<td>
            	<!-- button -->
            	<c:if test='${"admin" == AuthMember.role }'>
            	<p class="pull-right">
           			<a href="/railway999/notice/modify?no=${notice.no }" class="btn btn-link btn-sm">수정</a>
            		<a href="/railway999/notice/delete?no=${notice.no }" class="btn btn-link btn-sm">삭제</a>
        		</p>
        		</c:if>
        		</td>
        	</tr>
            </tbody>
        </table>  
        
        	<a href="/railway999/notice" type="button" class="btn btn-primary btn-sm pull-right">목록보기</a>
		<br>  
		<br> 
		<br> 	 
        </div>   
        	                     			
	
	<!-- Footer import -->		
	<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
</div>
</body>
</html>