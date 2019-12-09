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
		var url = "ex2_ok.jsp";
		var query = "num="+$("#num").val();

		$.ajax({
			type:"post"
			,url:url
			,data:query
			,async:false // false:동기, true:비동기(기본)
			,success:function(data){
				$("#resultLayout").html(data); //1)
			}
			,error:function(e){
				console.log(e.responseText);
			}
		});
		
		$("#resultLayout").html("A"); // 2)
		
		/*
			동기 처리하므로 1)을 먼저 실행하고 2)를 실행.
			동기는 브라우저를 일시적으로 잠글 수 있으며 요청이 활성화된 동안 모든 작업을 비활성화할 수 있다.
		*/
		
	});
});


</script>
</head>
<body>

	<h3>AJAX-동기 예</h3>
	<p>
		<input type="text" id="num">
		<button type="button" id="btnSend">확인</button>
	</p>
	<div id="resultLayout"></div>

</body>
</html>