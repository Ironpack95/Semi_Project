<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
<!-- CSS -->
<link rel="stylesheet" href="/CSS/reply.css">
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
						<a class="navbar-brand" href="index.jsp"> <img alt=""
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
								class="nav-link mx-0 mx-0 mx-md-0 mx-lg-3">우리 술 검색</a></li>


							<li class="nav-item"><a
								class="nav-link mx-0 mx-md-0
									mx-lg-3"
								href="/boardList.board" id="board">술꾼 술꾼</a></li>
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
								placeholder="Search" aria-label="Search" name="search_text"
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
										<li><a class="dropdown-item" href="/logout.member"
											id="kakaologout">로그아웃</a></li>
									</ul>
								</div>
							</c:when>

							<c:otherwise>
								<button id="loginBtn" type="button"
									class="mx-1 d-none d-lg-inline btn btn-warning navbar-btn">로그인</button>
								<button id="joinBtn" type="button"
									class="mx-1 d-none d-lg-inline btn btn-dark navbar-btn">회원가입</button>

								<script>
									$("#loginBtn").on("click",function(){
										location.href="/Member/loginView.jsp";
									})
									$("#joinBtn").on("click",function(){
										location.href="/Member/joinView.jsp";
									})
								</script>
							</c:otherwise>
						</c:choose>

					</div>
				</div>
			</nav>
		</header>


		<!----------------------------------- Content 2 ----------------------------------->
		<div class="row">
			<div class="col-12" id="content2">

				<div id="container">
					<div id="top_line"></div>
					<div id="head">
						<c:choose>
							<c:when test="${board.boardSatus == 2}">
								<div class="row col-12">
									<div class="board_title col-lg-10 col-md-12">글 제목 :
										${board.title}</div>
									<div style="color: red" class="col-lg-2 col-md-12">[신고된게시글]</div>
								</div>
							</c:when>
							<c:otherwise>
								<div class="board_title">글 제목 : ${board.title}</div>
							</c:otherwise>
						</c:choose>
					</div>
					<div id="top_line"></div>
					

					<div style="position:relative; min-height: 80px; font-family: 'Hahmlet', serif;">
						<div id="head1" class="row.col-12">
						<div class='product_img'>
							<img src="/img/productFile/${product.oriName}">
						</div>
						<div class='product_name'>
							${product.product_name}
						</div>
						<div class='product_exp'>
							${product.smry}
						</div>
						<c:choose>
							<c:when test="${board.score == '1'}">
								<div class='pc'>평점 : ★ (${board.score})</div>
								<div class='mo'>${board.score}점</div>
							</c:when>

							<c:when test="${board.score == '2'}">
								<div class='pc'>평점 : ★★ (${board.score})</div>
								<div class='mo'>${board.score}점</div>
							</c:when>

							<c:when test="${board.score == '3'}">
								<div class='pc'>평점 : ★★★ (${board.score})</div>
								<div class='mo'>${board.score}점</div>
							</c:when>

							<c:when test="${board.score == '4'}">
								<div class='pc'>평점 : ★★★★ (${board.score})</div>
								<div class='mo'>${board.score}점</div>
							</c:when>

							<c:otherwise>
								<div class='pc'>평점 : ★★★★★ (${board.score})</div>
								<div class='mo'>${board.score}점</div>
							</c:otherwise>
						</c:choose>
						</div>
						<div id="head2" class="row.col-12">
							<div class="board_like .col-6">조회수 : ${board.boardCount}</div>
							<div class="board_writer .col-6">작성자 : ${board.writer}</div>
							<div class="board_date .col-6">작성일 : <fmt:formatDate pattern="yy년MM월dd일 hh시mm분" value="${board.writeDate}"/></div>
						</div>
					</div>
					<div id="top_line"></div>

					

					<div id="head3">
						<div class="board_contents">${board.boardExp}</div>
					</div>

					<div id="top_line"></div>


					<div id="head5" style="position: relative;">
						<div class="reply_cont disnone">
							총 댓글 : 0
						</div>
						<c:forEach var="reply" items="${reply}" varStatus="stat">
							<script class="scriptDelte">
								$(".reply_cont").text("총 댓글 : ${stat.count}");
								if (${ stat.last }) {
									$(".scriptDelte").remove();
								}
							</script>
						</c:forEach>
						<div class="like_cont disnone">추천 : ${board.boardLike}</div>
						<c:choose>
							<c:when test="${boardLike > 0}">
								<input type="button" class="like_btn" value="추천취소"
								onclick="if(${loginID != null}) {location.href='/boardLikeDelete.board?num=${board.boardNum}'}else{alert('로그인 후 추천할 수 있습니다')};">
							</c:when>
							<c:otherwise>
								<input type="button" class="like_btn" value="추천하기"
								onclick="if(${loginID != null}) {location.href='/boardLike.board?num=${board.boardNum}'}else{alert('로그인 후 추천할 수 있습니다')};">
							</c:otherwise>
						</c:choose>
						
						<c:if test="${ loginID != 'admin' and loginID != board.writer}">
						<input type="button" class="like_btn" value="신고하기"
							onclick="if(${loginID != null}) {if(${board.boardSatus} == 2){alert('이미 신고된 게시글 입니다.')}else{if(confirm('정말로 신고하시겠습니까?')){location.href='/boardSet.board?num=${board.boardNum}&stat=2'}}}else{alert('로그인 후 신고할 수 있습니다')};">
						</c:if>
						
						
						<c:if test="${board.writer == loginID}">
							<div style="position: absolute; right: 0px; top: 0px;">
								<input type="button" class="like_btn" value="수정하기"
									onclick="location.href='/boardUpdate.board?num=${board.boardNum}'">
								<input type="button" class="like_btn" value="삭제하기"
									onclick="if(confirm('정말로 삭제하시겠습니까?')){location.href='/boardSet.board?num=${board.boardNum}&stat=1'}">
							</div>
						</c:if>
					</div>

					<!--  댓글 입력 창 -->
					<c:choose>
						<c:when test="${loginID == null}">
							<div style="color:#278f59">로그인을 하셔야 댓글을 등록하실 수 있습니다.</div>
						</c:when>
						
						<c:otherwise>						
						 
							<form
								action="/add.board?parent_seq=${board.boardNum}&writer=${loginID}"
								method="post">
		
								<div id="reply_box" class="row col-lg-12">
									<div class="col-lg-10 col-md-8 col-xs-6" style="resize: none;">
										<textarea id="textadd" placeholder="댓글 내용을 입력하세요." name='content'
											class="textarea"></textarea>
									</div>
									<div class="rebt col-lg-2 col-md-4 col-xs-6"
										style="margin: auto;">
										<input id="reply" type="submit" class="reply_btn" value="확인">
									</div>
								</div>
		
							</form>
						</c:otherwise>
						
						</c:choose>

					<div id="top_line"></div>

					<!-- 댓글 출력 및 편집 부분 -->
					<c:choose>
					
						<c:when test="${empty reply}">
						</c:when>
						
						<c:otherwise>
						
							<c:forEach var="i" items="${reply}">
							
								<form
									action="modify.board?pseq=${board.boardNum}&seq=${i.replySeq}"
									method="post" id="modifyFrm" enctype="multipart/form-data">
									
									<div class="reply_view" style="margin-top: 3%; margin-bottom:3%;">${i.writer}|<fmt:formatDate pattern="yy년MM월dd일 HH시mm분" value="${i.wirteDate}"/></div>
									
									<div class="head6">
									
										<div class="reply_contents" style="border: none; overflow-y:auto;">
											<pre style="font-family: 'Hahmlet', serif;">${i.cotents}</pre>
										</div>
										
										<input name='contents' value="${i.cotents}"
											style="display: none; width: 50%;">
											
										 <input type="hidden" id="contentsInput"
											name="reply_contents">
											
										<c:choose>
										
											<c:when test="${loginID == i.writer}">
											
												<input type="hidden" class="reply_seq" value="${i.replySeq}">
												<button class="head6_btn modify" type="button">수정</button>
												<button class="head6_btn delRbtn" type="button">삭제</button>
												
											</c:when>
											
										</c:choose>
										
									</div>
									
								</form>
								
							</c:forEach>
							
						</c:otherwise>

					</c:choose>
					
					<br>
					
					<input type="button" value="목록" class="list_btn" 
					 style="width: 150px; height: 70px; margin-left: 45%; background-color:#278f59; border:none; color:white;">
				
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
	<!-- 댓글 관련 스크립트 작성 -->

	<script>
	
		$("#reply").on("click", function() {
		
			let text = $("#textadd").val();
			if (text.replace(/\s|　/gi, "").length == 0){
				alert("댓글을 입력해 주세요.");
				return false;
			}
		})
		
	
		$(".modify").on("click", function () {

			$(this).siblings(".reply_contents").next().show();
			$(this).siblings(".reply_contents").hide();
			$(this).css("display", "none");
			$(this).siblings(".delRbtn").css("display", "none");

			let okBtn = $("<button>");
			okBtn.text("수정완료");
			okBtn.attr("type", "submit");
			okBtn.attr("class", "head6_btn");

			let cancelBtn = $("<button>");
			cancelBtn.attr("type", "button");
			cancelBtn.attr("class", "head6_btn");
			cancelBtn.text("취소");

			cancelBtn.on("click", function () {
				location.reload();
			})

			$(this).parent().append(okBtn);
			$(this).parent().append(cancelBtn);

		});

		$("#modifyFrm").on("submit", function () {
			$("#contentsInput").val($("#reply_contents").text());
		});

		$(".delRbtn").on("click", function () {

			let result = confirm("댓글을 삭제하시겠습니까?");
			let reply_seq = $(this).siblings(".reply_seq").val();

			if (result) {

				$.ajax({
					url: "/del.board",
					data: { "seq": reply_seq, "pseq": "${board.boardNum}" }
				}).done(function (resp) {
					location.reload();
				});

			} else {

			}

		});
		
		$(".list_btn").on("click",function(){
			location.href="/boardList.board";
		})
		
	</script>


	<!----------------------------------- footer ----------------------------------->




</body>

</html>
