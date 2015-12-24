var loadStayKeyword;

$(function() {
	var keyword="";
	$.get("http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode",{
				"serviceKey" : serviceKey,
				"numOfRows":17,
				"MobileOS" :  "ETC",
				"MobileApp" : "AppTesting"
							}, function(data) {
								var xml = data.responseText;
								
								$(xml).find("item").each(function() {

								var code = $(this).find("code").text();
								var name = $(this).find("name").text();
								var rnum = $(this).find("rnum").text();
								
								var option1 = $("<option>").addClass("name").val(code).html(name);
								
								$("#staycode").append(option1);
								});
							});
			
			
			loadStayKeyword =function loadStayKeyword(p){ 
				var stayNum = $("#staycode").val();
				keyword = $("#staykeyword").val();
				console.log("키워드:"+keyword);
				
				$.get("http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchKeyword",{
					"serviceKey" : serviceKey,
					"MobileOS" :  "ETC",
					"MobileApp" : "AppTesting",
					"pageNo":p,
					"arrange": "B",
					"contentTypeId": "32",
					"areaCode" : stayNum,
					"keyword": keyword
						},function(data) {
							var xml = data.responseText;
							console.log(xml);
							
							totalCount = $(xml).find("totalCount").text();
							pageCount = totalCount/($(xml).find("numOfRows").text());
							
							$(xml).find("item").each(function() {
							
							var addr1 = $(this).find("addr1").text();
							var title = $(this).find("title").text();
							var tel= $(this).find("tel").text();
	
							var html = 	"<tr class='active'>" +
							            "<td>"+title+"</td>" +
							            "<td>"+addr1+"</td>" +
							            "<td>"+tel+"</td>" +
										"<td><a href='#' class='btn btn-primary btn-xs' data-toggle='modal' data-target='#modalDate' >"+ "추가" + "</a></td></tr>";							
							$("#stayresult").append(html);
							
							});
						});
			}
			 
			 $(document).ready(function() {
					$("#staybtn").click(function keywordsearch(){		
						$("#stayresult").empty(); 
						 pageNo = 1;
						 loadStayKeyword(pageNo);
					});
				}).ready(function(){
					$("#scrollbox2").scroll(function(){
						var scrolloffset=40;
						if($( "#scrollbox2" ).scrollTop()>= $("#tabletarget2").height() - ($("#scrollbox2").height()+scrolloffset)){
							if(pageNo<pageCount){
								setTimeout(function(){
									pageNo++;
									loadStayKeyword(pageNo);
								},500);
							}
						}
					});
				});
			 
			 $(document).ready(function() {
					$("#stayresult").chainedTo("#staycode");
				}).ready(function(){
					$( "#scrollbox2").scroll(function(){
						var scrolloffset=40; 
						
						if($( "#scrollbox2" ).scrollTop()>= $("#tabletarget2").height() - ($("#scrollbox2").height()+scrolloffset)){
							if(pageNo < pageCount){
								setTimeout(function(){
										pageNo++;	
										if(keyword == ""){
											loadStayImage(pageNo);						
										}
										keyword == "";
								},500);
							}
						}
					});
				});	
		});

function stayEnter(e) {

	var key;
	if (window.event)
		key = window.event.keyCode; // IE
	else
		key = e.which; // firefox
	if (key == 13){
		$("#stayresult").empty();
		loadStayKeyword();
		return false;
	}
	else
		return true;
}
			
		
		var totalCount;
		var pageCount=0;
		var pageNo = 1;
		var isLoading=false;
		
		function loadStayImage(p){
			var stayNum=$("#staycode").val(); 
			
			if(isLoading){
				return false;
			}
			isLoading=true;	
			$.get("http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchStay",{
				"serviceKey" : serviceKey,
				"MobileOS" :  "ETC",
				"MobileApp" : "AppTesting",
				"arrange": "B",
				"pageNo":p,
				"contentTypeId": "32",
				"goodStay":"1",
				"areaCode" : stayNum
					},function(data) {
						var xml = data.responseText;
						console.log(xml);
						
						totalCount = $(xml).find("totalCount").text();
						pageCount = totalCount/($(xml).find("numOfRows").text());
						
						$(xml).find("item").each(function() {

						var addr1 = $(this).find("addr1").text();
						var title = $(this).find("title").text();
						var tel=$(this).find("tel").text();
						
						
						var html = 	"<tr id='staysearch' class='active'>" +
						            "<td>"+title+"</td>" +
						            "<td>"+addr1+"</td>" +
						            "<td>"+tel+"</td>" +
									"<td><a href='#' class='btn btn-primary btn-xs' data-toggle='modal' data-target='#modalDate' >"+ "추가" + "</a></td></tr>";							
						$("#stayresult").append(html);
						
						});
					}).always(function(){
						isLoading=false
					});	
		}
		
		
		function staychange(sel){
			 pageNo = 1;
			 loadStayImage(pageNo);
		}
