$(function(){
	var query = $(".btn-more").data("query");
	var params = new URLSearchParams(location.search);
	var size = params.get("size");
	var dataCount = $(".btn-more").data("count");
	$(".no-data").hide();
	if(size >= dataCount){
		$(".btn-more").hide().prop("disabled", true);
		$(".no-data").show();
		}
	
	$(".btn-more").on("click", function(){
		window.location.search = query;
	});
});