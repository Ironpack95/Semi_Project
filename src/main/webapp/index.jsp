<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
	<!-- CSS -->
	<link rel="stylesheet" href="/CSS/index.css">
	<!-- 경로 수정 고려 -->

	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<!-- Jquery -->
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

	<!-- Bootstrap ver 5.1  -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>

	<script src="https://kit.fontawesome.com/7f0130da7d.js" crossorigin="anonymous"></script>

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
										href="/productA20.ProductController?cpage=1">전통소주</a></li>
									<li><a class="dropdown-item"
										href="/productA30.ProductController?cpage=1">약주</a></li>
									<li><a class="dropdown-item"
										href="/productA40.ProductController?cpage=1">과실주</a></li>
									<li><a class="dropdown-item"
										href="/productA50.ProductController?cpage=1">리큐르</a></li>
									<li>
										<hr class="dropdown-divider">
									</li>
									<li><a class="dropdown-item" href="/list.ProductController?cpage=1">전체보기</a></li>


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
								<c:when test="${kakaoemail != null}">

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
								placeholder="우리술을 검색하세요!" aria-label="Search" name="search_text"
								required>
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

							<c:when test="${kakaoemail !=null}">
								<div class="d-none d-lg-inline btn-group">
									<button type="button" class="btn btn-warning dropdown-toggle"
										data-bs-toggle="dropdown" aria-expanded="false">
										${kakaoemail }</button>
									<ul class="dropdown-menu">
										<li><a class="dropdown-item" href="/mypage.member">마이페이지</a></li>
										<li><a class="dropdown-item" href="/logout.member">로그아웃</a></li>
									</ul>
								</div>
							</c:when>

							<c:otherwise>
								<button id="loginBtn" type="button"
									class="mx-1 d-none d-lg-inline btn btn-warning navbar-btn">로그인</button>
								<button id="joinBtn" type="button"
									class="mx-1 d-none d-lg-inline btn btn-dark navbar-btn">회원가입</button>

								<script>
									$("#loginBtn")
											.on(
													"click",
													function() {
														location.href = "/Member/loginView.jsp";
													})
									$("#joinBtn").on("click", function() {
										location.href = "/Member/joinView.jsp";
									})
								</script>
							</c:otherwise>
						</c:choose>


					</div>
				</div>
			</nav>
		</header>


		<div class="row" id="main">
			<div class="col-12" id="contents">
				<div id="carouselExampleIndicators" class="carousel slide"
					data-bs-ride="carousel">
					<div class="carousel-indicators">
						<button type="button" data-bs-target="#carouselExampleIndicators"
							data-bs-slide-to="0" class="active" aria-current="true"
							aria-label="Slide 1"></button>
						<button type="button" data-bs-target="#carouselExampleIndicators"
							data-bs-slide-to="1" aria-label="Slide 2"></button>
						<button type="button" data-bs-target="#carouselExampleIndicators"
							data-bs-slide-to="2" aria-label="Slide 3"></button>
					</div>
					<div class="carousel-inner">
						<div class="carousel-item active">
							<img src="/img/indexFile/3.png" class="d-block w-100 h-auto"
								alt="...">
						</div>
						<div class="carousel-item">
							<img src="/img/indexFile/1.png" class="d-block w-100 h-auto"
								alt="...">
						</div>
						<div class="carousel-item">
							<img src="/img/indexFile/2.png" class="d-block w-100 h-auto"
								alt="..." style="border: 3px solid black;">
						</div>
					</div>
					<button class="carousel-control-prev" type="button"
						data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Previous</span>
					</button>
					<button class="carousel-control-next" type="button"
						data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Next</span>
					</button>
				</div>
			</div>




			<div class="row mb-3" id="popular text">
				<div class="col-12"
					style="text-align: center; font-family: 'Hahmlet', serif; margin-top: 100px;">
					<h2>인기상품</h2>

				</div>
			</div>

			<div class="row m-auto">

				<div class="col-12 col-lg-4">
					<a class="tag_a" href="/Detail.ProductController?seq=4">
						<div class="Result_img">
							<img src="../thumbnail/baekjae25.png" class="w-100">
						</div>
						<div class="Result_txt" style="text-align: center;">
							<div class="review"></div>
							<p class="Result_name">백제소주 25</p>
							<p class="Result_decs">전통을 위한, 전통에 의한</p>
						</div>
					</a>
				</div>

				<div class="col-12 col-lg-4">
					<a class="tag_a" href="/Detail.ProductController?seq=2">
						<div class="Result_img">
							<img src="../thumbnail/albam.png" class="w-100">
						</div>
						<div class="Result_txt" style="text-align: center;">
							<div class="review"></div>
							<p class="Result_name">톡쏘는 알밤 동동</p>
							<p class="Result_decs">MZ감성에 맞는 달달구리</p>
						</div>
					</a>
				</div>

				<div class="col-12 col-lg-4">
					<a class="tag_a" href="/Detail.ProductController?seq=34">
						<div class="Result_img">
							<img src="../thumbnail/ggulsam.png" class="w-100">
						</div>
						<div class="Result_txt" style="text-align: center;">
							<div class="review"></div>
							<p class="Result_name">꿀샘 16</p>
							<p class="Result_decs">국산 천연 꿀로 만든 달콤한 술</p>
						</div>
					</a>
				</div>
			</div>


			<div class="row mt-5 m-auto" id="bti text">
				<div class="col-12 m-auto" style="text-decoration: none;">
					<a href="https://ktestone.com/kapable.github.io/dringkingHabit/">

						<img src="/img/indexFile/술BTI.png" class="d-block w-100 h-auto">

					</a>
				</div>
			</div>

			<div class="row" id="video text">
				<div class="col-12"
					style="text-align: center; font-family: 'Hahmlet', serif; margin-top: 100px;">
					<h2>백종원의 술비책</h2>
				</div>
			</div>
			<div class="row mb-3" id="video">
				<div class="col-12" style="text-align: center;">
					<video controls style="width: 80%; height: auto; margin-top: 50px;">
						<source src="/img/indexFile/하면 할수록 빠져든다... 집에서 빚는 우리 술 우리 막걸리.mp4">
					</video>
				</div>
			</div>

		</div>

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


	<script>
		$("#join").on("click", function() {
			location.href = "/Member/joinView.jsp";
		})
		$("#login").on("click", function() {
			location.href = "/Member/loginView.jsp";
		})

		$("#board").on("click", function() {
			location.href = "/Board/boardList.jsp";
		})
	</script>



</body>

</html>