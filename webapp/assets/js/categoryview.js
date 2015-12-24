//카테고리(열차/관광지/숙박/음식점)선택 view
function change(sel) {

	var IdNum1 = sel.options[sel.selectedIndex].value;
	

	if (IdNum1 == "rail") {
		document.all["rail"].style.display = "";
		document.all["tour"].style.display = "none";
		document.all["inn"].style.display = "none";
		document.all["eat"].style.display = "none";
		
	}
	if (IdNum1 == "tour") {
		document.all["rail"].style.display = "none";
		document.all["tour"].style.display = "";
		document.all["inn"].style.display = "none";
		document.all["eat"].style.display = "none";


	}
	if (IdNum1 == "inn") {
		document.all["rail"].style.display = "none";
		document.all["tour"].style.display = "none";
		document.all["inn"].style.display = "";
		document.all["eat"].style.display = "none";

		
	}
	if (IdNum1 == "eat") {
		document.all["rail"].style.display = "none";
		document.all["tour"].style.display = "none";
		document.all["inn"].style.display = "none";
		document.all["eat"].style.display = "";

	}
}