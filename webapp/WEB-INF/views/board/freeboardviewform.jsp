<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/railway999/assets/css/bootstrap-responsive.css"><link rel="stylesheet" href="/railway999/assets/css/bootstrap.css" media="screen"><link rel="stylesheet" href="/railway999/assets/css/custom.min.css">
<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script><script src="/railway999/bower_components/bootstrap/dist/js/bootstrap.min.js"></script><script src="/railway999/assets/js/custom.js"></script>
<title>자유게시판</title>
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

<!-- Ajax Start -->
<script>
	var nono;
	var fetchList = function() {
	var freeboardNo = $("#freeboardNoco").val();
	$.ajax( {
		url : "/railway999/api/commend/list",
		data: "no="+freeboardNo,
		type: "get",
		dataType: "json",
		contentType: 'application/json',
		success: function( response ){
			if( response.result == "fail" ) {				
				console.error( response.message );
				return;
			}
			
			//rendering
			$.each( response.data, function(index, data){
				console.log(data);
				insertMessage( data, false);
			});
		},
		error: function( jqXHR, status, e ){
			console.error( status + " : " + e );
		}
	});	
}

	 
	
var insertMessage = function( data, isHead ) {
	var qcono = data.memberNo;
	var Authno = $("#memberNo").val();
	if (qcono == Authno){
		nono = 1;
	}else{
		nono = 0;
	}
	
	// template EJS Library 로 교체할 것
	var html =		
		"<tbody id='reply" + data.freecommentsNo + "'>"+"<tr>" +
        "<td id='commentmember' width='10%'>" + data.memberName + "</td>" +
      	"<td id='commentdate'>" + data.createdDate + "</td>" +
      	"<td id='commentmember'>" +
      	"<p class='pull-right'>" +
     	"<a href='#' class='delete-comment' nono='"+nono+"' data-no='"+ data.freecommentsNo + "'>삭제 </a> " +
     	"</p> " +
		"</td>"+
		"</tr>" +
 	    "<tr>" +
    	"<td id='comment' colspan=3>" +
    	
    	"<p>"+ data.freeContent + "</p></td></tr></tbody>";	
	
	var $listDiv = $( "#list" );
	if( isHead ) {
		$listDiv.prepend( html );
	} else {
		$listDiv.append( html );
	}
}


	


	// 게시물 추가 확인 버튼 이벤트 매핑
$(document).ready(function() {
 	var memberName="최수진"; 
	fetchList();
	
	$("#btn-add").click( function() {
		//이름, 비밀번호, content 가져오기 
		var message = $("#commend-message" ).val();	
		var freeboardNo = $("#freeboardNoco").val();
		var memberNo = $("#memberNo").val();
		
		
		//ajax
		$.ajax( {
			url : "/railway999/api/commend/insert", //URL controller 가져오기
			type: "post",
			data: "freeContent=" + message + "&freeboardNo=" + freeboardNo + "&memberName=" + memberName+"&memberNo="+memberNo, // " vo에 잇는 이름 " 다음 + name은 윗 var값을 가져와서 var이름에 넣어서 data로 들어옴.
			dataType: "json",
			/* contentType: 'application/json', post 방식에서는 뺀다.*/
			success: function( response ){
				if( response.result == "fail" ) {				
					console.error( response.message );
					return;
				}			
				insertMessage( response.data, false );
			},
			error: function( jqXHR, status, e ){
				console.error( status + " : " + e );
			}
		});
	});
	
	
});

$(document).on( "click", ".delete-comment", function(){
	event.preventDefault();
	
	var $a = $( this );
	var no = $a.attr( "data-no" );
	var nonono = $a.attr( "nono" );
	
	if (nonono == 1){
	$.ajax( {
		url : "/railway999/api/commend/delete",
		type: "post",
		dataType: "json",
		data: "freecommentsNo=" + no,
		/* contentType: 'application/json', post 방식에서는 뺀다.*/
		success: function( response ){
			console.log( response );

			if( response.result == "fail" ) {
				console.error( response.message );
				return;
			}
			$( "#reply" + no ).remove();
		},
		error: function( jqXHR, status, e ){
			console.error( status + " : " + e );
		}
		
	});	
	}else{
		alert("삭제할 수 없습니다.");
	}
});	

</script>
</head>
<body>
<!-- 상단네비게이션 import -->
<c:import url="/WEB-INF/views/include/header.jsp"></c:import>	

<!-- 본문 시작 -->
<div class="container">

		<!-- 페이지 이름 : 자유게시판 --> 
 	<div class="row">        
		<div class="page-header">
			<h2 id="forms">자유게시판</h2><br>
			<label id="forms">&nbsp;&nbsp;자유게시판입니다.</label>
		</div>
	</div>
	
    <!-- side 네비게이션 -->
    <c:import url="/WEB-INF/views/include/navigation.jsp"></c:import>
    <!-------========Table=========-------->
 
	     
	<div class="span9">
	
    	<table class="table">
        	<thead>
        	
        	
           	<tr> 
           		<th id="boardcategory" width="10%">[자유]</th>
              	<th id="freeboardTitle">${vo.freeboardTitle }</th>
            </tr>
            </thead>
            <tbody>
            <tr>
              	<td id="memberName">${vo.memberName } </td>
              	<td id="createdDate">${vo.createdDate }</td>

            </tr>
            <tr>
            	<td colspan=2>
            	<div class="col-lg-12">
            		<div class="bs-component"><br>
            		<p>
            	
					${vo.freeboardContent }
					
            		</p>
            		<br>
            		</div>
            	</div>
            	</td>
            </tr>
            <tr>
            
            
    
            
            
            	<td></td>
            	<td>
            	<!-- button -->
            	<c:if test='${AuthMember.no==vo.memberNo }'>
            	<p class="pull-right">
           			<a href="/railway999/freeboard/updateform?no=${vo.freeboardNo }" class="btn btn-link btn-sm">수정</a>
            		<a href="/railway999/freeboard/delete?no=${vo.freeboardNo }" class="btn btn-link btn-sm">삭제</a>
        		</p>
        		</c:if>
        		</td>
        	</tr>
            </tbody>
        </table>      
        
        		                     			
				
		<div class="well bs-component">
		<!-------========댓글view=========-------->
		
		<!-- 댓글1 --> 
		<table class="table" id="list">

		</table>
 
        <br>
        <!-------========댓글쓰기=========-------->   
        <form class="form-horizontal"> 	
        <input type="hidden" name="a" value="insert">
        <div class="form-group">
        <input type="hidden" name="memberName" id="memberco" value="${AuthMember.name}">
        <input type="hidden" name="freeboardNo" id="freeboardNoco" value="${vo.freeboardNo}">
        <input type="hidden" name="memberNo" id="memberNo" value="${AuthMember.no}">
            <div>
                <textarea  class="form-control" name="message" id="commend-message" rows="4" ></textarea>
            </div>
            <br>
            <p class="pull-right">
            	<c:choose>
            	<c:when test='${not empty AuthMember}' >
            		<input type="button" class="btn btn-default btn-sm" id="btn-add" VALUE="댓글등록 ">
            	</c:when>
            	<c:otherwise>
            		<input type="button" class="btn btn-default btn-sm disabled" VALUE="댓글등록 ">
            	</c:otherwise>
            </c:choose>
            </p>
        </div>
        </form>	                     			
		</div> 
			<a href="/railway999/freeboard" type="button" class="btn btn-primary btn-sm pull-right">목록보기</a>
		<br>  
		<br> 
		<br> 
			
	</div>		 
	    
	<!-- Footer import -->		
	<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
</div>
</body>
</html>