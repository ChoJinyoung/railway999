$(document).ready(function() {	
	
	var TourDate,TourStartTime,TourEndTime;	
	var year,month,date,day;
	var year2,month2,date2,day2;
	var starthour,startmin,endhour,endmin,title,railtitle;	
	var dephour,depmin,arrhour,arrmin;
	var myCalendar = $('#calendar');
	var createCalendar = "";
	var no=$("#memberNo").val();
	
	//여행 날짜 선택 및 캘랜더 생성 (첫날 지정)
	$('#datepicker3').datepicker({
	    format: 'yyyymmddDD',
	    todayHighlight: true
	}).on('changeDate', function() {
		TourDate = $('#datepicker3').val();
		
		year = TourDate.slice(0,4);
		month = TourDate.slice(4,6);
		date = TourDate.slice(6,8);
		day = TourDate.substring(8);
		
		if(day=="Monday"){
			day=1;
		}else if(day=="Tuesday"){
			day=2;
		}else if(day=="Wednesday"){
			day=3;
		}else if(day=="Thursday"){
			day=4;
		}else if(day=="Friday"){
			day=5;
		}else if(day=="Saturday"){
			day=6;
		}else{
			day=0;
		}
		
		if($('#calendar').children() == ""){
			createCalendar = myCalendar.fullCalendar({
				height: 550,
				year: year,
				month: month-1,
				date: date,
				header : {
					center : 'title'
				},
				firstDay: day,
				editable : false,
				events : function( start, end ){

					$.ajax({
						url:'/railway999/api/travel/list',
						type:"get",
						data:"no="+no,
						dataType:'json',
						contentType: "application/x-www-form-urlencoded; charset=UTF-8",
						success:function(data,text,request){
							$.each( data.jsonTxt, function(index, jsonTxt) {
								myCalendar.fullCalendar('renderEvent', {
									id : jsonTxt.id,
									title : jsonTxt.title,
									start : jsonTxt.start,
									end : jsonTxt.end,
									allDay :  jsonTxt.allDay == "false" ? false : true,			
								}, true );
							}); 					
						},
						error:function(request,status,error){
						console.log("code:"+request.status+"message:"+request.responseText+"error:"+error);
						}
					});		
				},
			});
		}else{
			$('#calendar').children().remove();
			myCalendar
			createCalendar = myCalendar.fullCalendar({
				height: 550,
				year: year,
				month: month-1,
				date: date,
				header : {
					center : 'title'
					
				},
				
				firstDay: day,
				editable : false,
				color : 'yellow',
				events : function( start, end ){
					$.ajax({
						url:'/railway999/api/travel/list',
						type:"get",
						data:"no="+no,
						dataType:'json',
						contentType: "application/x-www-form-urlencoded; charset=UTF-8",
						success:function(data,text,request){
							$.each( data.jsonTxt, function(index, jsonTxt) {
								
								console.log(jsonTxt.title);
								console.log(jsonTxt.start);

								console.log(jsonTxt.id);
								
								myCalendar.fullCalendar('renderEvent', {
									id : jsonTxt.id,
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
				},
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
					
				}
			});
		}
	});
		
	$(document).on( "click", "#tourresult tr", function() {		 
		title = $(this).find("td").eq(0).text();
	});
	$(document).on( "click", "#stayresult tr", function() {		 
		title = $(this).find("td").eq(0).text();
	});
	$(document).on( "click", "#foodresult tr", function() {		 
		title = $(this).find("td").eq(0).text();
	});
	
	$(document).on( "click", "#railresult tr", function() {		 
		railtitle = $(this).find("td").eq(2).text();
		console.log("railtitle:"+railtitle);
	});
	
	$('#startTime').timepicker({ timeFormat: "H:i" }).on('change',function(){
		TourStartTime = $(".ui-timepicker-selected").text();
		console.log(TourStartTime);		
	});
	
	$('#endTime').timepicker({ timeFormat: "H:i" }).on('change',function(){
		TourEndTime = $(".ui-timepicker-selected").text();
		console.log(TourEndTime);
		
		starthour = TourEndTime.slice(0,2);
		startmin = TourEndTime.slice(3,5);
		endhour = TourEndTime.slice(5,7);
		endmin = TourEndTime.slice(8,10);	

	});	
	
	
	$('#datepicker2').datepicker({
	    format: 'yyyymmddDD',
	    todayHighlight: true
	}).on('changeDate', function(e) {
		TourDate = $('#datepicker2').val();
		
		year2 = TourDate.slice(0,4);
		month2 = TourDate.slice(4,6);
		date2 = TourDate.slice(6,8);
		day2 = TourDate.substring(8);
		
		if(day2=="Monday"){
			day2=1;
		}else if(day2=="Tuesday"){
			day2=2;
		}else if(day2=="Wednesday"){
			day2=3;
		}else if(day2=="Thursday"){
			day2=4;
		}else if(day2=="Friday"){
			day2=5;
		}else if(day2=="Saturday"){
			day2=6;
		}else{
			day2=0;
		}
	});
		
	$(document).on("click", "#addbtn", function() {
		var startmydate = year2+"-"+month2+"-"+date2+"T"+starthour+":"+startmin+":00";
		var endmydate = year2+"-"+month2+"-"+date2+"T"+endhour+":"+endmin+":00";
		var allDay = false; 

		$.ajax({
			url:'/railway999/api/travel/add',
			dataType:'json',
			data:"id="+no+"&title="+title+"&start="+startmydate+"&end="+endmydate+"&allDay="+allDay+"&year="+year+"&month="+month+"&date="+date+"&day="+day,
			contentType: "application/json; charset=UTF-8",
			success:function(){
			},
			error:function(request,status,error){
			console.log("code:"+request.status+"message:"+request.responseText+"error:"+error);
			}
		});
		
		myCalendar.fullCalendar('renderEvent', {
			title : title,
			start : startmydate,
			end : endmydate,
			allDay : false 
		}, true /* make the event "stick" */ );
				
		});
	
	$('#datepicker').datepicker({
	       format: 'yyyymmdd',
	       todayHighlight: true
	}).on('changeDate', function(e) {
		depPlandTime = $('#datepicker').val();
		
		year2 = depPlandTime.slice(0,4);
		month2 = depPlandTime.slice(4,6);
		date2 = depPlandTime.slice(6,8);

	});
	
	

	
$(document).on("click", "#railresult tr", function() {
		var allDay = false; 
		var smydate = $(this).find("td").eq(0).text();
		dephour= smydate.substr(0,2);
		depmin= smydate.substr(5,8);
		
		var emydate = $(this).find("td").eq(1).text();
		arrhour= emydate.substr(0,2);
		arrmin= emydate.substr(5,8);

		
		var startmydate = year2+"-"+month2+"-"+date2+"T"+dephour+":"+depmin+":00";
		var endmydate = year2+"-"+month2+"-"+date2+"T"+arrhour+":"+arrmin+":00";
		
		$.ajax({
			url:'/railway999/api/travel/add',
			dataType:'json',
			data:"id="+no+"&title="+railtitle+"&start="+startmydate+"&end="+endmydate+"&allDay="+allDay+"&year="+year+"&month="+month+"&date="+date+"&day="+day,
			contentType: "application/json; charset=UTF-8",
			success:function(){},
			error:function(request,status,error){
			console.log("code:"+request.status+"message:"+request.responseText+"error:"+error);
			}
		});
		
		myCalendar.fullCalendar('renderEvent', {
			title : railtitle,
			start : startmydate,
			end : endmydate,
			allDay : false
		}, true /* make the event "stick" */ );
	});

});