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
a{
    color: #000000;
    text-decoration: none;
    cursor: pointer;
}
a:active, a:hover {
    text-decoration: underline;
    color: tomato;
}
.title {
    font-weight: bold;
    font-size:15px;
    margin-bottom:10px;
    font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
}
.btn {
    color:#333;
    font-weight:500;
    font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
    border:1px solid #cccccc;
    background-color:#ffffff;
    text-align:center;
    cursor:pointer;
    padding:3px 10px 5px;
    border-radius:4px;
}
.btn:active, .btn:focus, .btn:hover {
    background-color:#e6e6e6;
    border-color: #adadad;
    color: #333333;
}
.boxTF {
    border:1px solid #999999;
    padding:3px 5px 5px;
    border-radius:4px;
    background-color:#ffffff;
    font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
}
.selectField {
    border:1px solid #999999;
    padding:2px 5px 4px;
    border-radius:4px;
    font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
}
</style>

<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.action="<%=cp%>";
	f.submit();
}

function deleteScore(hak) {
	var url="<%=cp%>";
	if(confirm("자료를 삭제 하시겠습니까?")) {
		location.href=url;
	}
}

function updateScore(hak) {
	var url="<%=cp%>";
	location.href=url;
}

function check() {
	var f=document.scoreListForm;
	
	if(f.haks==undefined)
		return;
	
	if(f.haks.length!=undefined) { // 체크박스가 둘 이상인 경우
		for(var i=0; i<f.haks.length; i++) {
			if(f.chkAll.checked)
				f.haks[i].checked=true;
			else
				f.haks[i].checked=false;
		}
	} else { // 체크박스가 하나인 경우
		if(f.chkAll.checked)
			f.haks.checked=true;
		else
			f.haks.checked=false;
	}
}

function deleteList() {
	var f=document.scoreListForm;
	var cnt=0;
	
	if(f.haks==undefined) {
		return;		
	}
	
	if(f.haks.length!=undefined) {// 체크박스가 둘 이상인 경우
		for(var i=0; i<f.haks.length; i++) {
			if(f.haks[i].checked)
				cnt++;
		}
	} else {
		// 체크박스가 하나인 경우
		if(f.haks.checked)
			cnt++;
	}
	
	if(cnt==0) {
		alert("선택한 게시물이 없습니다.");
		return;
	}
	
	if(confirm("선택한 게시물을 삭제하시겠습니까 ? ")) {
		f.action="<%=cp%>";
		f.submit();
	}
}
</script>

</head>
<body>

<div style="width: 700px; margin: 30px auto 0px;">
<table style="width: 100%; margin: 0px auto;">
<tr height="50">
	<td align="center" colspan="2">
	    <span style="font-size: 15pt; font-family: 맑은 고딕, 돋움; font-weight: bold;">성적처리</span>
	</td>
</tr>

<tr height="35">
	<td width="50%">
		<button type="button" class="btn" id="btnDeleteList" onclick="deleteList();">삭제</button>
	</td>
	<td align="right">1개(1/1 페이지)</td>
</tr>
</table>

<form name="scoreListForm" method="post">
<table style="width: 100%; margin: 0px auto; border-spacing: 1px; background: #cccccc;">
<tr height="30" bgcolor="#eeeeee" align="center">
	<th width="40">
	    <input type="checkbox" name="chkAll" id="chkAll" value="all" onclick="check();">
	</th>
	<th width="60">학번</th>
	<th width="80">이름</th>
	<th width="90">생년월일</th>
	<th width="60">국어</th>
	<th width="60">영어</th>
	<th width="60">수학</th>
	<th width="70">총점</th>
	<th width="60">평균</th>
	<th>수정</th>
</tr>

<tr height="35" bgcolor="#ffffff" align="center">
	<td>
	    <input type="checkbox" name="haks" value="1111">
	</td>
	<td>1111</td>
	<td>스프링</td>
	<td>2000-10-10</td>
	<td>80</td>
	<td>80</td>
	<td>80</td>
	<td>240</td>
	<td>80</td>
	<td>
		<a href="javascript:updateScore('1111')">수정</a> | 
		<a href="javascript:deleteScore('1111')">삭제</a>
	</td>
</tr>

</table>
</form>

<table style="width: 100%; margin: 10px auto;">
<tr height="30" align="center">
	<td>1 2 3</td>
</tr>
</table>

<form name="searchForm" method="post">
<table style="width: 100%; margin: 0px auto;">
<tr height="35">
	<td width="20%">
		<button type="button" class="btn"
		       onclick="javascript:location.href='<%=cp%>';">새로고침</button>
	</td>
	<td align="center">
		<select name="condition" class="selectField">
		    <option value="hak">학번</option>
		    <option value="name">이름</option>
		    <option value="birth">생년월일</option>
		</select>
		<input type="text" name="keyword" class="boxTF">
		<button type="button" class="btn" onclick="searchList();">검색</button>
	</td>
	<td width="20%" align="right">
		<button type="button" class="btn"
		       onclick="javascript:location.href='<%=cp%>';">등록하기</button>
	</td>
</tr>

</table>
</form>

</div>

</body>
</html>