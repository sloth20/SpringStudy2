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
<title>spring</title>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

body {
	font-size: 13px;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
}

a {
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
	font-size: 15px;
	margin-bottom: 10px;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
}

.btn {
	color: #333;
	font-weight: 500;
	font-family: "Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
	border: 1px solid #cccccc;
	background-color: #ffffff;
	text-align: center;
	cursor: pointer;
	padding: 3px 10px 5px;
	border-radius: 4px;
}

.btn:active, .btn:focus, .btn:hover {
	background-color: #e6e6e6;
	border-color: #adadad;
	color: #333333;
}

.boxTF {
	border: 1px solid #999999;
	padding: 3px 5px 5px;
	border-radius: 4px;
	background-color: #ffffff;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
}

.selectField {
	border: 1px solid #999999;
	padding: 2px 5px 4px;
	border-radius: 4px;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
}
</style>

<script src="<%=cp%>/resource/jquery/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
$(function() {
    $("#chkAll").click(function() {
	   if($(this).is(":checked")) {
		   $("input[name=haks]").prop("checked", true);
        } else {
		   $("input[name=haks]").prop("checked", false);
        }
    });
 
    $("#btnDeleteList").click(function(){
		// var cnt = $("input[name=haks]:checkbox:checked").length;
		var cnt = $("input[name=haks]:checked").length;

         if (cnt == 0) {
        	 alert("삭제할 게시물을 먼저 선택 하세요 !!!");
             return false;
         }
         
         if(confirm("선택한 게시물을 삭제하시겠습니까 ? ")) {
        	 var f=document.scoreListForm;
        	 f.action="<%=cp%>/score/deleteList";
        	 f.submit();
     	}
         
    });
}); 

function searchList() {
	var f=document.searchForm;
	f.submit();
}

function deleteScore(hak) {
	var url="<%=cp%>/score/delete?hak="+hak+"&page=${page}";
	if(confirm("자료를 삭제 하시겠습니까?")) {
		location.href=url;
	}
}

function updateScore(hak) {
	var url="<%=cp%>/score/update?hak="+hak+"&page=${page}";
		location.href = url;
	}
</script>

</head>
<body>

	<div style="width: 700px; margin: 30px auto 0px;">
		<table style="width: 100%; margin: 0px auto;">
			<tr height="50">
				<td align="center" colspan="2"><span
					style="font-size: 15pt; font-family: 맑은 고딕, 돋움; font-weight: bold;">성적처리</span>
				</td>
			</tr>

			<tr height="35">
				<td width="50%">
					<button type="button" class="btn" id="btnDeleteList">삭제</button>
				</td>
				<td align="right">${dataCount }개(${page }/${total_page }페이지)</td>
			</tr>
		</table>

		<form name="scoreListForm" method="post">
			<table
				style="width: 100%; margin: 0px auto; border-spacing: 1px; background: #cccccc;">
				<tr height="30" bgcolor="#eeeeee" align="center">
					<th width="40"><input type="checkbox" name="chkAll"
						id="chkAll" value="all"></th>
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

				<c:forEach var="dto" items="${list }">
					<tr height="35" bgcolor="#ffffff" align="center">
						<td><input type="checkbox" name="haks" value="${dto.hak }">
						</td>
						<td>${dto.hak }</td>
						<td>${dto.name }</td>
						<td>${dto.birth}</td>
						<td>${dto.kor}</td>
						<td>${dto.eng }</td>
						<td>${dto.mat}</td>
						<td>${dto.tot }</td>
						<td>${dto.ave }</td>
						<td><a href="javascript:updateScore('${dto.hak }')">수정</a> |
							<a href="javascript:deleteScore('${dto.hak }')">삭제</a></td>
					</tr>
				</c:forEach>
			</table>
			<input type="hidden" name="page" value="${page }">
		</form>

		<table style="width: 100%; margin: 10px auto;">
			<tr height="30" align="center">
				<td>${dataCount==0?"등록된 자료가 없습니다.":paging }</td>
			</tr>
		</table>

		<form name="searchForm" method="post" action="<%=cp%>/score/list">
			<table style="width: 100%; margin: 0px auto;">
				<tr height="35">
					<td width="20%">
						<button type="button" class="btn"
							onclick="javascript:location.href='<%=cp%>/score/list';">새로고침</button>
					</td>
					<td align="center"><select name="condition"
						class="selectField">
							<option value="hak">학번</option>
							<option value="name">이름</option>
							<option value="birth">생년월일</option>
					</select> <input type="text" name="keyword" class="boxTF">
						<button type="button" class="btn" onclick="searchList();">검색</button>
					</td>
					<td width="20%" align="right">
						<button type="button" class="btn"
							onclick="javascript:location.href='<%=cp%>/score/insert';">등록하기</button>
					</td>
				</tr>

			</table>
		</form>

	</div>

</body>
</html>