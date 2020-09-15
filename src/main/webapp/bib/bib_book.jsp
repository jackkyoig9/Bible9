<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bible book</title>
<%@ include file="../include/header.jsp" %>
<style>
.select {
	padding: 4px 32px;
	margin: 4px 2px;
	cursor: pointer;
	font-weight: bold
}
input {
	width: 180px;
	padding: 4px 32px;
	margin: 4px 2px;
	font-weight: bold
}
</style>
<script defer>
$(function () {
	$("#btnApp").click(function(){
		location.href = "${path}/menu_serv/app.do";
	});
	// checkSelected();
	var tot_book = loadBibHeader(checkSelected());
	loadBibBody(checkSelected());
	$("#select_bib").change(function () {
		loadBibHeader(checkSelected());
		loadBibBody(checkSelected());
	});
	$("input[type='button']").click(function (e) {
		if (e.target.id=="ipt_old" || e.target.id=="ipt_new" || e.target.id > 67) {
			return;
		}
		// Set form
		var book_id = (e.target.id < 10) ? "0" + e.target.id : e.target.id;
		var bib = checkSelected() + book_id;
		var book = $("#" + e.target.id + "").val();
		var tot_jang = $("#jang" + e.target.id + "").val();
		$("#bib").val(bib);
		$("#book").val(book);
		$("#tot_jang").val(tot_jang);

		document.form1.action = "${path}/bib_serv/read_bib.do";
		document.form1.submit();
	});
	$(document).tooltip();
	$("#div_me").bind("click", function(){
		if($("#select_bib option").length < 4){
			var vhtml="";
			vhtml+="<option value=\"kNKRV_bib\">개역개정판</option>";
			vhtml+="<option value=\"eNIV2011_bib\">NIV</option>";
			$("#select_bib").append(vhtml);
		}
	});
	$("#div_you").bind("click", function(){
		if($("#select_bib option").length > 2){
			$("#select_bib option").each(function(key, val){
				if(key >= 2){
					//console.log("a>> "+$(this).val());
					//console.log("b>> "+$("#select_bib option").eq(key).val());
					$(this).remove();
				}
				//console.log(">> "+key);
			});
		}
	});
});
function checkSelected() {
	var ck = $("select option:selected").val();
	return ck;
}
function loadBibHeader(lang) {
	$.getJSON("../json/bib_header.json", function (data) {
		var items = [];
		var tot = [];
		// var items;
		$.each(data, function (idx, val) {
			//items.push(val);
			items[0] = val.testament;
			items[1] = val.testament_kr;
			//items[2] = val.total;
			var title = lang.substr(0, 1) == "e" ? items[0] : items[1];
			if (idx == 0) {
				tot[0] = val.total;
				$("#ipt_old").val(title);
				/* $("#ipt_old").text(title); */
			}
			else if (idx == 1) {
				tot[1] = val.total;
				$("#ipt_new").val(title);
				/* $("#ipt_new").text(title); */
			}
		});
		return tot;
	});
}
function loadBibBody(lang) {
	$.getJSON("../json/bib_body.json", function (data) {
		var items = [];
		// var ck = $("#ipt_old").val();
		var ck = "Old Testament";
		$.each(data, function (idx, val) {
			//items.push(val);
			// if (idx == 0) {
			items[0] = val.testament;
			items[1] = val.book;
			items[2] = val.book_kr;
			items[3] = val.tot_jang;
			
			var book = (lang.substr(0, 1) == 'e') ? items[1] : items[2];
			var tmpid = "jang" + (idx + 1);
			
			if (items[0] == "Old Testament") {
				$("input[id='" + (idx + 1) + "']").val(book);
				$("input[id='" + tmpid + "']").val(items[3]);
				// Set title
				$("input[id='" + (idx + 1) + "']").attr("title", "총 "+items[3]+"장");
			}
			else if (items[0] == "New Testament") {
				$("input[id='" + (idx + 1) + "']").val(book);
				$("input[id='" + tmpid + "']").val(items[3]);
				// Set title
				$("input[id='" + (idx + 1) + "']").attr("title", "총 "+items[3]+"장");
			}
			// }
		});
		// hiddenInput();
	});
}
// Set input[type = 'button'] from 67 to 78 to change type = 'hidden'
function hiddenInput() {
	for (var i = 67; i < 79; i++) {
		$("input[id='" + i + "'").attr("type", "hidden");
		$("input[id='" + i + "'").attr("disabled", "disabled");
	}
}
</script>
</head>

<body>
	<div class="container">
		<!-- include file="../include/session_check.jsp" -->
		<%@ include file="../include/app.jsp" %>
		<h2>성경</h2>
		<% /* 성경 추가
		How to add: 1. Add option, 2.webapp/json/ 폴더를 만들고 json파일을 넣음
		History: 190910 kNKRV(개역개정판)
		*/ %>
		버전 선택&nbsp;&nbsp;
		<select name="bib" id="select_bib" class="btn btn-info btn-lg">
			<option value="kHRV_bib" selected>개역한글판</option>
			<option value="eKJV_bib">KJV</option>
		</select>
		<br>
		<br>
		<table width="100%">
			<colgroup>
				<col width="50%">
				<col width="50%">
			</colgroup>
			<tr align="center">
				<th>
					<!-- <div id="ipt_old" class="btn btn-warning btn-block btn-lg" style="font-weight:bold"></div> -->
					<input id="ipt_old" class="btn btn-warning btn-block btn-lg" type="text" readonly />
					<!-- <input type="button" id="ipt_old"
						style="font-weight:bold; font-size: 120%; background-color: #f0ad4e;" disabled /> -->
				</th>
				<th>
					<!-- <div id="ipt_new" class="btn btn-warning btn-block btn-lg" style="font-weight:bold"></div> -->
					<input id="ipt_new" class="btn btn-warning btn-block btn-lg" type="text" readonly />
					<!-- <input type="button" id="ipt_new"
						style="font-weight:bold; font-size: 120%; background-color: #f0ad4e;" disabled /> -->
				</th>
			</tr>
			<c:forEach var="i" begin="1" end="39" step="1">
				<tr align="center">
					<td>
						<input class="btn btn-outline-info btn-block btn-lg" type="button" id="${i}" />
						<input class="btn btn-outline-info btn-block btn-lg" type="hidden" id='jang${i}' />
					</td>
					<td>
						<!-- 39-12 -->
						<c:if test="${i lt 28}">
							<input class="btn btn-outline-info btn-block btn-lg" type="button" id="${i+39}" />
							<input class="btn btn-outline-info btn-block btn-lg" type="hidden" id='jang${i+39}' />
						</c:if>
						<c:if test="${i eq 38}">
							<div id="div_me" style="color: #ffffff">.</div>
						</c:if>
						<c:if test="${i eq 39}">
							<div id="div_you" style="color: #ffffff">.</div>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
		<form method="post" name="form1">
			<input type="hidden" name="bib" id="bib">
			<input type="hidden" name="book" id="book">
			<input type="hidden" name="tot_jang" id="tot_jang">
		</form>
		<br>
		<div value="rkskek"></div>
		<input type="hidden" id="total_book">
		<br>
		${tot_book}
		<!-- End of container -->
	</div>
</body>

</html>