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
<link rel="stylesheet" href="/railway999/assets/css/bootstrap-datepicker.css">
<link rel="stylesheet" href="/railway999/assets/css/custom.min.css">
<link rel="stylesheet" href="/railway999/assets/css/jquery.timepicker.css">

<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="/railway999/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="/railway999/assets/js/custom.js"></script>
<script src="/railway999/assets/js/bootstrap-datepicker.js"></script>
<script src='/railway999/assets/js/jquery.chained.js'></script>
<script src='/railway999/assets/js/jquery.timepicker.min.js'></script>

<link rel='stylesheet' type='text/css' href='http://arshaw.com/js/fullcalendar-1.6.3/fullcalendar/fullcalendar.css' />
<script type='text/javascript' src='http://arshaw.com/js/fullcalendar-1.6.3/jquery/jquery-ui-1.10.3.custom.min.js'></script>
<script type='text/javascript' src='/railway999/assets/js/fullcalendar.js'></script>

<!-- 나의 js -->
<script src="/railway999/assets/js/getRail.js"></script>
<script src="/railway999/assets/js/getTour.js"></script>
<script src="/railway999/assets/js/getStay.js"></script>
<script src="/railway999/assets/js/getFood.js"></script>
<script src="/railway999/assets/js/unknownboot.js"></script>
<script src="/railway999/assets/js/categoryview.js"></script>
<script src="/railway999/assets/js/schedule.js"></script>

<!-- Ajax plugin -->
<script type="text/javascript" src="/railway999/plugins/xdomain/jquery.xdomainajax.js"></script>
<script type="text/javascript" src="/railway999/plugins/xml2json/jquery.xml2json.js"></script>
<script type="text/javascript" src="/railway999/plugins/tmpl/jquery.tmpl.min.js"></script>



</head>
<body>	
<!-- 상단네비게이션 import -->
<c:import url="/WEB-INF/views/include/header.jsp"></c:import>
<!-- 날짜 시간 팝업 -->
<div id="modalDate" class="modal fade"><div class="modal-dialog"><div class="modal-content">
	<!-- header -->
	<div class="modal-header">
	<!-- 닫기(x) 버튼 -->
		<button type="button" class="close" data-dismiss="modal">×</button>
		<!-- header title -->
		<h4 class="modal-title">날짜 및 시간 선택</h4>
	</div>
	<!-- body -->
	<form class="form-horizontal">
		<div class="modal-body">
			<div class="form-group"><label for="select" class="col-lg-2 control-label">날짜</label>
				<div class="col-lg-10"><input id="datepicker2" type="text" name="date" class="form-control" value=""></div>
			</div>
			<div class="form-group"><label for="select" class="col-lg-2 control-label">시작시간</label>
				<div class="col-lg-10"><input id="startTime" class="form-control time" type="text" value=""></input></div>
			</div>
			<div class="form-group"><label for="select" class="col-lg-2 control-label">종료시간</label>
				<div class="col-lg-10"><input id="endTime" class="form-control" type="text" value=""></input></div>
			</div>
		</div>
	</form>
	<!-- footer -->
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
		<button id="addbtn" type="button" class="btn btn-primary" data-dismiss="modal">추가</button>
	</div>
</div></div></div>

<!-- 본문 시작 -->
<div class="container">

<!-- 페이지 이름 : 여행 스케줄 검색 및 추가 -->
<div class="row">
	<div class="col-lg-12">
		<div class="page-header">
			<h2 id="forms">여행 스케줄 검색 및 추가</h2>
		</div>
	</div>
</div>
	<!-- Form-Left : 시간표 검색  -->
	
	<c:choose>
		<c:when test="${not empty AuthMember }">
		<div class="row">
	
	<!-- 시간표 : 날짜선택 -->
	<input type="hidden" id="memberNo" name="no" value="${vo.no}">
	<div class="col-lg-6">
		<div class="well bs-component">
			<form class="form-horizontal">
				<div class="form-group"><label for="select" class="col-lg-2 control-label">시작일</label>
					<div class="col-lg-10"><input id="datepicker3" type="text" name="date" class="form-control"/></div>
				</div>
			</form>		
		</div>
		<div class="well bs-component">
			<form class="form-horizontal">
				<fieldset  style="background-color:white;">
					<div id='calendar' style='margin: 3em 0; font-size: 13px'></div>
				</fieldset>
			</form>
		</div>
	</div>
	
	<!-- 시간표 : 카테고리선택  -->
	<div class="col-lg-6">
		<div class="well bs-component">
			<form class="form-horizontal">
				<fieldset>
					<div class="form-group"><label for="select" class="col-lg-2 control-label">카테고리</label>
						<div class="col-lg-10">
						<select class="form-control" id="select" onchange="change(this)">
							<option id="caterail" value="rail" selected="selected">열차</option>
							<option id="catetour" value="tour">관광지</option>
							<option id="catestay" value="inn">숙박</option>
							<option id="catefood" value="eat">음식점</option>
						</select>
						</div>
					</div>
				</fieldset>
			</form>
			<!-- 열차 검색 -->
			<form id="rail" class="form-horizontal">
				<fieldset>
					<div id="datehide" class="form-group"><label for="select" class="col-lg-2 control-label">날짜선택</label>
						<div class="col-lg-10" class="input-append">
							<input id="datepicker" type="text" name="date" class="form-control"/> 
						</div>
					</div>
					
				<div id="railhide" style="display:none">
					<div class="form-group"><label for="select" class="col-lg-2 control-label">출발지</label>
						<div class="col-lg-5">
							<select id="city1" name="city1" class="form-control" onchange="citychange(this)">
							<option value="" selected = "selected">시/도선택</option>
							</select>
						</div>
						<div class="col-lg-5">
							<select id="rail1" name="rail1" class="form-control" onchange="railchange(this)">
							<option value="" selected = "selected">선택</option>
							</select>
						</div>
					</div>
					<div class="form-group"><label for="select" class="col-lg-2 control-label">도착지</label>
						<div class="col-lg-5">
							<select id="city2" name="city2" class="form-control" onchange="citychange2(this)">
							<option value="" selected = "selected">시/도선택</option>
							</select>
						</div>
						<div class="col-lg-5">
							<select id="rail2" name="rail2" class="form-control" onchange="railchange(this)">
							<option value="" selected = "selected">선택</option>
							</select>
						</div>
					</div>
				</div>
					
				<!-- 열차 검색 결과 Table -->
				<div id="container">
				<div id="scrollbox4" class="form-group">
					<table id="railtable" class="table table-striped table-hover">
						<thead>
						<tr><th>출발시간</th><th>도착시간</th><th>열차정보</th><th></th></tr>
						</thead>
						<tbody id="railresult"></tbody>
						</table>
				<!-- pagination -->	
				</div>					
				</div>
				</fieldset>
			</form>

			<!-- 관광지 검색 -->
			<form id="tour" class="form-horizontal" style="display: none">
				<fieldset>
					<div class="form-group"><label for="select" class="col-lg-2 control-label">지역</label>
						<div class="col-lg-10">
							<select id="tourcode" class="form-control" onchange="tourchange(this)">
								<option value="" >지역선택</option>
							</select>
						</div>
					</div>
					<div class="form-group"><label for="select" class="col-lg-2 control-label">키워드</label>
						<div class="col-lg-10">
							<input id="keyword" class="form-control" type="text" placeholder="예) 전주한옥마을"  onKeyPress="return tourEnter(event)">
						</div>
					</div>
					<div class="form-group"><label for="select" class="col-lg-2 control-label"></label>
						<div class="col-lg-10">
							<input id="searchbtn" class="btn btn-default btn-block" type="button" VALUE="검색 " /><br>
						</div>
					</div>
				</fieldset>
				
				<!-- 관광지 검색 결과 Table -->
				<div id="container">
				<div id="scrollbox" class="form-group">
					<table id="tabletarget" class="table table-striped table-hover">
					<thead><tr><th>관광지명</th><th>주소</th><th></th></tr></thead>
					<tbody id="tourresult"></tbody>
					</table>
				</div>
				</div>
				</form>

				<!-- 숙박 검색 -->
				<form id="inn" class="form-horizontal" style="display: none">
				<fieldset>
					<div class="form-group"><label for="select" class="col-lg-2 control-label">지역</label>
						<div class="col-lg-10">
							<select id="staycode" class="form-control" onchange="staychange(this)">
							<option value="" >지역선택</option>			
							</select>
						</div>
					</div>
					<div class="form-group"><label for="select" class="col-lg-2 control-label">키워드</label>
						<div class="col-lg-10">
							<input id="staykeyword" class="form-control" type="text" placeholder="예) 쉼표게스트하우스" onKeyPress="return stayEnter(event)">
						</div>
					</div>
					<div class="form-group"><label for="select" class="col-lg-2 control-label"></label>
						<div class="col-lg-10">
							<input id="staybtn" class="btn btn-default btn-block" type="button" VALUE="검색 "><br>
						</div>
					</div>
				</fieldset>
				
				<!-- 숙박 검색 결과 Table -->
				<div id="container">
				<div id="scrollbox2" class="form-group">
					<table id="tabletarget2" class="table table-striped table-hover">
					<thead><tr><th>숙박명</th><th>주소</th><th>전화번호</th><th></th></tr></thead>
					<tbody id="stayresult"></tbody>
					</table>
				</div>
				</div>
				</form>

				<!-- 음식점 검색 -->
				<form id="eat" class="form-horizontal" style="display: none">
				<fieldset>
					<div class="form-group"><label for="select" class="col-lg-2 control-label">지역</label>
						<div class="col-lg-10">
							<select id="foodcode" class="form-control" onchange="foodchange(this)">
								<option value="" >지역선택</option>	
							</select>
						</div>
					</div>
					<div class="form-group"><label for="select" class="col-lg-2 control-label" >키워드</label>
						<div class="col-lg-10">
							<input id="foodkeyword" class="form-control" type="text" placeholder="예) 쉼표게스트하우스" onKeyPress="return foodEnter(event)" />
						</div>
					</div>
					<div class="form-group"><label for="select" class="col-lg-2 control-label"></label>
						<div class="col-lg-10">
							<input id="foodbtn" class="btn btn-default btn-block" type="button" VALUE="검색 "  ><br>
						</div>
					</div>
				</fieldset>
				
				<!-- 음식점 검색 결과 Table -->
				<div id="container">
				<div id="scrollbox3" class="form-group">
					<table id="tabletarget3" class="table table-striped table-hover">
					<thead><tr><th>음식점명</th><th>주소</th><th></th></tr></thead>
					<tbody id="foodresult"></tbody>
					</table>
				</div>
				</div>
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