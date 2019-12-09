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
    font-size: 13px; font-family: "¸¼Àº °íµñ", ³ª´®°íµñ, µ¸¿ò, sans-serif;
}
</style>

</head>
<body>

<div style="margin:30px auto; text-align: center; ">
    ${message}
</div>
    
</body>
</html>
