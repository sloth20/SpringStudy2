<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();

	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));

	int s = 0;
	for (int i = 1; i <= num; i++) {
		s += i;
	}
%>

1~<%=num%>까지의 합 : <%=s%>