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
<script src='/railway999/assets/js/jquery.chained.js'></script>


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
	
	$(document).ready()	
</script>
<script>

var pageNumber=1;
var fetchList = function() {
	$.ajax( {
		url : "/railway999/api/admin/listpage",
		type: "get",
		dataType: "json",
		data: "page="+pageNumber++,
		contentType: 'application/json',
		success: function( response ){
			if( response.result == "fail" ) {				
				console.error( response.message );
				return;
			}
			//rendering
			$.each( response.data, function(index, data){
				insertMessage( data, false);
			});
		},
		error: function( jqXHR, status, e ){
			console.error( status + " : " + e );
		}
	});	
}

var insertMessage = function( data, isHead ) {
	// template EJS Library 로 교체할 것
	var html =		
		"<tr id='tabledelete"+ data.no+"' class='active'>" +
		"<td>" + data.email + "</td>" +
        "<td id='memberName'>"+ data.name + "</td>" +
      	"<td id='memberName'>" + data.regDate + "</td>" +
      	"<td id='role'>" + data.role + "</td>" + "<td id='delete'>" +
		"<input name='delete' value='탈퇴' type='button' class='btn btn-default btn-xs'  data-no='" + data.no + "'>" +
		"<br></td></tr>"
	
	var $listDiv = $( "#list" );
	if( isHead ) {
		$listDiv.prepend( html );
	} else {
		$listDiv.append( html );
	}
}
$(function() {
	fetchList();
	$(document).on("click", "input[name=delete]", function() {
		
 		var $btn = $(this);
 		var no = $btn.attr( "data-no" );
 		
 		console.log(no);
		
		//ajax
		var r=confirm("삭제하시겠습니까?");
		if (r==true){
		$.ajax( {
			url : "/railway999/api/admin/drop",
			type: "post",
			data: "no=" + no, // " vo에 잇는 이름 " 다음 + name은 윗 var값을 가져와서 var이름에 넣어서 data로 들어옴.
			dataType: "json",
			
			success: function( response ){
				console.log( response );
				
				if( response.result == "fail" ) {				
					console.error( response.message );
					return;
				}
				$("#tabledelete" + response.data ).remove();
			},
			error: function( jqXHR, status, e ){
				console.error( status + " : " + e );
			}
			
		});
		}
	}); 
	
	
	
	$(document).on("change", "#changerole", function(){
		console.log("DDDD");
	});
		
		/* console.log(IdNum1);
		$.get("http://openapi.tago.go.kr/openapi/service/TrainInfoService/getCtyAcctoTrainSttnList",{
			"cityCode" : IdNum1,
			"serviceKey" : serviceKey
				},function(data) {
					var xml = data.responseText;
					console.log(xml);
					
					$(xml).find("item").each(function() {

					var nodeid = $(this).find("nodeid").text();
					var nodename = $(this).find("nodename").text();

					var option2 = $("<option>").addClass(IdNum1).val(nodeid).html(nodename);
					$("#rail1").append(option2);
					});
				});		 */
	
	$("#btn-next").click(function() {
		fetchList();
	});
});

</script>	
	
</head>
<body>
<!-- 상단네비게이션 import -->
<c:import url="/WEB-INF/views/include/header.jsp"></c:import>   
<!-- 본문 시작 -->
<div class="container">
	<!-- 페이지 이름 : 회원관리 --> 
 	<div class="row">        
		<div class="page-header">
			<h2 id="forms">회원관리</h2>
		</div>
	</div>
    <!-------========Table=========-------->
   
    <br>
	<div class="span11">
    	<table class="table table-striped table-hover ">
        	<thead>
           	<tr>
              	<th>아이디</th>
                <th>이름</th>
                <th>가입일</th>
                <th>등급</th>
                <th>탈퇴</th>
            </tr>
            </thead>
            <tbody id="list">
            </tbody>
        </table>     
 		                     			
		<!-- pagination -->	
		<input id="btn-next" type="button" class="btn btn-primary pull-right" value="다음▶">
		<br>
		<br><br>
	</div>       
	<!-- Footer import -->		
<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
</div>
</body>
</html>