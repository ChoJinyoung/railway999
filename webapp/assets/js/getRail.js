


$(document).ready(function() {
	$('#datehide').click(function(){
		var state=$("#railhide").css("display");
		if(state=="none"){
			$("#railhide").show();
		}
	});
});


var serviceKey = "Y/+8QM9fybwGiks8s1VgspVQNert5/G4DhQhS0LvXzCuOmCpubrUUs+R5OoOE4UwSbgAwOUrRxXMzbYnuPP7Jw==";
var depPlandTime;

function citychange(sel) {
	var IdNum1 = sel.options[sel.selectedIndex].value;
	
	console.log(IdNum1);
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
			});		
}
function citychange2(sel) {
var IdNum2 = sel.options[sel.selectedIndex].value;

console.log(IdNum2);
$.get("http://openapi.tago.go.kr/openapi/service/TrainInfoService/getCtyAcctoTrainSttnList",{
	"cityCode" : IdNum2,
	"serviceKey" : serviceKey
		},function(data) {
			var xml = data.responseText;
			console.log(xml);
			
			$(xml).find("item").each(function() {

			var nodeid = $(this).find("nodeid").text();
			var nodename = $(this).find("nodename").text();
			
			var option2 = $("<option>").addClass(IdNum2).val(nodeid).html(nodename);
			$("#rail2").append(option2);
			});
		});	
}	

$(function() {
	
	$.get("http://openapi.tago.go.kr/openapi/service/TrainInfoService/getCtyCodeList",{
		
				//파라미터 세팅 , 현재는 키 값만 존재
				"serviceKey" : serviceKey
					}, function(data) {
						var xml = data.responseText;
						
						$(xml).find("item").each(function() {

						var cityname = $(this).find("cityname").text();
						var citycode = $(this).find("citycode").text();
						var cityname2 = $(this).find("cityname").text();
						var citycode2 = $(this).find("citycode").text();
						
						var option1 = $("<option>").addClass("cityname").val(citycode).html(cityname);
						var option2 = $("<option>").addClass("cityname").val(citycode2).html(cityname2);
						$("#city1").append(option1);
						$("#city2").append(option2);
						});
					});
	$(document).ready(function() {
		$("#rail1").chainedTo("#city1");
		$("#rail2").chainedTo("#city2");
		$("#railtable").chainedTo("#rail1");
		$("#railtable").chainedTo("#rail2");
	}).ready(function(){
		$( "#scrollbox4" ).scroll(function(){
			var scrolloffset=40; 

			if($( "#scrollbox4" ).scrollTop()>= $("#railtable").height() - ($("#scrollbox4").height()+scrolloffset)){
				if(pageNo < pageCount){
					setTimeout(function(){
							pageNo++;	
							loadRailImage(pageNo);						
					},500);
				}
			}
		});
	});
});



var totalCount;
var pageCount=0;
var pageNo = 1;
var isLoading=false;

function loadRailImage(p) {
	var nodeNum1 = $("#rail1").val(); 
	var nodeNum2 = $("#rail2").val(); 
	var railListNo=0;
	
	if(isLoading){
		return false;
	}
	isLoading=true;
	
	$.get("http://openapi.tago.go.kr/openapi/service/TrainInfoService/getStrtpntAlocFndTrainInfo",{
		"depPlandTime": depPlandTime,
		"depPlaceId" : nodeNum1,
		"arrPlaceId" : nodeNum2,
		"pageNo" : p,
		"serviceKey" : serviceKey
			},function(data) {
				var xml = data.responseText;
				
				totalCount = $(xml).find("totalCount").text();
				pageCount = totalCount/($(xml).find("numOfRows").text());
				
				$(xml).find("item").each(function() {

				var depPlandTime = $(this).find("depPlandTime").text();
				var arrPlandTime = $(this).find("arrPlandTime").text();
				var trainGradeName = $(this).find("trainGradeName").text();
				
				
				var trainName;
				if(trainGradeName=="00"){
					trainName="KTX";
				}else if(trainGradeName=="01"){
					trainName="새마을호";
				}else if(trainGradeName=="02"){
					trainName="무궁화호";
				}else if(trainGradeName=="03"){
					trainName="통근열차";
				}else if(trainGradeName=="04"){
					trainName="누리로";
				}else if(trainGradeName=="06"){
					trainName="공항철도(직행)";
				}else if(trainGradeName=="07"){
					trainName="KTX-산천";
				}else if(trainGradeName=="08"){
					trainName="ITX-새마을";
				}else if(trainGradeName=="09"){
					trainName="ITX-청춘";
				}
				
				var dephour= depPlandTime.substr(8,2);
				var depmin= depPlandTime.substr(10,2);
				var arrhour= arrPlandTime.substr(8,2);
				var arrmin= arrPlandTime.substr(10,2);
				
				var html = 	"<tr class='active'>" +
				            "<td>"+ dephour + " : " + depmin +"</td>" +
				            "<td>"+ arrhour + " : " + arrmin +"</td>" +
				            "<td>"+ trainName + "</td>" + "<td></td>" +
				            "<td><a href='#' class='btn btn-primary btn-xs' >"+ "추가" + "</a></td></tr>";
							/*"<td><button class='btn btn-primary btn-xs'>" + "추가" + "</button></td></tr>";*/	
				
				$("#railresult").append(html);
				});
			}).always(function(){
				isLoading=false;
			});	
}

function railchange(sel){
	pageNo=1;
	loadRailImage(pageNo);
}


