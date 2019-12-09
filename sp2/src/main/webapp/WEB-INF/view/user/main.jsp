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
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-3.4.1.min.js"></script>

<script type="text/javascript">
$(function(){
	$("#btnJsonOk1").click(function(){
		var url = "<%=cp%>/user/json1";
		var query = "tmp="+new Date().getTime();

		$.ajax({
			type:"get"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data){
				// console.log(data);	
				printJSON(data);
			}
		,error:function(e){
			console.log(e.responseText);
			}
		});
	});
	
	function printJSON(data) {
		var out="JSON으로 받아오기 1<br>";
		
		var dataCount = data.dataCount;
		$.each(data.list, function(index, item){
			var num = item.num;
			var name = item.name;
			
		});
		/*
			for(var i=0;i<data.list.length;i++){
				var item = data.list[i];
				var num = item.num;
			}
		*/
				
		$("#resultLayout").html(out);
	}
});

$(function(){
	$("#btnJsonOk2").click(function(){
		var url = "<%=cp%>/user/json2";
		var query = "tmp="+new Date().getTime();

		$.ajax({
			type:"get"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data){
				// console.log(data);	
				printJSON(data);
			
			}
			,error:function(e){
				console.log(e.responseText);
			}
		
		});
	});
	
	function printJSON(data) {
		var out="JSON으로 받아오기 2<br>";
		
		var dataCount = data.root.dataCount;
		$.each(data.root.record, function(index, item){
			var num = item.num;
		});
		$("#resultLayout").html(out);
	}
});

$(function(){
	$("#btnXmlOk").click(function(){
		var url = "<%=cp%>/user/xml";
		var query = "tmp="+new Date().getTime();
		$.ajax({
			type:"get"
			,url:url
			,data:query
			,dataType:"xml"
			,success:function(data){
				console.log(data);
			}
		,error:function(e){
			// console.log(e.responseText);
			printXML(data);
		}
		});
	});
	
	function printXML(data) {
		var out="XML로 받아오기<br>";
		var dataCount = $(data).find("dataCount").text();
		
		$(data).find("record").each(function(){
			var record = $(this);
			var num = record.attr("num");
			var name = record.find("name").text();
		
		});
		
		$("#resultLayout").html(out);
	}

});


$(function(){
	$("#btnZip").click(function(){
		var url = "<%=cp%>/user/zip";
		var query = "tmp="+new Date().getTime();

		$.ajax({
			type:"get"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data){
				console.log(data);	
			}
		,error:function(e){
			console.log(e.responseText);
			}
		});
	});
	
	function printJSON(data) {
		var out="JSON으로 받아오기 2<br>";
		
		$("#resultLayout").html(out);
	}
});

$(function(){
	$("#btnXmlOk").click(function(){

	});
	
	function printXML(data) {
		var out="XML로 받아오기<br>";
		
		$("#resultLayout").html(out);
	}
});
</script>

</head>

<body>

<div class="body-container" style="margin:30px auto; width: 600px;">
    <div class="title">
        <h3>자바 XML 문서</h3>
    </div>
    
     <div style="width: 95%;margin-top: 5px; margin-bottom: 5px;">
     	<button type="button" id="btnJsonOk1" class="btn">JSON으로 받기 1</button>
     	<button type="button" id="btnJsonOk2" class="btn">JSON으로 받기 2</button>
     	<button type="button" id="btnXmlOk" class="btn">XML로 받기</button>
     	<button type="button" id="btnZip" class="btn">공공 API - zip</button>
     </div>

     <div id="resultLayout" style="width: 95%;"></div>
</div>

</body>
</html>