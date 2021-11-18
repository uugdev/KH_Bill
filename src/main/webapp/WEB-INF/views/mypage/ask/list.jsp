<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/views/layout/head.jsp" />
<c:import url="/WEB-INF/views/layout/header.jsp" />
<!-- header end -->

<!-- 개별 스타일 및 스크립트 영역 -->

<script type="text/javascript">
$(document).ready(function(){
	
	$(document).on('click', '#selectAll', function() {
	    if($('#selectAll').is(':checked')){
	       $('.chk').prop('checked', true);
	    } else {
	       $('.chk').prop('checked', false);
	    }
	});
	
	$(document).on('click', '.chk', function() {
	    if($('input[class=chk]:checked').length==$('.chk').length){
	        $('#selectAll').prop('checked', true);
	    }else{
	       $('#selectAll').prop('checked', false);
	    }
	});
	
	$("#btnDelete").click(function() {
		var answer = confirm("선택한 질문글을 삭제하시겠습니까?\n 해당 작업은 되돌릴 수 없습니다.")
		var delchk = [];
   
	    $('.chk:checked').each(function(){
	        delchk.push($(this).val());
	    });
		if( answer == true ){
			location.href="/mypage/ask/delete?askNo="+delchk;
		} else {
			return false;
		}
	})

})
</script>

<!-- 개별 영역 끝 -->

<div class="wrap">
<div class="container">
<c:import url="/WEB-INF/views/layout/myPageSideMenu.jsp" />


<h1>작성한 질문글 내역</h1>

<table class="table table-striped table-hover">
<thead>
	<tr>
		<th>전체 선택&nbsp;<input type="checkbox" name="select" id="selectAll" /></th>
		<th style="width: 10%;">글번호</th>
		<th style="width: 45%;">제목</th>
		<th style="width: 10%;">조회수</th>
		<th style="width: 15%;">작성일</th>
	</tr>
</thead>
<tbody>
	<c:forEach items="${ask }" var="ask">
	<tr>
		<td><input type="checkbox" id="${ask.askNo }" value="${ask.askNo }" class="chk" /></td>
		<td>${ask.askNo }</td>
		<td><a href="<%=request.getContextPath() %>/ask/detail?askNo=${ask.askNo }">${ask.askTitle }</a></td>
		<td>${ask.askHit }</td>
		<td><fmt:formatDate value="${ask.askDate }" pattern="yy-MM-dd HH:mm:ss" /></td>
	</tr>
	</c:forEach>
</table>

<button id="btnDelete" class="pull-left">삭제</button>
<div class="clearfix"></div>

<c:import url="/WEB-INF/views/layout/paging.jsp" />
</div><!-- .container end -->
</div><!-- .wrap end -->

<!-- footer start -->
<c:import url="/WEB-INF/views/layout/footer.jsp" />

