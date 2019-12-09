<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();

	JSONObject job = new JSONObject();
	job.put("count", 3);

	JSONArray jarr = new JSONArray();

	JSONObject ob = new JSONObject();
	ob.put("num", 1);
	ob.put("name", "홍길동");
	ob.put("content", "테스트1");
	jarr.put(ob);

	ob = new JSONObject();
	ob.put("num", 2);
	ob.put("name", "스프링");
	ob.put("content", "테스트2");
	jarr.put(ob);

	ob = new JSONObject();
	ob.put("num", 3);
	ob.put("name", "하하하");
	ob.put("content", "테스트3");
	jarr.put(ob);

	job.put("list", jarr);

	out.print(job.toString());
%>
