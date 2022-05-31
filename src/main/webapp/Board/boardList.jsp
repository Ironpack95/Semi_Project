<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>술이주夜 - 리뷰게시판</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet" type="text/css" href="../CSS/board.css">
</head>
<body>
	<jsp:include page="common/header.jsp" />
	<div class='boardBody'>
		<div class='boardDiv' style="font-family: 'Hahmlet', serif;">
			<div class='btn_under'>
				
				<button class='down_board' onclick="location.href='boardList.board?type=3&cpage=1'">인기글모아보기</button>
				<button class='down_board'
					onclick="location.href='boardList.board?type=0&cpage=1'">전체
					보기</button>
				<button class='down_board'
					onclick="location.href='boardList.board?type=1&cpage=1'">조회
					순</button>
				<button class='down_board'
					onclick="location.href='boardList.board?type=2&cpage=1'">최근
					작성 순</button>
				<!-- <button class='down_board'>태그별 보기</button> -->
				<div class='btn_write'>
					<button class='down_write'
						onclick="if(${loginID != null}) {location.href='/boardAddPage.board'}else{alert('로그인 후 작성할 수 있습니다')};">글쓰기</button>
				</div>
			</div>
			<div class='boardTable' style="font-family: 'Hahmlet', serif;">
				<div class="boardlist2 row col-12 listoff" style="margin: 0%">
					<div class="col-lg-2 col-sm-3">번호</div>
					<div class="col-lg-2 col-sm-3">작성자</div>
					<div class="col-lg-2 col-sm-3">제목</div>
					<div class="listoff col-lg-2">조회</div>
					<div class="listoff col-lg-2">추천</div>
					<div class="col-lg-2 col-sm-3">날짜</div>
				</div>
					<c:choose>
						<c:when test="${empty list}">
							<div>현재 등록된 게시글이 없습니다.</div>
						</c:when>
						<c:otherwise>
							<c:forEach var="list" items="${list}">
									<div class='boardSelect boardlist row col-12' data-id='${list.boardNum}' style="margin:0%;">
										<div class="col-lg-2 col-sm-3">${list.boardNum}</div>
										<div class="col-lg-2 col-sm-3">${list.writer}</div>
										<div class="boardTitleTd col-lg-2 col-sm-3">${list.title}</div>
										<div class="listoff col-lg-2">${list.boardCount}</div>
										<div class="listoff col-lg-2">${list.boardLike}</div>
										<div class="col-lg-2 col-sm-3"><fmt:formatDate pattern="yyyy-MM-dd" value="${list.writeDate}"/></div>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
			</div>
			
			<%-- <div class="row bd nav">
				<div class="col">${navi}</div>
			</div> --%>
			
			<nav aria-label="Page navigation example">
									<ul class="pagination justify-content-center">${navi}</ul>
								</nav>
			
			<form action=/boardList.board align="center">
				<select name="selectType">
					<option value="1">제목</option>
					<option value="2">작성자</option>
				</select> 
				<input type="text" class='boardSearch' name="boardSearch">
				
				<button class='boardSearchBtn'>검색하기</button>
				
			</form>
		</div>
	</div>
	<script>
		$(document).on("click",".boardSelect",function(){
			var num = $(this).data("id");
			$(location).attr('href',"boardSelect.board?num="+num);
		});
		
		$(document).on("click","#boardSearchBtn",function(){
			
		});
		
	</script>
	<jsp:include page="common/footer.jsp" />
</body>
</html>