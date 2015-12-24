$(document).ready(function() {
	$("#tourresult").chainedTo("#tourcode")
});	
	
$(function() {
	
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
						
						$("#tourcode").append(option1);
						});
					});
	
	
	$("#searchbtn").click(function keywordsearch(sel){
		
		$("#tourresult").empty(); 
		
		var tourNum = $("#tourcode").val();
		var keyword = $("#keyword").val();
		console.log("키워드:"+keyword);
		
		$.get("http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchKeyword",{
			"serviceKey" : serviceKey,
			"MobileOS" :  "ETC",
			"MobileApp" : "AppTesting",
			"arrange": "B",
			"contentTypeId": "12",
			"areaCode" : tourNum,
			"keyword": keyword
				},function(data) {
					var xml = data.responseText;
					console.log(xml);
					
					$(xml).find("item").each(function() {

					var addr1 = $(this).find("addr1").text();
					var title = $(this).find("title").text();
					
					
					
					var html = 	"<tr class='active'>" +
					            "<td>"+title+"</td>" +
					            "<td>"+addr1+"</td>" +
								"<td><a href='#' class='btn btn-primary btn-xs' data-toggle='modal' data-target='#modalDate' >"+ "추가" + "</a></td></tr>";							
					$("#tourresult").append(html);
					
					});
				});
	});
});

function tourchange(sel){
	
	var tourNum=$("#tourcode").val(); 	
	
	var totalCount;
	var pageCount=0;
	var pageNo = 1;
	var isLoading=false;
	
	function loadImage(p){
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
					console.log(xml);
					
					//전체 페이지 수
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

	
	/*$(function(){
		
		$( "#scrollbox" ).scroll(function(){
			
			if($( "#scrollbox" ).scrollTop()== $("#target").height() - $("#scrollbox").height()){
				if(pageNo < pageCount){
					setTimeout(function(){
						pageNo++;
						
						loadImage(pageNo);
					},1000);
				}
			}
			
		});
		
	});*/
	
	$(document).ready(function(){
		scrolla();
	});
	
	function scrolla(){
		
		if(pageCount==0){
			
			loadImage(pageNo);
			
			if($('#tourresult').children() != ""){
			
			var scrolltop=$('#scrollbox').prop('scrollTop');
			var scrollheight= $('#tabletarget').height();
			var windowheight=$('#scrollbox').prop('clientHeight');
			
			console.log("scrolltop:"+scrolltop);
			console.log("scrollheight:"+scrollheight);
			console.log("windowheight:"+windowheight);
			console.log(pageCount);
			console.log(pageNo);
			}
		}
		
		/*var scrolltop=$('#scrollbox').prop('scrollTop');
		var scrollheight=$('#scrollbox').height();
		var windowheight=$('#scrollbox').prop('clientHeight');*/
		
		var scrolloffset=20;
		if(scrolltop >= (scrollheight-(windowheight+scrolloffset)))
		{
			/*console.log(scrolltop);
			console.log(scrollheight);
			console.log(windowheight);
			console.log(pageCount);
			console.log(pageNo);*/
			
			loadImage(pageNo);
			//fetch new items
			if(pageNo < pageCount){
				setTimeout(function(){
					pageNo++;
					loadImage(pageNo);
				},1500);
			}
		}
	}
}