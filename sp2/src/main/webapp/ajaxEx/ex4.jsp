<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

$(function(){
	$("#btnJSON").click(function(){
		var url = "http://127.0.0.1:9090/sp1/user/data";
		var query = "id=spring";
		
		$.ajax({
			url:url
			,data:query
			,dataType:"jsonp"
			// ,jsonp:"callback" // jsonp를 처리할 패러미터 이름이 callback이 아닌 경우 패러미터를 지정
			,success:function(data){
				// console.log(data);
				var s = data.id+" : "+data.name+" : "+data.age+" : "+data.state;
			
				$("#resultLayout").html(s);
			}
			,error:function(e){
				console.log(e.responseText);
			}
		});
	});
})

</script>


</head>
<body>

<h3>JSONP 예제</h3>

<div>
	<button type="button" id="btnJSON">확인</button>
</div>
<hr>
<div id="resultLayout"></div>

</body>
</html>