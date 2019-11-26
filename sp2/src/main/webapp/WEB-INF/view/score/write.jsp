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
</style>

<script type="text/javascript">
if(typeof String.prototype.trim !== 'function') {
    String.prototype.trim = function() {
        var TRIM_PATTERN = /(^\s*)|(\s*$)/g;
        return this.replace(TRIM_PATTERN, "");
    };
}
  
function isValidDateFormat(data) {
    var regexp = /[12][0-9]{3}[\.|\-|\/]?[0-9]{2}[\.|\-|\/]?[0-9]{2}/;
    if(! regexp.test(data))
        return false;

    regexp=/(\.)|(\-)|(\/)/g;
    data=data.replace(regexp, "");
    
	var y=parseInt(data.substr(0, 4));
    var m=parseInt(data.substr(4, 2));
    if(m<1||m>12) 
    	return false;
    var d=parseInt(data.substr(6));
    var lastDay = (new Date(y, m, 0)).getDate();
    if(d<1||d>lastDay)
    	return false;
		
	return true;     
}

function isValidScoreFormat(data) {
    var regexp = /^(\d+)$/;
    if(! regexp.test(data))
        return false;
	var s = parseInt(data);
	return s>=0&&s<=100 ? true : false;
}

function check() {
	// var f=document.forms[0];
	var f=document.scoreForm;
	
	if(! f.hak.value.trim()) {
        alert("필수 입력 사항 입니다. !!!");
        f.hak.focus();
        return false;
	}
	f.hak.value=f.hak.value.trim();
	
	if(! f.name.value.trim()) {
        alert("필수 입력 사항 입니다. !!!");
        f.name.focus();
        return false;
	}
	f.name.value=f.name.value.trim();
	
    if(! isValidDateFormat(f.birth.value)) {
        alert("날짜 형식이 유효하지 않습니다. ");
        f.birth.focus();
        return false;
	}
	
    if(! isValidScoreFormat(f.kor.value)) {
            alert("점수는 0~100 사이만 가능합니다. ");
            f.kor.focus();
            return false;
    }
    
    if(! isValidScoreFormat(f.eng.value)) {
        alert("점수는 0~100 사이만 가능합니다. ");
        f.eng.focus();
        return false;
	}
    if(! isValidScoreFormat(f.mat.value)) {
        alert("점수는 0~100 사이만 가능합니다. ");
        f.mat.focus();
        return false;
	}
	
    f.action="<%=cp%>/score/${mode}";

	return true;
}
</script>

</head>
<body>

<div style="width: 500px; margin: 30px auto 5px;">
<table style="width: 100%; margin: 0px auto;">
<tr>
	<td align="center">
	    <span style="font-size: 15pt; font-family: 맑은 고딕, 돋움; font-weight: bold;">성적처리</span>
	</td>
</tr>
</table>

<form name="scoreForm" method="post" onsubmit="return check();">
	<table style="width: 100%; margin: 10px auto 0px; border-spacing: 0px; border-collapse: collapse;">
	<tr height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
		<td width="100" bgcolor="#eeeeee" align="center">학번</td>
		<td style="padding-left: 10px;">
			<input type="text" name="hak" class="boxTF" size="30" maxlength="10" value="${dto.hak}">
		</td>
	</tr>
	
	<tr height="40" style="border-bottom: 1px solid #cccccc;">
		<td width="100" bgcolor="#eeeeee" align="center">이름</td>
		<td style="padding-left: 10px;">
			<input type="text" name="name" class="boxTF" size="30" 
			           maxlength="10" value="${dto.name }">
		</td>
	</tr>
	
	<tr height="40" style="border-bottom: 1px solid #cccccc;">
		<td width="100" bgcolor="#eeeeee" align="center">생년월일</td>
		<td style="padding-left: 10px;">
			<input type="text" name="birth" class="boxTF" size="30" 
			           maxlength="10" value="${dto.birth }">
		</td>
	</tr>
	
	<tr height="40" style="border-bottom: 1px solid #cccccc;">
		<td width="100" bgcolor="#eeeeee" align="center">국어</td>
		<td style="padding-left: 10px;">
			<input type="text" name="kor" class="boxTF" size="30" 
			           maxlength="3" value="${dto.kor }">
		</td>
	</tr>
	
	<tr height="40" style="border-bottom: 1px solid #cccccc;">
		<td width="100" bgcolor="#eeeeee" align="center">영어</td>
		<td style="padding-left: 10px;">
			<input type="text" name="eng" class="boxTF" size="30" 
			           maxlength="3" value="${dto.eng }">
		</td>
	</tr>
	
	<tr height="40" style="border-bottom: 1px solid #cccccc;">
		<td width="100" bgcolor="#eeeeee" align="center">수학</td>
		<td style="padding-left: 10px;">
			<input type="text" name="mat" class="boxTF" size="30" 
			           maxlength="3" value="${dto.mat }">
		</td>
	</table>

    <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
	<tr height="40">
		<td width="100" align="center" colspan="2">
				<button type="submit" class="btn"> ${mode=="update"?"수정완료":"등록완료"} </button> 
				<button type="reset" class="btn"> 다시입력 </button>
				<button type="button" class="btn"
				    onclick="javascript:location.href='<%=cp%>/score/list';"> ${mode=="update"?"수정취소":"등록취소"} </button>
		
				<c:if test="${mode=='update'}">
					<input type="hidden" name="phak" value="${dto.hak}">
					<input type="hidden" name="page" value="${page }">
			
				</c:if>
		</td>
	</tr>
	
	<tr height="35">
		<td width="100" align="center" colspan="2">
		      ${msg}
		</td>
	</tr>
	</table>
</form>
</div>

</body>
</html>