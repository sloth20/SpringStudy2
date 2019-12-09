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

<style type="text/css">
*{
    margin: 0; padding: 0;
}
body {
    font-size: 13px; font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
}
</style>

</head>
<body>

<div style="margin:30px auto;">
    <form action="<%=cp%>/ts1/write" method="post">
    <table>
    	<tr>
    	    <td width="100" align="right">아이디 :</td>
    	    <td><input type="text" name="id"></td>
    	</tr>
    	<tr>
    	    <td width="100" align="right">이름 :</td>
    	    <td><input type="text" name="name"></td>
    	</tr>
    	<tr>
    	    <td width="100" align="right">생년월일 :</td>
    	    <td><input type="text" name="birth"></td>
    	</tr>
    	<tr>
    	    <td width="100" align="right">전화번호 :</td>
    	    <td><input type="text" name="tel"></td>
    	</tr>
    	<tr>
    	   <td colspan="2" align="center">
    	          <input type="submit" value="저장하기">
    	   </td>
    	</tr>
    </table>
</form>
</div>

<div style="padding-left: 10px;">
    ** XML 스키마 이용<br>
	모든 컬럼에 데이터를 추가하면 데이터가 추가 되지만 하나의 컬럼(예:전화번호)이라도 데이터를 입력 하지 않으면 추가 되지 않는다.<br>
	트랜잭션 처리로 인하여 롤백 됨
</div>

</body>
</html>