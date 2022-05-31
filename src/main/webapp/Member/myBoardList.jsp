<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<!-- CSS -->
<link rel="stylesheet" href="/CSS/myPage.css">
<!-- 경로 수정 고려 -->

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Jquery -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<!-- Bootstrap ver 5.1  -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>

<script src="https://kit.fontawesome.com/7f0130da7d.js"
	crossorigin="anonymous"></script>

<title>우리술夜</title>
</head>

<body>
	<div class="container">
		<header class="mb-5 pt-3">
			<nav class="navbar navbar-expand-lg navbar-light bg-white">
				<div class="container-fluid">
					<div class="navbar-header mx-2">
						<a class="navbar-brand" href="/index.jsp"> <img alt=""
							src="/img/logo2.jpg" id="logo"> <!-- 경로 수정 고려 -->
						</a>
					</div>

					<!-- <a class="navbar-brand" href="#">
          <img src="/img/logo2.jpg" id="logo">
        </a> -->

					<button class="navbar-toggler" type="button"
						data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
						aria-controls="navbarSupportedContent" aria-expanded="false"
						aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
						<ul class="navbar-nav me-auto mb-2 mb-lg-0">
							<li class="nav-item dropdown"><a
								class="nav-link dropdown-toggle mx-0 mx-md-0 mx-lg-3" href="#"
								id="navbarDropdown" role="button" href=""
								data-bs-toggle="dropdown" aria-expanded="false"> 우리술 정보 </a>
								<ul class="dropdown-menu" aria-labelledby="navbarDropdown">

									<li><a class="dropdown-item"
										href="/productA10.ProductController?cpage=1">막걸리</a></li>
									<li><a class="dropdown-item"
										href="/productA20.ProductController?cpage=1">전통 소주</a></li>
									<li><a class="dropdown-item"
										href="/productA30.ProductController?cpage=1">약주</a></li>
									<li><a class="dropdown-item"
										href="/productA40.ProductController?cpage=1">과실주</a></li>
									<li><a class="dropdown-item"
										href="/productA50.ProductController?cpage=1">리큐르</a></li>

									<li>
										<hr class="dropdown-divider">
									</li>
									<li><a class="dropdown-item"
										href="/list.ProductController?cpage=1">전체보기</a></li>
								</ul></li>

							<li class="d-none d-lg-block nav-item"><a
								href="/Search/search.jsp"
								class="nav-link mx-0 mx-0 mx-md-0 mx-lg-3">우리술 검색</a></li>


							<li class="nav-item"><a
								class="nav-link mx-0 mx-md-0 mx-lg-3" href="/boardList.board"
								id="board">술꾼 술꾼</a></li>
							<c:choose>
								<c:when test="${loginID != null}">

									<li class="nav-item d-lg-none"><a
										class="nav-link mx-0 mx-md-0 mx-lg-3" href="/mypage.member"
										id="board">내 정보</a></li>

									<li class="nav-item d-lg-none"><a
										class="nav-link mx-0 mx-md-0 mx-lg-3" href="/logout.member"
										id="board">로그아웃</a></li>

								</c:when>

								<c:otherwise>

									<li class="nav-item d-lg-none"><a
										class="nav-link mx-0 mx-md-0 mx-lg-3"
										href="/Member/loginView.jsp" id="board">로그인</a></li>

									<li class="nav-item d-lg-none"><a
										class="nav-link mx-0 mx-md-0 mx-lg-3"
										href="/Member/joinView.jsp" id="board">회원가입</a></li>

								</c:otherwise>
							</c:choose>

							<c:choose>
								<c:when test="${loginID eq 'admin'}">
									<li class="nav-item"><a
										class="nav-link mx-0 mx-0 mx-md-0 mx-lg-3"
										href="/Manager/manager.jsp" id="board">관리자 페이지</a></li>
								</c:when>

								<c:otherwise>

								</c:otherwise>
							</c:choose>

						</ul>
						<form action="/mini.search" class="d-flex">
							<input id="search_input" class="form-control mx-1" type="search"
								placeholder="원하시는 술을 검색하세요" aria-label="Search"
								name="search_text" required>
							<button class="btn btn-outline-success me-1" type="submit"
								id="search_btn">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
									fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
									<path
										d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
								</svg>
							</button>
						</form>

						<c:choose>
							<c:when test="${loginID != null}">
								<div class="d-none d-lg-inline btn-group">
									<button type="button" class="btn btn-warning dropdown-toggle"
										data-bs-toggle="dropdown" aria-expanded="false">
										${loginID }</button>
									<ul class="dropdown-menu">
										<li><a class="dropdown-item" href="/mypage.member">마이페이지</a></li>
										<li><a class="dropdown-item" href="/logout.member">로그아웃</a></li>
									</ul>
								</div>

							</c:when>
							<c:otherwise>
								<button id=login type="button"
									class="mx-1 d-none d-lg-inline btn btn-warning navbar-btn">로그인</button>
								<button id=join type="button"
									class="mx-1 d-none d-lg-inline btn btn-dark navbar-btn">회원가입</button>
							</c:otherwise>
						</c:choose>

					</div>
				</div>
			</nav>
		</header>

		<script>
			$("#join").on("click", function() {
				location.href = "/Member/joinView.jsp";
			})
			$("#login").on("click", function() {
				location.href = "/Member/loginView.jsp"
			})
		</script>




		<!----------------------------------- Content ----------------------------------->
		<div class="row" id="mypage">
			<div class="col-12" id="mypage_text">
				<h1>게시판 모아보기</h1>
			</div>
		</div>
		<div class="row" id="content">
			<div class="col-12 col-md-3 d-none d-lg-block" id="mypage list">
				<ul class="list-group list-group-flush">
					<a href="/mypage.member"
						class="list-group-item list-group-item-action">회원정보 수정</a>
					<a href="/Member/memberOut.jsp"
						class="list-group-item list-group-item-action">회원탈퇴</a>
					<a href="/myboard.board?cpage=1"
						class="list-group-item list-group-item-action">게시글 모아보기</a>

				</ul>

			</div>
			<div class="col-12 d-lg-none" id="navmenu">
				<nav class="nav nav-pills nav-fill">
					<a class="nav-link" href="/mypage.member">회원정보 수정</a> <a
						class="nav-link" href="/Member/memberOut.jsp">회원탈퇴</a> <a
						class="nav-link" href="/myboard.board?cpage=1">게시글 모아보기</a>

				</nav>
			</div>

			<div class="col-12 col-lg-9" id="myboard list">
				<table class="table table-hover">

					<thead class="table-success " style="text-align: center;">
						<th>
						<td colspan="1">#</td>
						<td colspan="6">제목</td>
						<td colspan="2">작성자</td>
						<td colspan="3">날짜</td>
						</th>
					</thead>

					<!-- 반복문 돌릴 예정 : board_num이 value임 -->
					<c:forEach var="i" items="${list}">

						<tbody style="text-align: center;">
							<th>
							<td colspan="1"><a
								href="/boardSelect.board?num=${i.board_num}"
								style="color: black; text-decoration-line: none;">
									${i.board_num}</a></td>
							<td colspan="6"><a
								href="/boardSelect.board?num=${i.board_num}"
								style="color: black; text-decoration-line: none;"> ${ i.title }
							</a></td>
							<td colspan="2"><a
								href="/boardSelect.board?num=${i.board_num}"
								style="color: black; text-decoration-line: none;">${ i.writer }</a></td>
							<td colspan="3"><a
								href="/boardSelect.board?num=${i.board_num}"
								style="color: black; text-decoration-line: none;">${ i.formedDate }</a></td>
							</th>
						</tbody>

					</c:forEach>
				</table>
			<div class="col-12 mb-2 mt-1">
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">${navi}</ul>
				</nav>
			</div>
			</div>
		</div>




		<!----------------------------------- footer ----------------------------------->


		<hr>
		<footer class="site-footer">

			<div class="container">
				<div class="row">
					<div class="d-none d-lg-block col-md-8 col-sm-6 col-xs-12">
						<p class="copyright-text">
							Copyright &copy; 2022 All Rights Reserved by <a href="#"
								style="text-decoration: none;">아이코올</a>.
						</p>
					</div>

					<div class="d-lg-none col-md-8 col-sm-6 col-xs-12">
						<p class="copyright-text">Copyright &copy;</p>
						<p class="copyright-text">
							2022 All Rights Reserved by <a href="#"
								style="text-decoration: none;">아이코올</a>.
						</p>
					</div>

					<div class="col-md-4 col-sm-6 col-xs-12 my-3 my-lg-0">
						<ul class="social-icons">
							<li><a class="facebook" href="#"><i
									class="fa fa-facebook"></i></a></li>
							<li><a class="twitter" href="#"><i class="fa fa-twitter"></i></a></li>
							<li><a class="dribbble" href="#"><i
									class="fa fa-dribbble"></i></a></li>
							<li><a class="linkedin" href="#"><i
									class="fa fa-linkedin"></i></a></li>
						</ul>
					</div>
				</div>
			</div>
		</footer>
	</div>

</body>

</html>