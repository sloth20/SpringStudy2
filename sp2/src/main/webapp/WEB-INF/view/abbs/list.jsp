﻿<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
   <tr height="35">
      <td align="left" width="50%">
          ${dataCount}개(${pageNo}/${total_page} 페이지)
      </td>
      <td align="right">
          &nbsp;
      </td>
   </tr>
</table>

<table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
  <tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
      <th width="60" style="color: #787878;">번호</th>
      <th style="color: #787878;">제목</th>
      <th width="100" style="color: #787878;">작성자</th>
      <th width="80" style="color: #787878;">작성일</th>
      <th width="60" style="color: #787878;">조회수</th>
      <th width="50" style="color: #787878;">첨부</th>
  </tr>
 
 <c:forEach var="dto" items="${list}">
   <tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
      <td>${dto.listNum}</td>
      <td align="left" style="padding-left: 10px;">
           <a href="javascript:articleBoard(${dto.num})">${dto.subject}</a>
      </td>
      <td>${dto.name}</td>
      <td>${dto.created}</td>
      <td>${dto.hitCount}</td>
      <td>
         <c:if test="${not empty dto.saveFilename}">
	         <a href="<%=cp%>/abbs/download?num=${dto.num}"><img src="<%=cp%>/resource/images/disk.gif" border="0" style="margin-top: 1px;"></a>
         </c:if>
      </td>
  </tr>
 </c:forEach>  
</table>
 
<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
   <tr height="35">
	<td align="center">
        ${dataCount==0?"등록된 게시물이 없습니다.":paging}
	</td>
   </tr>
</table>

<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
   <tr height="40">
      <td align="left" width="100">
          <button type="button" class="btn" onclick="reloadBoard()">새로고침</button>
      </td>
      <td align="center">
              <select name="condition" id="condition" class="selectField">
				  <option value="all"     ${condition=="all"?"selected='selected'":""}>모두</option>
				  <option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
				  <option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
				  <option value="name"    ${condition=="name"?"selected='selected'":""}>작성자</option>
				  <option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
            </select>
            <input type="text" name="keyword" id="keyword" class="boxTF" value="${keyword}">
            <button type="button" class="btn" onclick="searchList()">검색</button>
      </td>
      <td align="right" width="100">
          <button type="button" class="btn" onclick="insertBoard();">글올리기</button>
      </td>
   </tr>
</table>
