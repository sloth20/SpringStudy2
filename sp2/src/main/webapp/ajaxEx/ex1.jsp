<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	$("#btnSend").click(function(){
		var url = "ex1_ok.jsp";
		var query = "num="+$("#num").val();

		$.ajax({
			type:"post"
			,url:url
			,data:query
			,success:function(data){
				$("#resultLayout").html(data); //1)
			}
			,error:function(e){
				console.log(e.responseText);
			}
		});
		
		$("#resultLayout").html("A"); // 2)
		
		/*
			AJAX는 기본적으로 비동기로 처리하므로 2)를 먼저 실행하고 1)을 실행
		*/
		
	});
});


</script>
</head>
<body>

	<h3>AJAX-비동기 예</h3>
	<p>
		<input type="text" id="num">
		<button type="button" id="btnSend">확인</button>
	</p>
	<div id="resultLayout"></div>

</body>
</html>