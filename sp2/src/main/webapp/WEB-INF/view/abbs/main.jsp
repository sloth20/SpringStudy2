<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>spring</title>

<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css">
<style type="text/css">
.board-container{
	width: 700px;
	margin:30px auto;
}

.board-container .title {
    font-weight: bold;
    font-size:15px;
    margin-bottom:10px;
    font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
}
</style>

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.form.js"></script>

<script type="text/javascript">
// 전역 변수
var pageNo = "1";
var condition = "all";
var keyword = "";

	function ajaxHTML(url, type, query, selector){
		$.ajax({
			type:type
			,url:url
			,data:query
			,success:function(data){
				if($.trim(data)=="error"){
					listPage(pageNo);
					return;
				}
				
				$(selector).html(data);
			}
			,beforeSend:function(jqXHR){
				
			}
			,error:function(jqXHR){
				console.log(jqXHR.responseText);
			}
		});
	}
	
	function ajaxJSON(url, type, query, fn){
		$.ajax({
			type:type
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data){
				fn(data);
			}
			,beforeSend:function(jqXHR){
				
			}
			,error:function(jqXHR){
				console.log(jqXHR.responseText);
			}
		});
	}
	
	function ajaxFileJSON(url, type, query, fn){
		$.ajax({
			type:type
			,url:url
			,data:query
			,processData:false // 서버로 전송할 데이터를 쿼리 문자열로 변환할지 여부
			,contentType:false // 서버로 전송할 데이터의 Content-Type. 기본 : application/x-www-form-urlencoded
			,dataType:"json"
			,success:function(data){
				fn(data);
			}
			,beforeSend:function(jqXHR){
				
			}
			,error:function(jqXHR){
				console.log(jqXHR.responseText);
			}
		});
	}
	
	$(function(){
		listPage(1);
	});

	function listPage(page){
		pageNo = page;
		
		var url = "<%=cp%>/abbs/list";
		var query = "pageNo="+page;
		if(keyword!=""){
			query+="&condition="+condition+"&keyword="+encodeURIComponent(keyword);
		}
		var vid = "#board-body";
		
		ajaxHTML(url, "get", query, vid);
	}
	
	function reloadBoard(){
		condition = "all";
		keyword = "";
		
		listPage(1);
	}
	
	function searchList(){
		condition = $("#condition").val();
		keyword = $("#keyword").val();
		
		listPage(1);
	}
	
	function insertBoard(){
		var url = "<%=cp%>/abbs/created";
		$("#board-body").load(url); // AJAX-GET
	}
	
	function sendBoard(mode){
		var f=document.boardForm;
		
		if(! f.subject.value) {
			f.subject.focus();
			return;
		}
		
		if(! f.name.value) {
			f.name.focus();
			return;
		}
		
		if(! f.content.value) {
			f.content.focus();
			return;
		}
		
		if(! f.pwd.value) {
			f.pwd.focus();
			return;
		}
		
		condition="all";
		keyword="";
		if(mode=="created"){
			pageNo="1";
		}
		
		var url = "<%=cp%>/abbs/"+mode;
		// var query = $("form[name=boardForm]").serialize(); // 파일 업로드 불가능
		var query = new FormData(f); // IE 10이상
		
		var fn = function(data){
			listPage(pageNo);
		};
		
		ajaxFileJSON(url, "post", query, fn);
	}
	
	function articleBoard(num){
		var url = "<%=cp%>/abbs/article";
		var query = "num="+num+"&pageNo="+pageNo;
		if(keyword!=""){
			query+="&condition="+condition+"&keyword="+encodeURIComponent(keyword);
		}
		var vid = "#board-body";
		
		ajaxHTML(url, "get", query, vid);
	}
	
	function updateBoard(num){
		var url = "<%=cp%>/abbs/update";
		var query = "num="+num;
		var vid = "#board-body";
		
		ajaxHTML(url, "get", query, vid);
	}

		
	function deleteBoard(num){
		
		if(!confirm("게시물을 삭제하시겠습니까?")){
			return;	
		}
		
		var url = "<%=cp%>/abbs/delete";
		var query = "num="+num;
		
		var fn = function(data){
			listPage(pageNo);
		};
		ajaxJSON(url, "post", query, fn);
	}
	
	
</script>

</head>

<body>
<div class="board-container">
	<div id="board-header">
		<table style="width: 100%; border-spacing: 0px;">
			<tr height="45">
				<td align="left" class="title">
					<h3><span>|</span> 게시판</h3>
				</td>
			</tr>
		</table>
	</div>
	<div id="board-body"></div>
 </div>
</body>

</html>