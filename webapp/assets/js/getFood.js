
var loadFoodKeyword;

$(function() {
	var keyword="";
	$.get("http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode",{
				//파라미터 세팅 , 현재는 키 값만 존재
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
						
						$("#foodcode").append(option1);
						});
					});
	
	
	loadFoodKeyword=function loadFoodKeyword(p){		
		var foodNum = $("#foodcode").val();
		keyword = $("#foodkeyword").val();
		console.log("키워드:"+keyword);
		
		$.get("http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchKeyword",{
			"serviceKey" : serviceKey,
			"MobileOS" :  "ETC",
			"MobileApp" : "AppTesting",
			"pageNo" : p,
			"arrange": "B",
			"contentTypeId": "39",
			"areaCode" : foodNum,
			"keyword": keyword
				},function(data) {
					var xml = data.responseText;
					totalCount = $(xml).find("totalCount").text();
					pageCount = totalCount/($(xml).find("numOfRows").text());
					
					$(xml).find("item").each(function() {

					var addr1 = $(this).find("addr1").text();
					var addr2 = $(this).find("addr2").text();
					var title = $(this).find("title").text();
					
					var html = 	"<tr class='active'>" +
					            "<td>"+title+"</td>" +
					            "<td>"+addr1+addr2+"</td>" +
								"<td><a href='#' class='btn btn-primary btn-xs' data-toggle='modal' data-target='#modalDate' >"+ "추가" + "</a></td></tr>";							
					$("#foodresult").append(html);
					
					});
				});
		}
	
	
	
	
	 $(document).ready(function() {
			$("#foodbtn").click(function keywordsearch(){		
				$("#foodresult").empty(); 
				 pageNo = 1;
			     loadFoodKeyword(pageNo);
			});
		}).ready(function(){
			$("#scrollbox3").scroll(function(){
				var scrolloffset=40;
				if($( "#scrollbox3" ).scrollTop()>= $("#tabletarget3").height() - ($("#scrollbox3").height()+scrolloffset)){
					if(pageNo<pageCount){
						setTimeout(function(){
							pageNo++;
							loadFoodKeyword(pageNo);
						},500);
					}
				}
			});
		});
	 
	 $(document).ready(function() {
			$("#foodresult").chainedTo("#foodcode");
	}).ready(function(){
		$( "#scrollbox3" ).scroll(function(){
			var scrolloffset=40; 
			if($( "#scrollbox3").scrollTop()>= $("#tabletarget3").height() - ($("#scrollbox3").height()+scrolloffset)){
				if(pageNo < pageCount){
					setTimeout(function(){
							pageNo++;	
							if(keyword == ""){
								loadFoodImage(pageNo);						
							}
							keyword == "";
					},500);
				}
			}
		});
	});
});

function foodEnter(e) {

	var key;
	if (window.event)
		key = window.event.keyCode; // IE
	else
		key = e.which; // firefox
	if (key == 13){
		$("#foodresult").empty();
		loadFoodKeyword();
		return false;
	}
	else
		return true;
}

var totalCount;
var pageCount=0;
var pageNo = 1;
var isLoading=false;
	
function loadFoodImage(p){
	var foodNum=$("#foodcode").val(); 
	if(isLoading){
		return false;
	}
	
	$.get("http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList",{
		"serviceKey" : serviceKey,
		"MobileOS" :  "ETC",
		"MobileApp" : "AppTesting",
		"pageNo" : p,
		"arrange": "B",
		"contentTypeId": "39",
		"areaCode" : foodNum
		},function(data) {
			var xml = data.responseText;
			totalCount = $(xml).find("totalCount").text();
			pageCount = totalCount/($(xml).find("numOfRows").text());
		
		$(xml).find("item").each(function() {
			var addr1 = $(this).find("addr1").text();
			var addr2 = $(this).find("addr2").text();
			var title = $(this).find("title").text();
			var firstimage2=$(this).find("firstimage2").text();
			
			var html = 	"<tr id='codesearch' class='active'>" +
			            "<td>"+title+"</td>" +
			            "<td>"+addr1+addr2+"</td>" +
						"<td><a href='#' class='btn btn-primary btn-xs' data-toggle='modal' data-target='#modalDate' >"+ "추가" + "</a></td></tr>";							
			$("#foodresult").append(html);
			
			});
		}).always(function(){
			isLoading=false;
		});	
}
function foodchange(sel){
	 pageNo = 1;
	 loadFoodImage(pageNo);
}