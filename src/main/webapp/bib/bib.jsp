<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bib</title>
<%@ include file="../include/header.jsp" %>
<style>
/* .btn-sm{
	width: "9%";
	font-size: "14px";
} */
/* .btn_top_bar,#btnAdjustFontMinus,#btnAdjustFontPlus,#btnBefore,#btnNext{ */
#btn_top_bar,#btnAdjustFontMinus,#btnAdjustFontPlus,#menu_trans,#btnViewLinkJeul{
	/* overflow: hidden; */
	position: fixed;
	z-index: 2;
	bottom: 0;
	height: 30px;
	line-height: 180%;
	background: #aaaaaaaa;
	padding: 0;
	border: 1px solid #ffffff;
	border-radius: 5px 5px 5px 5px;
	display: block;
	text-align: center;
	font-size: 17px;
	font-weight: bold;
}
a:hover{
	text-decoration: none;
}
#btn_top_bar{
	left: 0%;
	width: 30%;
}
#btnAdjustFontPlus{
	right: 0%;
	width: 10%;
}
#btnAdjustFontMinus{
	right: 10%;
	width: 10%;
}
#menu_trans{
	right: 20%;
	width: 15%;
	color: green;
}
#btnViewLinkJeul{
	left: 30%;
	width: 35%;
	color: purple;
}
#div_alert{
	padding-top: 5px;
	border:3px solid;
	border-radius: 10px;
	position:fixed;
	/* top:40%; */
	/* left:30%; */
	width: 200px;
	height:65px;
	z-index:7;
	background-color: white;
	/* background: #aaaaaa; */
	text-align: center;
	font-weight: bold;
}
</style>
<script defer>
//$(document).ready(function(){
$(function(){
	$("#div_alert").css("left",(document.documentElement.clientWidth/2)-(parseInt($("#div_alert").css("width"))/2));
	$("#div_alert").css("top",(document.documentElement.clientHeight/2)-(parseInt($("#div_alert").css("height"))/2));
	<%/* 성경 이동 */%>
	$("#btnBib").bind("click", function(){
		location.href = "${path}/bib_serv/bib_book.do";
	});
	
	var jang="${jang}";
	var jeul="${jang}"; // Init jeul from jang
	var bib_book="${bib_book}";
	var tot_jang="${tot_jang}";
	//console.log(">> "+bib_book+", "+jang+", "+tot_jang);
	<%-- 
	<%/* 장버튼을 jquery script에서 만들기 */%>
	var vhtml="<table width=\"100%\">";
	<c:forEach var="i" begin="1" end="${tot_jang}" varStatus="status">
		if("${i}"%10==1){
			vhtml+="<tr>";
		}
		vhtml+="<td>";
		vhtml+="<input id=\"jang_${i}\" name=\"jang\" type=\"button\" class=\"btn btn-outline-secondary btn-sm btn-block\" style=\"font-size: 10px;\" title=\"${i}장\" value=\"${i}\" />";
		vhtml+="</td>";
		if("${i}">0 && "${i}"/10==0){
			vhtml+="</tr>";
		}
	</c:forEach>
	vhtml+="</table>";
	$("#div_jang2").html(vhtml); 
	--%>
	
	<%/* 처음 시작시 번역 숨김 */%>
	$("#div_trans_menu").hide();
	
	<%/* 처음 시작시 장 숨김: Start - .hide() 밑으로는 아래에서 처리하는 부분과 같으나 function으로 그냥 빼면 안되고 아마도 파라미터로 변수를 넘겨 처리해야하는 듯함 */%>
	$("#div_jang").hide();
	//fn_hideDivJang();
	$("#btnViewJang").val("장 보이기");
	if($("#curr_jang").val()!=1){
		$("#btnJangBefore").attr("disabled", false);
	}
	if($("#curr_jang").val()!=tot_jang){
		$("#btnJangNext").attr("disabled", false);
	}
	$("#btnJangBefore").removeClass("btn btn-outline-secondary btn-sm");
	$("#btnJangBefore").addClass("btn btn-outline-info btn-sm");
	$("#btnJangNext").removeClass("btn btn-outline-secondary btn-sm");
	$("#btnJangNext").addClass("btn btn-outline-info btn-sm");
	<%/* 처음 시작시 장 숨김: end */%>
	
	$("#curr_jang").val(jang); <%/* 장 저장 */%>
	
	<%/* 이전장, 다음장 설정: start */%>
	if($("#curr_jang").val()==1){
		$("#btnJangBefore").attr("disabled", true);
	}
	else if($("#curr_jang").val()==tot_jang){
		$("#btnJangNext").attr("disabled", true);
	}
	<%/* 이전장, 다음장 설정: end */%>
	
	fn_loadBook(bib_book, $("#curr_jang").val(), tot_jang, $("#viewLink").val(), 0);
	<%/* 장 버튼 */%>
	$("input[name='jang']").bind("click", function(e){
		$("#jang_head").text(e.target.value+"장").stop().fadeIn(30).fadeOut(3000); <%/* 선택한 장 잠시 보여주기 */%>
		if($("#btnAdd").is(":hidden")){
			$("#btnAdd").show();
		}
		<%/* 번역 보기 숨겼다면 다시 보여줌 */%>
		fn_btnViewTrans();
		/* if($("#viewLink").val()==0){
			console.log("..>> "+$("#btnViewTransBelow").attr("disabled"));
			if($("#btnViewTransBelow").prop("disabled")==true){
				$("#btnViewTransBelow").attr("disabled", false);
			}
			if($("#btnViewTransBeside").prop("disabled")==true){
				$("#btnViewTransBeside").attr("disabled", false);
			}
		} */
		$("#curr_jang").val(e.target.value);
		fn_loadBook(bib_book, e.target.value, tot_jang, $("#viewLink").val(), 0);
		if($("#curr_jang").val()==tot_jang){
			$("#btnAdd").hide();
		}
		$("#viewAdd").val(0);
	});
	<%/* 장 버튼에 마우스 올릴 시 잠시 장번호 보여줌 */%>
// 	$("input[name='jang']").bind({
// 		"mouseover": function(e){
// 			$("#jang_head").text(e.target.value+"장").stop().fadeIn(30).fadeOut(3000);
// 		},
// 		"mouseout": function(e){
// 			//$("#jang_head").text("");
// 		}
// 	});
	/* $("input[name='jang']").bind("mouseout", function(e){
		$("#jang_head").text("");
	}); */
	/* $("#tbl_contents").on("click", function(e){
		console.log("tbl_contents>> ");
		$("#tbl_contents tbody tr").each(function(index, tr){
			console.log(tr);
		});
	}); */
	<%/* 절 보기 */%>
	$("#btnViewLinkJeul").bind("click", function(){
		if($("#btnAdd").is(":hidden")){
			$("#btnAdd").show();
		}
		<%/* 절 이어서 보기 */%>
		if($("#viewLink").val()==0){
			$("#btnViewLinkJeul").val("절 단위로 보기");
			$("#viewLink").val(1); // 이어서
			<%/* 번역 숨겼다면 다시 보여줌 */%>
			if($("#btnViewTransBelow").prop("disabled")==false){
				$("#btnViewTransBelow").attr("disabled", true);
			}
			if($("#btnViewTransBeside").prop("disabled")==false){
				$("#btnViewTransBeside").attr("disabled", true);
			}
			if($("#btnViewTrans").prop("disabled")==false){
				$("#btnViewTrans").attr("disabled", true);
			}
		}
		else{
			$("#btnViewLinkJeul").val("절 이어서 보기");
			$("#viewLink").val(0); // 단위로
			<%/* 번역 숨겼다면 다시 보여줌 */%>
			if($("#btnViewTransBelow").prop("disabled")==true){
				$("#btnViewTransBelow").attr("disabled", false);
			}
			if($("#btnViewTransBeside").prop("disabled")==true){
				$("#btnViewTransBeside").attr("disabled", false);
			}
			if($("#btnViewTrans").prop("disabled")==true){
				$("#btnViewTrans").attr("disabled", false);
			}
		}
		fn_loadBook(bib_book, $("#curr_jang").val(), tot_jang, $("#viewLink").val(), 0);
	});
	<%/* 번역 옆으로 */%>
	$("#btnViewTransBeside").bind("click", function(){
		fn_transInit();
		// 아래로 번역을 사용할 수 있게 함
		$("#btnViewTransBelow").attr("disabled", false);
		
		$("#btnAdd").hide();
		$("#viewTrans").val(2);
		$("#btnViewTrans").attr("disabled", false); // 번역 숨기기 활성화
		//$("#btnViewTransBelow").attr("disabled", true);
		$("#btnViewTransBeside").attr("disabled", true);
		$("#btnViewTrans").val("번역 숨기기");
		fn_loadBookTrans(bib_book, $("#curr_jang").val(), tot_jang, $("#viewLink").val(), 1);
	});
	<%/* 번역 아래로 */%>
	$("#btnViewTransBelow").bind("click", function(){
		fn_transInit();
		// 옆으로 번역을 사용할 수 있게 함
		$("#btnViewTransBeside").attr("disabled", false);
		
		$("#btnAdd").hide();
		$("#viewTrans").val(1);
		$("#btnViewTrans").attr("disabled", false); // 번역 숨기기 활성화
		//$("#btnViewTransBeside").attr("disabled", true);
		$("#btnViewTransBelow").attr("disabled", true);
		$("#btnViewTrans").val("번역 숨기기");
		fn_loadBookTrans(bib_book, $("#curr_jang").val(), tot_jang, $("#viewLink").val(), 0);
	});
	<%/* 아래로 더보기 */%>
	$("#btnAdd").bind("click", function(){
		$("#curr_jang").val(parseInt($("#curr_jang").val())+1);
		if(parseInt($("#curr_jang").val())<=parseInt(tot_jang)){
			if($("#curr_jang").val()==tot_jang){
				$("#btnAdd").hide();
			}
			fn_loadBook(bib_book, $("#curr_jang").val(), tot_jang, $("#viewLink").val(), 1);
		}
		$("#viewAdd").val(1);
		//$("#div_trans_menu").hide();
		<%/* 번역 보기를 숨김 */%>
		$("#btnViewTransBelow").attr("disabled", true);
		$("#btnViewTransBeside").attr("disabled", true);
	});
	<%/* 성경 내용의 폰트사이즈 조절 */%>
	$("#btnAdjustFontPlus").on("click", function () {
		console.log(">> font-size: "+$("#div_contents").css("font-size"));
		var size = parseInt($("#div_contents").css("font-size").substr(0, 2));
		if (size * 1.2 < 99) size *= 1.2;
		$("#div_contents").css("font-size", size);
	});
	$("#btnAdjustFontMinus").on("click", function () {
		var size = parseInt($("#div_contents").css("font-size").substr(0, 2));
		if (size * 0.8 > 9) size *= 0.8;
		$("#div_contents").css("font-size", size);
	});
	<%/* 장 숨기기, 보이기 */%>
	$("#btnViewJang").bind("click", function(){
		$("#div_jang").toggle();
		//console.log(">> "+$("#div_jang").is(":hidden"));
		if($("#div_jang").is(":hidden")){
			//$("#btnAdd").hide();
			$("#btnViewJang").val("장 보이기");
			if($("#curr_jang").val()!=1){
				$("#btnJangBefore").attr("disabled", false);
			}
			if($("#curr_jang").val()!=tot_jang){
				$("#btnJangNext").attr("disabled", false);
			}
			$("#btnJangBefore").removeClass("btn btn-outline-secondary btn-sm");
			$("#btnJangBefore").addClass("btn btn-outline-info btn-sm");
			$("#btnJangNext").removeClass("btn btn-outline-secondary btn-sm");
			$("#btnJangNext").addClass("btn btn-outline-info btn-sm");
		}
		else{
			//$("#btnAdd").show();
			$("#btnViewJang").val("장 숨기기");
			$("#btnJangBefore").attr("disabled", true);
			$("#btnJangNext").attr("disabled", true);
			$("#btnJangBefore").removeClass("btn btn-outline-info btn-sm");
			$("#btnJangBefore").addClass("btn btn-outline-secondary btn-sm");
			$("#btnJangNext").removeClass("btn btn-outline-info btn-sm");
			$("#btnJangNext").addClass("btn btn-outline-secondary btn-sm");
		}
	});
	$("#btnJangBefore").bind("click", function(){
		if($("#curr_jang").val()!=1){
			$("#curr_jang").val(parseInt($("#curr_jang").val())-1);
			if($("#curr_jang").val()==1){
				$("#btnJangBefore").attr("disabled", true);
			}
			else if($("#curr_jang").val()!=tot_jang){
				$("#btnJangNext").attr("disabled", false);
			}
			fn_loadBook(bib_book, $("#curr_jang").val(), tot_jang, $("#viewLink").val(), 0);
		}
		<%/* 번역 보기 숨겼다면 다시 보여줌 */%>
		fn_btnViewTrans();
		if($("#curr_jang").val()!=tot_jang){
			$("#btnAdd").show();
		}
		$("#viewAdd").val(0);
	});
	<%/* 버튼에 마우스 올릴 시 이전 장번호 보여줌 */%>
	$("#btnJangBefore").bind({
		"mouseover": function(e){
			$("#jang_head").text(($("#curr_jang").val()-1)+"장").stop().fadeIn(30).fadeOut(3000);
		},
		"mouseout": function(e){
			//$("#jang_head").text("");
		}
	});
	$("#btnJangNext").bind("click", function(){
		if($("#curr_jang").val()!=tot_jang){
			$("#curr_jang").val(parseInt($("#curr_jang").val())+1);
			if($("#curr_jang").val()==tot_jang){
				$("#btnJangNext").attr("disabled", true);
			}
			else if($("#curr_jang").val()!=1){
				$("#btnJangBefore").attr("disabled", false);
			}
			fn_loadBook(bib_book, $("#curr_jang").val(), tot_jang, $("#viewLink").val(), 0);
		}
		<%/* 번역 보기 숨겼다면 다시 보여줌 */%>
		fn_btnViewTrans();
		<%/* 아래로 더보기 숩겼다면 다시 보여줌 */%>
		/* if($("#curr_jang").val()==tot_jang){
			$("#btnAdd").hide();
		} */
		if($("#btnAdd").is(":hidden")){
			$("#btnAdd").show();
		}
		$("#viewAdd").val(0);
	});
	<%/* 버튼에 마우스 올릴 시 다음 장번호 보여줌 */%>
	$("#btnJangNext").bind({
		"mouseover": function(e){
			$("#jang_head").text((parseInt($("#curr_jang").val())+1)+"장").stop().fadeIn(30).fadeOut(3000);
		},
		"mouseout": function(e){
			//$("#jang_head").text("");
		}
	});
	<%/* 번역 숨기기 */%>
	$("#btnViewTrans").bind("click", function(){
		//console.log(">> 번역:"+$("#btnViewTrans").val());
		if($("#btnViewTrans").val()=="번역 숨기기"){
			fn_transInit();
			fn_btnViewTrans();
			$("#viewTrans").val(0);
			$("#btnViewTrans").val("번역 보기");
			$("#btnViewTrans").attr("disabled", true);
		}
		if($("#btnAdd").is(":hidden")){
			$("#btnAdd").show();
		}
	});
	$("#menu_trans").bind("click", function(e){
		console.log(">> "+$("#viewAdd").val());
		if($("#viewAdd").val()==1){
			//alert("아래로 더보기 중입니다.");
			$('#div_alert').css("display","").stop().fadeIn(30).fadeOut(3000);
			//$("*").off();
		}
		else{
			if($("#div_trans_menu").is(":hidden")){
				$("#div_trans_menu").show();
				//$("#btnAdd").css("display","none");
				$("#btnAdd").hide(); <%/* 아래로 더보기 숨김 */%>
			}
			else{
				$("#div_trans_menu").hide();
				if($("#viewTrans").val()==0){ <%/* 번역이 없다면 */%>
					$("#btnAdd").show(); <%/* 아래로 더보기 보임 */%>
				}
			}
		}
	});
	$(document).on("click", "td[name='jang_contents']", function(e){
		console.log(">> "+e.target.id+", "+e.target.value);
		if($("#div_trans_menu").is(":hidden")&&$("#btnAdd").is(":hidden")){
			$("#btnAdd").show(); <%/* 아래로 더보기 보임 */%>
		}
		if($("#"+e.target.id+"").val()==""){
			if($(e.target).is('div')){
				//e.printDefault();
				return;
			}
			$("#"+e.target.id+"").css("background-color","#e4f7ba");
			$("#"+e.target.id+"").val(1);
		}
		else{
			if($(e.target).is('div')){
				//e.printDefault();
				return;
			}
			$("#"+e.target.id+"").css({'background-color':'','opacity':''});
			//$("#"+e.target.id+"").css({'background-color':''});
			$("#"+e.target.id+"").val("");
		}
	});
	$(document).on("click", "#btn_alert", function(){
		$('#div_alert').css("display", "none");
		//$("*").on();
	});
});
</script>
<script>
function fn_btnViewTrans(){
	if($("#viewLink").val()==0){
		//console.log("..>> "+$("#btnViewTransBelow").attr("disabled"));
		if($("#btnViewTransBelow").prop("disabled")==true){
			$("#btnViewTransBelow").attr("disabled", false);
		}
		if($("#btnViewTransBeside").prop("disabled")==true){
			$("#btnViewTransBeside").attr("disabled", false);
		}
		if($("#btnViewTrans").prop("disabled")==true){
			$("#btnViewTrans").attr("disabled", false);
		}
	}
}
function fn_loadBook(bib_book, jang, tot_jang, link, add){
	var bfolder = bib_book.substr(0, bib_book.length - 7);
	//console.log("fn_loadBook>> bfolder="+bfolder);
	//console.log("fn_loadBook>> "+bib_book+", "+jang+", "+tot_jang+", "+link+", "+add);
	$.ajax({
		type: "POST",
		async: false,
		dataType: "json",
		url: "../json/" + bfolder + "/" + bib_book,
		success: function(data) {
			//console.log(">> data="+data.length);
			if(add==0){
				$("#div_contents").html("");
			}
			var vhtml="<table id='tbl_contents'><thead></thead><tbody>";
			if(link==1){
				vhtml+="<tr><td>";
			}
			var jeul_cnt=0;
			$.each(data, function (key, val){
				//vhtml="";
				//console.log(">> val.bib_chapter="+val.bib_chapter);
				items=val.bib_chapter.split(":");
				items[2]=val.bib_content;
				if(items[0]==jang){
					if(link==0){
						/* vhtml+="<tr valign='top'><td id=\"td_"+items[1]+"\" name=\"jang_contents\">"; */
						vhtml+="<tr valign='top'><td id=\"td_"+jang+"_"+items[1]+"\" name=\"jang_contents\">";
					}
					
					if(items[1]==1){
						vhtml+="<span style=\"color:red; fond-weight=bold font-size:85%;\">"+items[0]+":"+items[1]+"</span> "+items[2];
					}
					else{
						vhtml+="<span style=\"font-size:80%;\">"+items[0]+":"+items[1]+"</span> "+items[2];
					}
					<%/* 절 단위로 보기 */%>
					if(link==0){
						vhtml+="<div id=\"div_trans_"+jang+"_"+items[1]+"\" style='background-color:#ffffff;opacity:1;'></div>";
						//vhtml+="<hr>";
					}
					else{ <%/* 절 이어서 보기 */%>
						vhtml+="&nbsp;&nbsp;&nbsp";
					}
					
					if(link==0){
						vhtml+="</td><td id=\"td_trans_"+jang+"_"+items[1]+"\"></td></tr>";
						//vhtml+="<tr><td colspan=\"2\"><hr></td></tr>"
						vhtml+="<tr><td colspan=\"2\" style=\"border-bottom: 1px solid #cdd0d4;\"></td></tr>"
					}
					jeul_cnt=jeul_cnt+1;
					//console.log(">> "+jeul_cnt);
				}
			});
			if(link==1){
				vhtml+="</td></tr>";
			}
			vhtml+="</tbody></table>"
			$("#div_contents").append(vhtml);
			<%/* 더보기 버튼 */%>
			/* if(parseInt(jang)<parseInt(tot_jang)){
				vhtml+="<div align=\"center\">";
				vhtml+="<br><button id=\"btnAdd\" class=\"btn btn-outline-secondary\">더보기</button>";
				$("#div_contents").append(vhtml);
			} */
			$("#jeulCnt").val(jeul_cnt);
		},
		error: function(e) {
			//alert("에러: "+e);
		}
	});
}

function fn_loadBookTrans(bib_book, jang, tot_jang, link, point){
	//var bfolder=bib_book.substr(0, bib_book.length - 7);
	//console.log("fn_loadBook>> bfolder="+bfolder);
	//console.log("fn_loadBook>> "+bib_book+", "+jang+", "+tot_jang);
	var tmp=bib_book.substr(bib_book.length - 10, 10);
	var trans_book="";
	if(bib_book[0] == "e"){
		trans_book="kHRV_" + tmp;
	}
	else{
		trans_book="eNIV2011_" + tmp;
	}
	var bfolder=trans_book.substr(0, trans_book.length - 7);
	//console.log("a>> fn_loadBook>> "+trans_book+", "+jang+", "+tot_jang);
	
	$.ajax({
		type: "POST",
		async: false,
		dataType: "json",
		url: "../json/" + bfolder + "/" + trans_book,
		success: function(data) {
			$.each(data, function (key, val){
				//vhtml="";
				//console.log(">> val.bib_chapter="+val.bib_chapter);
				items=val.bib_chapter.split(":");
				items[2]=val.bib_content;
				if(items[0]==jang){
					var vhtml="";
					if(point==1){ <%/* 옆으로 */%>
						<%/* 번역의 폭을 반으로 줌 */%>
						$("#td_trans_"+jang+"_"+items[1]+"").css("width", "50%");
						$("#td_"+items[1]+"").css("padding-right", "5px");
						$("#td_trans_"+jang+"_"+items[1]+"").css("padding-left", "5px");
						$("#td_trans_"+jang+"_"+items[1]+"").css("border-left", "5px solid #cdd0d4");
						//$("#td_trans_"+items[1]+"").css("border-left", "3px solid #000000");
						//$("#td_trans_"+items[1]+"").css("border-left", "solid");
						//$("#td_trans_"+items[1]+"").css("border-left-color", "red"); 
						if(items[1]==1){
							vhtml+="<span style=\"color:red; fond-weight=bold font-size:85%;\">"+items[0]+":"+items[1]+"</span> "+items[2];
							$("#td_trans_"+jang+"_"+items[1]+"").html(vhtml);
						}
						else{
							vhtml+="<span style=\"font-size:80%;\">"+items[0]+":"+items[1]+"</span> "+items[2];
							$("#td_trans_"+jang+"_"+items[1]+"").html(vhtml);
						}
					}
					else{ <%/* 아래로 */%>
						<%/* 번역 아래로 공간을 확보함 */%>
						$("#div_trans_"+jang+"_"+items[1]+"").css("padding-top", "5px");
						$("#div_trans_"+jang+"_"+items[1]+"").css("padding-bottom", "10px");
						if(items[1]==1){
							vhtml+="<span style=\"color:red; fond-weight=bold font-size:85%;\">"+items[0]+":"+items[1]+"</span> "+items[2];
							$("#div_trans_"+jang+"_"+items[1]+"").html(vhtml);
						}
						else{
							vhtml+="<span style=\"font-size:80%;\">"+items[0]+":"+items[1]+"</span> "+items[2];
							$("#div_trans_"+jang+"_"+items[1]+"").html(vhtml);
						}
					}
				}
			});
		},
		error: function(e) {
			//alert("에러: "+e);
		}
	});
}
<%/* 번역 관련 버튼이 눌렸을때 다른버튼을 확인하고 번역을 지워줌 */%>
function fn_transInit(){
	var jang=$("#curr_jang").val();
	if($("#viewTrans").val()==1){ // 아래로 번역
		for(var i=1;i<=$("#jeulCnt").val();i++){
			$("#div_trans_"+jang+"_"+i).html("");
			<%/* 번역 아래로 공간을 삭제함 */%>
			$("#div_trans_"+jang+"_"+i).css("padding-top", "");
			$("#div_trans_"+jang+"_"+i).css("padding-bottom", "");
		}
	}
	else if($("#viewTrans").val()==2){ // 옆으로 번역
		for(var i=1;i<=$("#jeulCnt").val();i++){
			$("#td_trans_"+jang+"_"+i).css("width", "0%");
			$("#td_"+jang+"_"+i).css("padding-right", "");
			$("#td_trans_"+jang+"_"+i).css("padding-left", "");
			$("#td_trans_"+jang+"_"+i).css("border-left", "");
			
			$("#td_trans_"+jang+"_"+i).html("");
		}
	}
}

function fn_hideDivJang(){
	//fn_hideDivJang();
	$("#btnViewJang").val("장 보이기");
	if($("#curr_jang").val()!=1){
		$("#btnJangBefore").attr("disabled", false);
	}
	if($("#curr_jang").val()!=tot_jang){
		$("#btnJangNext").attr("disabled", false);
	}
	$("#btnJangBefore").removeClass("btn btn-outline-secondary btn-sm");
	$("#btnJangBefore").addClass("btn btn-outline-info btn-sm");
	$("#btnJangNext").removeClass("btn btn-outline-secondary btn-sm");
	$("#btnJangNext").addClass("btn btn-outline-info btn-sm");
}
</script>
</head>
<body>
<div class="container">
	<div id="div_bib">
		<button class="btn btn-outline-secondary" type="button" id="btnBib">성경 이동</button>
	</div>
	<br>
	<div>
		<h2>${book} <span id="jang_head"></span></h2>
	</div>
	<div id="div_trans_menu">
	<br>
		<input type="button" id="btnViewTrans" value="번역 보기" class="btn btn-outline-secondary" disabled="disabled" />
		<input type="button" id="btnViewTransBelow" value="번역 아래로" class="btn btn-outline-info btn-sm" />
		<input type="button" id="btnViewTransBeside" value="번역 옆으로" class="btn btn-outline-info btn-sm" />
		<input type="hidden" id="viewLink" value="0"/>
		<input type="hidden" id="viewTrans" value="0"/>
	</div>
	<br>
	<!-- 
	<div id="div_jang2">
	</div>
	 -->
	<input type="button" id="btnViewJang" value="장 숨기기" class="btn btn-outline-secondary" />
	<input type="button" id="btnJangBefore" title="장을 숨기면 활성화됩니다." value="이전 장" class="btn btn-outline-secondary btn-sm" disabled="disabled" />
	<input type="button" id="btnJangNext" title="장을 숨기면 활성화됩니다." value="다음 장" class="btn btn-outline-secondary btn-sm" disabled="disabled" />
	<div id="div_jang">
		<table style="width:100%">
		<c:forEach var="i" begin="1" end="${tot_jang}">
			<c:if test="${i%10==1}"><tr></c:if>
				<td><input id="jang_${i}" name="jang" type="button" class="btn btn-outline-info btn-block btn-sm" 
					style="font-size: 12px;" title="${i}장" value="${i}" />
				</td>
			<c:if test="${i>0 and i/10==0}"></tr></c:if>
		</c:forEach>
		</table>
		<input type="hidden" id="curr_jang"/>
	</div>
	<hr style="border: solid #ffffff">
	<%/* 성경 내용 */%>
	<div id="div_contents">
	</div>
	<div id="div_alert" style="display: none;">
		<label>아래로 더보기 중에는<br /> 번역을 사용할 수 없습니다.</label><br />
		<!-- <button id="btn_alert" class="btn btn-outline-secondary" style="width:80%;">확인</button> -->
	</div>
	<br />
	<%/* 더보기 버튼 */%>
	<div align="center">
		<input type="button" id="btnAdd" class="btn btn-outline-secondary" value="아래로 더보기" />
		<input type="hidden" id="viewAdd" value="0"/>
	</div>
	<br />
	<br />
	<div>
		<input type="button" id="btnViewLinkJeul" value="절 이어서 보기" class="btn btn-outline-secondary" />
		<input type="hidden" id="jeulCnt"/>
	</div>
	<div>
		<input type="button" id="menu_trans" value="번역" class="btn btn-outline-secondary" />
	</div>
	<%/* 글자크기 조절버튼 시작 */%>
	<div>
		<div id="btnAdjustFontMinus">-</div>
		<div id="btnAdjustFontPlus">+</div>
	</div>
	<%/* 성경이름 처음으로 가기 */%>
	<div>
		<a href="#" id="btn_top_bar"><span style="font-size: 9px;">Top</span>&nbsp;<c:out value="${book}" /></a>
		<%-- <input type="button" id="btn_top_bar" value='<c:out value="${book}"></c:out>' class="btn btn-outline-secondary" /> --%>
	</div>
</div>
</body>
</html>