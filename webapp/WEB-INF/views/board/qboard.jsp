<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
			<h2 id="forms">질문게시판</h2><br>
			<label id="forms">&nbsp;&nbsp;999 회원님들께서 궁금하신 사항들을 질문해주세요.</label>
		</div>
	</div>
 	<!-- side 네비게이션 -->
    <c:import url="/WEB-INF/views/include/navigation.jsp"></c:import>
    <!-------========Table=========-------->
    <br>
	<div class="span9">
    	<table class="table table-striped table-hover ">
        	<thead>
           	<tr>
              	<th>번호</th>
                <th>제목</th>
                <th>글쓴이</th>
                <th>날짜</th>
                <th>조회</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items='${listData.list }' var='vo' varStatus='status'>	
            <tr class="active">
            	<td>${status.index+1 }</td>
                <td id="title"><a href="/railway999/qboard/viewform/${vo.qboardno}">${vo.title }</a></td>
                <td id="memberName">${vo.name }</td>
                <td id="date">${vo.createdDate }</td>
                <td id="cntView">${vo.viewcnt }</td>
            </tr>
            </c:forEach>
            </tbody>
        </table>     
 		                     			
		<!-- pagination -->	
	<div class="pager"> 
			<ul>
			<c:if test="${listData.preBlock > 0 }">
                	<li><a href="/railway999/qboard?p=${listData.preBlock }&kwd=${listData.kwd}">◀ 이전</a></li>
            </c:if>
				<c:forEach begin="${listData.startPage }" end="${listData.endPage }" var="pageIndex" step="1">
					<c:choose>
						<c:when test="${pageIndex > listData.totalPage }">
						  <li style="display: none"><a href="#">${pageIndex }</a></li>
                        </c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${pageIndex == listData.currentPage }">
									<li class="disabled"><a href="#">${pageIndex }</a></li>
								</c:when>
								<c:otherwise>
									<li><a href="/railway999/qboard?p=${pageIndex }">${pageIndex }</a></li>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${listData.nextBlock > 0 }">
					 <li class="pg-next"><a href="/railway999/qboard?p=${listData.nextBlock }&kwd=${listData.kwd}">다음 ▶</a></li>
				</c:if>	
				</ul>
         </div>
            <c:if test='${not empty AuthMember }'>
            	<div class="offset8">
            	<a href="/railway999/qboard/insertform?memberno=${AuthMember.no }" class="btn btn-primary">글쓰기</a><br><br><br><br>
            	</div>
            </c:if>
      
	</div>   
	<!-- Footer import -->		
	<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
</div>
</body>
</html>