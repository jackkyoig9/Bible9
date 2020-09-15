<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bible9</title>
<%@ include file="../include/header.jsp" %>
<style type="text/css">
body {
	background-color: khaki;
}
a:focus {
  color: khaki;
}
a:hover {
  color: khaki;
  text-decoration: none;
}
.container{
/* 	height: 85vh; */
	height: 100vh;
	display: flex;
	flex-flow: column;
	align-items: center;
	justify-content: center;
	background: no-repeat center/58vh url(/images/cross_side.jpg) khaki;
/* 	background: no-repeat center/45vh url(/images/cross_rotate.png) #ffffff; */
	/* tranform: rotate(90deg); */
/*  background-image: url(/images/cross.png);  */
/*  background-repeat: no-repeat;  */
/* 	background-position: center;  */
/* 	background-color: #EAEAEA;  */
}
</style>
</head>
<body>
<div class="container">
	<div class="content">
		<h2>
			<a href="/menu_serv/bible9.do">성경 여행<br />(Bible Tour)</a>
		</h2>
		<div>
			<span><strong>번역 제공</strong></span>
		</div>
	</div>
</div>
</body>
</html>