var loadTourKeyword;

$(function() {	
	var keyword = "";	
	$.get("http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode",{
				"serviceKey" : serviceKey,
				"numOfRows" : 17,
				"MobileOS" :  "ETC",
				"MobileApp" : "AppTesting"
					}, function(data) {
						var xml = data.responseText;					
						$(xml).find("item").each(function() {
						var code = $(this).find("code").text();
						var name = $(this).find("name").text();
						var rnum = $(this).find("rnum").text();						
						var option1 = $("<option>").addClass("name").val(code).html(name);						
						$("#tourcode").append(option1);
						});
					});
	
	loadTourKeyword=function loadTourKeyword(p){		
		var tourNum = $("#tourcode").val();
		keyword = $("#keyword").val();
		console.log("키워드:"+keyword);		
		$.get("http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchKeyword",{
			"serviceKey" : serviceKey,
			"MobileOS" :  "ETC",
			"MobileApp" : "AppTesting",
			"pageNo" : p,
			"arrange": "B",
			"contentTypeId": "12",
			"areaCode" : tourNum,
			"keyword": keyword
				},function(data) {
					var xml = data.responseText;
					$(xml).find("item").each(function() {
					totalCount = $(xml).find("totalCount").text();
					pageCount = totalCount/($(xml).find("numOfRows").text());
					
					var addr1 = $(this).find("addr1").text();
					var title = $(this).find("title").text();
					var html = 	"<tr class='active'>" +
					            "<td>"+title+"</td>" +
					            "<td>"+addr1+"</td>" +
								"<td><a href='#' class='btn btn-primary btn-xs' data-toggle='modal' data-target='#modalDate' >"+ "추가" + "</a></td></tr>";							
					$("#tourresult").append(html);					
					});
				});	
	}	
	$(document).ready(function() {
		$("#searchbtn").click(function keywordsearch(){		
			$("#tourresult").empty(); 
			 pageNo = 1;
		     loadTourKeyword(pageNo);
		});
	}).ready(function(){
		$("#scrollbox").scroll(function(){
			var scrolloffset=40;
			if($( "#scrollbox" ).scrollTop()>= $("#tabletarget").height() - ($("#scrollbox").height()+scrolloffset)){
				if(pageNo<pageCount){
					setTimeout(function(){
						pageNo++;
						loadTourKeyword(pageNo);
					},500);
				}
			}
		});
	});
	
	$(document).ready(function() {
		$("#tourresult").chainedTo("#tourcode");
	}).ready(function(){
		$( "#scrollbox" ).scroll(function(){
			var scrolloffset=40; 

			if($( "#scrollbox" ).scrollTop()>= $("#tabletarget").height() - ($("#scrollbox").height()+scrolloffset)){
				if(pageNo < pageCount){
					setTimeout(function(){
							pageNo++;	
							if(keyword == ""){
								loadTourImage(pageNo);						
							}
							keyword == "";
					},500);
				}
			}
		});
	});		
});

function tourEnter(e) {

	var key;
	if (window.event)
		key = window.event.keyCode; // IE
	else
		key = e.which; // firefox
	if (key == 13){
		$("#tourresult").empty();
		loadTourKeyword();
		return false;
	}
	else
		return true;
}

var totalCount;
var pageCount=0;
var pageNo = 1;
var isLoading=false;

function loadTourImage(p){
	var tourNum=$("#tourcode").val(); 	
	if(isLoading){
		return false;
	}
	isLoading=true;	
	$.get("http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList",{
		"serviceKey" : serviceKey,
		"MobileOS" :  "ETC",
		"MobileApp" : "AppTesting",
		"pageNo" : p,
		"arrange": "B",
		"contentTypeId": "12",
		"areaCode" : tourNum
			},function(data) {
				var xml = data.responseText;

				totalCount = $(xml).find("totalCount").text();
				pageCount = totalCount/($(xml).find("numOfRows").text());
				
				$(xml).find("item").each(function() {
				var addr1 = $(this).find("addr1").text();
				var title = $(this).find("title").text();
				var html = 	"<tr id='codesearch' class='active'>" +
				            "<td>"+title+"</td>" +
				            "<td>"+addr1+"</td>" +
							"<td><a href='#' class='btn btn-primary btn-xs' data-toggle='modal' data-target='#modalDate' >"+ "추가" + "</a></td></tr>";							
				$("#tourresult").append(html);
				});		
			}).always(function(){
				isLoading=false;
			});	
}
function tourchange(sel){
	 pageNo = 1;
     loadTourImage(pageNo);
}