<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Menu</title>
<%@ include file="/include/header.jsp" %>
<style type="text/css">
#div_bib{
	width: 100%;
	display: flex;
	margin-bottom: 1rem;
}
#div_bib_left{
	width: 50%;
/* 	border: 5px solid tomato; */
	display: flex;
	align-items: center;
	justify-content: center;
	margin-right: 0.5rem;
}
#div_bib_right{
	width: 50%;
}
</style>
<script>
$(function(){
	$("#bible9").bind("click", function(){
		location.href = "${path}/menu_serv/index.do";
	});
	$("#loadsplayer").bind("click", function(){
		location.href = "${path}/menu_serv/loadsplayer.do";
	});
	$("#apostlescreed").bind("click", function(){
		location.href = "${path}/menu_serv/apostlescreed.do";
	});
	$("#div_bib_left").bind("click", function(){
		location.href = "${path}/menu_serv/bib_book.do";
	});
});
</script>
</head>
<body>
<div class="container">
	<div id="bible9" class="alert alert-info btn-block"><h4>Bible Tour</h4></div>
	<div id="div_bib">
		<div id="div_bib_left" class="btn btn-outline-info btn-lg btn-block">
			<div id="bib">성경[Bible]]</div>
		</div>
		<div id="div_bib_right">
			<div id="loadsplayer" class="btn btn-outline-info btn-lg btn-block">사도신경</div>
			<div id="apostlescreed" class="btn btn-outline-info btn-lg btn-block">주기도문</div>
		</div>
	</div>
	<div class="btn btn-outline-warning btn-sm btn-block">&nbsp;</div>
	<div class="btn btn-outline-warning btn-sm btn-block">&nbsp;</div>
	<div class="btn btn-outline-warning btn-sm btn-block">&nbsp;</div>
	<div class="alert alert-warning btn-block"><h4>Bible Tour</h4></div>
	<br>
</div>
</body>
</html>