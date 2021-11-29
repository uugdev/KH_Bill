<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:import url="/WEB-INF/views/layout/head.jsp" />
<c:import url="/WEB-INF/views/layout/header.jsp" />
<!-- header end -->

<!-- 개별 스타일 및 스크립트 영역 -->

<script>

/* confirm 사용 예시 */
function btnUpdateY(t) {
    action_popup.confirm("되돌릴 수 없습니다. 정말로 삭제 하시겠습니까?", function (res) {
        if (res) {
        	
        	/* ----------------------------------------- */
        	
        	location.href="/mypage/item/yes?itemNo="+t
        	
        	/* ----------------------------------------- */
           
        }
    })
    
    /* 닫는 창으로 꼭 필요함 */
    $(".modal_close").on("click", function () {
        action_popup.close(this);
    });
    
};

</script>


<style>
.titlearea {
	margin: 50px 0 30px 0;
}

body {
	background-color: #f2f2f2;
}
</style>

<!-- 개별 영역 끝 -->

<div class="wrap">
<div class="container">


<c:import url="/WEB-INF/views/layout/myPageSideMenu.jsp" />

<div class="col-md-9" style="height: 500px;">
<div class="titlearea">
	<h3>결제 체크 리스트</h3>
</div>
<table class="table table-hover">
	<tr>
		<th style="width:20%"><strong>상품명</strong></th>
		<th style="width:12%"><strong>가격</strong></th>
		<th style="width:8%"><strong>조회수</strong></th>
		<th style="width:12%"><strong>작성일</strong></th>
		<th style="width:12%"><strong>투표 마감일</strong></th>
		<th style="width:27%"><strong>상태</strong></th>
	</tr>
	
	<c:forEach items="${list }" var="list">
	<tr>
		<td><a href="<%=request.getContextPath() %>/ask/detail?askNo=${list.ITEM_NO }">${list.ITEM_NAME }</a></td>
		<td>${list.ITEM_PRICE }</td>
		<td>${list.ASK_HIT }</td>
		<td><fmt:formatDate value="${list.ASK_DATE }" pattern="yy-MM-dd" /></td>
		<td><fmt:formatDate value="${list.VOTE_END }" pattern="yy-MM-dd" /></td>
		<c:if test="${list.ITEM_STATUS == 'n'&& empty list.ITEM_DATE}">
			<td>
				<a><button class="btnUpdateY" onclick="btnUpdateY(${list.ITEM_NO});">살게요!</button></a>
				<a href="<%=request.getContextPath() %>/mypage/item/no?itemNo=${list.ITEM_NO }"><button class="btnUpdateN" onclick="if(!confirm('구매하지않음으로 설정하시겠습니까?')){return false;}">안살게요!</button></a>
			</td>
		</c:if>
		<c:if test="${list.ITEM_STATUS == 'n'&& not empty list.ITEM_DATE}">
			<td>안살래요</td>
		</c:if>
		<c:if test="${list.ITEM_STATUS == 'y' && not empty list.ITEM_DATE && empty list.REVIEW_NO }">
			<td><a href="<%=request.getContextPath() %>/review/write?askNo=${list.ITEM_NO }"><button class="btnWrite" onclick="if(!confirm('리뷰 작성하기 페이지로 이동하시겠습니까?')){return false;}">리뷰 작성</button></a>
			<a href="<%=request.getContextPath() %>/mypage/item/cancel?itemNo=${list.ITEM_NO }"><button class="btnCancel" onclick="if(!confirm('구매 철회하시겠습니까?')){return false;}">구매 취소</button></a></td>
		</c:if>	
		<c:if test="${list.ITEM_STATUS == 'y' && not empty list.ITEM_DATE && not empty list.REVIEW_NO }">
			<td><a href="<%=request.getContextPath() %>/review/detail?reviewNo=${list.REVIEW_NO }"><button class="btnDetail">후기 확인</button></a></td>
		</c:if>
	</tr>
	</c:forEach>
</table>
<c:import url="/WEB-INF/views/layout/paging.jsp" />
</div>



</div><!-- .container end -->
</div><!-- .wrap end -->

<!-- footer start -->
<c:import url="/WEB-INF/views/layout/footer.jsp" />


