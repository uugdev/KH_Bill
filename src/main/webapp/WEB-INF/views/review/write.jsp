<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!doctype html>
<html lang="ko">
<head>
    <%--page title--%>
    <title>이건못참조</title>
	<c:import url="/WEB-INF/views/layout/head.jsp" />
</head>
<body>
<%--header--%>
<c:import url="/WEB-INF/views/layout/header.jsp" />

<!-- 스마트 에디터 2 라이브러리 로드 -->
<script type="text/javascript" src="/resources/se2/js/service/HuskyEZCreator.js"></script>

<script type="text/javascript">
function submitContents(elClickedObj) {
	oEditors.getById["reviewContent"].exec("UPDATE_CONTENTS_FIELD", []);
	
	try {
		elClickedObj.form.submit();
	} catch(e) {}
}

$(document).ready(function() {
	$("#btnWrite").click(function() {
		submitContents($("#btnWrite"));
		
		$("form").submit();
	})
	
	$("#cancel").click(function() {
		history.go(-1);
	})
})
</script>

<div class="wrap">
<div class="container">

<h1>후기 글쓰기 페이지</h1>
<hr>

<form action="/review/write" method="post" enctype="multipart/form-data">
<div class="form-group">
	<label for="userNick">작성자</label>
	<input type="text" id="userNick" value="${userNick }" class="form-control" readonly="readonly"/>
</div>
<div class="form-group">
	<label for="reviewTitle">제목</label>
	<input type="text" id="reviewTitle" name="reviewTitle" class="form-control"/>
</div>


<div class="form-group">
	<label for="itemBrand">브랜드</label>
	<input type="text" id="itemBrand" value="${item.itemBrand }"  name="itemBrand" class="form-control" readonly="readonly"/>
</div>
<div class="form-group">
	<label for="itemName">상품명</label>
	<input type="text" id="itemName" value="${item.itemName }"  name="itemName" class="form-control" readonly="readonly"/>
</div>
<div class="form-group">
	<label for="itemPrice">가격</label>
	<input type="text" id="itemPrice"value="${item.itemPrice }"   name="itemPrice" class="form-control" readonly="readonly"/>
</div>

<div class="form-group">
	<label for="file">첨부파일</label>
	<input type="file" id="file" name="file" />
</div>

<div class="form-group">
	<label for="reviewContent">본문</label>
	<textarea rows="10" style="width: 100%;" id="reviewContent" name="reviewContent"></textarea>
</div>


<div class="text-center">
	<button class="btn btn-primary" id="btnWrite">작성</button>
	<input type="reset" id="cancel" class="btn btn-danger" value="취소"/>
</div>
</form>

<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "reviewContent",
	sSkinURI: "/resources/se2/SmartEditor2Skin.html",
	fCreator: "createSEditor2"
});
</script>

</div><!-- .container -->
</div><!-- .wrap end -->

<%--footer--%>
<c:import url="/WEB-INF/views/layout/footer.jsp" />
