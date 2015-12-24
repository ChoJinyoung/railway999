<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href="/railway999/assets/css/bootstrap-responsive.css">
<link rel="stylesheet" href="/railway999/assets/css/bootstrap.css" media="screen">
<link rel="stylesheet" href="/railway999/assets/css/bootstrap-datepicker.css">
<link rel="stylesheet" href="/railway999/assets/css/custom.min.css">
<link rel="stylesheet" href="/railway999/assets/css/jquery.timepicker.css">

<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="/railway999/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="/railway999/assets/js/custom.js"></script>
<script src="/railway999/assets/js/bootstrap-datepicker.js"></script>
<script src='/railway999/assets/js/jquery.chained.js'></script>
<script src='/railway999/assets/js/jquery.timepicker.min.js'></script>

<link rel='stylesheet' type='text/css' href='/railway999/assets/css/fullcalendar.css' />
<script type='text/javascript' src='http://arshaw.com/js/fullcalendar-1.6.3/jquery/jquery-ui-1.10.3.custom.min.js'></script>
<script type='text/javascript' src='/railway999/assets/js/fullcalendar.js'></script>

<script type='text/javascript' src='/railway999/assets/js/jquery.printpage.js'></script>

<script src="/railway999/assets/js/unknownboot.js"></script>
<script src="/railway999/assets/js/printThis.js"></script>

<!-- Ajax plugin -->
<script type="text/javascript" src="/railway999/plugins/xdomain/jquery.xdomainajax.js"></script>
<script type="text/javascript" src="/railway999/plugins/xml2json/jquery.xml2json.js"></script>
<script type="text/javascript" src="/railway999/plugins/tmpl/jquery.tmpl.min.js"></script>

<script type="text/javascript">

var year=0;
var month;
var date;
var day;
var travelNo;
var id;
var no;

function loadCalendar() {
	console.log("들어옴");
	var myCalendar = $('#myCalendar');
	no=$("#memberNo").val();
	$.ajax({
		url:'/railway999/api/travel/list',
		type:"get",
		data : "no=" + no,
		dataType:'json',
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		success:function(data,text,request){
			
			$.each( data.jsonTxt, function(index, jsonTxt) {
				
				
				myCalendar.fullCalendar('renderEvent', {
					id: jsonTxt.id,
					title : jsonTxt.title,
					start : jsonTxt.start,
					end : jsonTxt.end,
					allDay :  jsonTxt.allDay == "false" ? false : true,
					travelNo : jsonTxt.travelNo
					
				}, true );
			});
			
		},
		error:function(request,status,error){
			console.log("code:"+request.status+"message:"+request.responseText+"error:"+error);
			}
		});
}
var f = function(){
	console.log("들어옴2");
	var myCalendar = $('#myCalendar');
	myCalendar.fullCalendar({
		height: 1150,
		year: year,
		month: month-1,
		date: date,
		header : {
			center : 'title'
		},
		firstDay: day,
		editable : true,
		events :  loadCalendar(),
		eventClick: function( calEvent,data,view ){
			var r=confirm("Delete " + calEvent.title);
			if (r==true)
              {
                  $.ajax({
						url:'/railway999/api/travel/remove',
						dataType:'json',
						data:'travelNo='+calEvent.travelNo,
						contentType: "application/x-www-form-urlencoded; charset=UTF-8",
						type:"POST",
						success:function(){
							myCalendar.fullCalendar('removeEvents', function(event){
								return event==calEvent;
							});
						}
					});
              }
			
		},
		 eventDrop: function(events, delta, revertFunc) {
			
			 var formDate = $.fullCalendar.formatDate(events.start, 'yyyy-MM-dd');
			 var formTime = $.fullCalendar.formatDate(events.start, 'HH:mm:00');
		     var formEndDate = $.fullCalendar.formatDate(events.end, 'yyyy-MM-dd');
	         var formEndTime = $.fullCalendar.formatDate(events.end, 'HH:mm:00');
	         
	         var startmydate = formDate  + "T" + formTime;
	         var endmydate= formEndDate  + "T" + formEndTime;
						
			console.log("gggg"+endmydate);
			 if (confirm("Are you sure about this change?")) {
		            
				 console.log("ddd"+startmydate);
				 console.log("ddd"+endmydate);
	            
		            $.ajax({
						url:'/railway999/api/travel/modify',
						dataType:'json',
						data:({
							title: events.title,
							allDay: events.allDay == "false" ? false : true,
							start: startmydate,
							end: endmydate,
							travelNo: events.travelNo
						}),
						contentType: "application/json; charset=UTF-8",
						success:function(){
							myCalendar.empty();
							f();
						},
						error:function(request,status,error){
						console.log("code:"+request.status+"message:"+request.responseText+"error:"+error);
						}
					});
		   
			 }else{
				 revertFunc();
			     console.log('revert');
			 }
		    },
		    eventResize: function(events, delta, revertFunc) {
				
				 var formDate = $.fullCalendar.formatDate(events.start, 'yyyy-MM-dd');
				 var formTime = $.fullCalendar.formatDate(events.start, 'HH:mm:00');
			     var formEndDate = $.fullCalendar.formatDate(events.end, 'yyyy-MM-dd');
		         var formEndTime = $.fullCalendar.formatDate(events.end, 'HH:mm:00');
		         
		         var startmydate = formDate  + "T" + formTime;
		         var endmydate= formEndDate  + "T" + formEndTime;
							
				console.log("gggg"+endmydate);

				 if (confirm("Are you sure about this change?")) {
			            
					 console.log("ddd"+startmydate);
					 console.log("ddd"+endmydate);
		            
			            $.ajax({
							url:'/railway999/api/travel/modify',
							dataType:'json',
							data:({
								title: events.title,
								allDay: events.allDay == "false" ? false : true,
								start: startmydate,
								end: endmydate,
								travelNo: events.travelNo
							}),
							contentType: "application/json; charset=UTF-8",
							success:function(){
								myCalendar.empty();
								f();
							},
							error:function(request,status,error){
							console.log("code:"+request.status+"message:"+request.responseText+"error:"+error);
							}
						});
			   
				 }else{
					 revertFunc();
				     console.log('revert');
				 }
			    },
		selectable : true,
		select: function(start, end, allDay) {
			no=$("#memberNo").val();
		    var title = prompt('Event Title:');

		    if (title) {
		    	myCalendar.fullCalendar('renderEvent', {
					title : title,
					start : start,
					end : end,
					allDay : false 
				}, true // make the event "stick"
		        );
		         var formDate = $.fullCalendar.formatDate(start, 'yyyy-MM-dd');
		         var formTime = $.fullCalendar.formatDate(start, 'HH:mm:ss');
			     var formEndDate = $.fullCalendar.formatDate(end, 'yyyy-MM-dd');
		         var formEndTime = $.fullCalendar.formatDate(end, 'HH:mm:ss');
		         
		         var startmydate = formDate + "T" + formTime;
		         var endmydate= formEndDate + "T" + formEndTime;
		         		         
		    	$.ajax({
					url:'/railway999/api/travel/add',
					dataType:'json',
					data:"id="+no+"&title="+title+"&start="+startmydate+"&end="+endmydate+"&allDay="+allDay+"&year="+year+"&month="+month+"&date="+date+"&day="+day,
					contentType: "application/json; charset=UTF-8",
					success:function(){
						myCalendar.empty();
						f();
					},
					error:function(request,status,error){
					console.log("code:"+request.status+"message:"+request.responseText+"error:"+error);
					}
				});
		    }
		    myCalendar.fullCalendar('unselect');
		}
		
		
		
	});	
}

$(function(){
	no=$("#memberNo").val();
	console.log("no:"+no);
	$.ajax({
		url:'/railway999/api/travel/get',
		type:"get",
		dataType:'json',
		data:"no="+no,
		contentType: "application/json",
		success:function(data){		
			if (data.get == null) {
				var html = 	"<br><p>" + "검색 및 추가에서 나의 여행스케줄을 추가해주세요."+ "</p><br>"
				+ "<a href='/railway999/scheduleMain/search' class='btn btn-primary'>바로가기</a>";
				$("#error").append(html);

			}else{
				year = data.get.year,
				month = data.get.month,
				date = data.get.date,
				day = data.get.day,
				travelNo = data.get.travelNo; 
				f();
			}
				
		}
			
	});
	
$('#printbtn').click(function () {

				$('#printarea').printThis({
					debug: true
				});
			});
}); 

</script>
<title>Insert title here</title>
</head>
<body>
<!-- 상단네비게이션 import -->
<c:import url="/WEB-INF/views/include/header.jsp"></c:import>
<!-- 본문 시작 -->
<div class="container">

<!-- 페이지 이름 : 나의 여행스케줄 -->
<div class="row">
	<div class="col-lg-12">
		<div class="page-header" >
			<h2 id="forms">나의 여행스케줄</h2>
		</div>
	</div>
</div>
<!-- 시간표  -->
<c:choose>
	<c:when test="${not empty AuthMember }">
	<input type="hidden" id="memberNo" name="memberNo" value="${vo.no}">
	<div class="row">
	<div class="col-lg-12">		
		<div class="well bs-component">
		<button id ="printbtn" class ='btn pull-right'><img src="/railway999/assets/img/printer.png" style='width:40px;'></button>
			<form class="form-horizontal">
				<fieldset  style="background-color:white;">
					<div id="error" class="offset4">
					</div>
					<div id="printarea">
						<div id='myCalendar' style='margin: 1.5em 0; font-size: 13px'>
						</div>	
					</div>			
				</fieldset>
			</form>
		</div>
	</div>
	</div>
	</c:when>
	<c:otherwise>
		<h4 class='offset5'>로그인 후 이용해주세요.</h4> <br>
		<a href='#' class='btn btn-default offset5' data-toggle="modal" data-target="#modalLogin">로그인 하러가기</a>
	</c:otherwise>
</c:choose>

<!-- Footer import -->		
<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
</div>
</body>
</html>