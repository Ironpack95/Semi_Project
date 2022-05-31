<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
<!-- CSS -->
<link rel="stylesheet" href="/CSS/login.css">
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

<!-- 카카오 API -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<!-- 네이버 API 관련 -->
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>


<title>우리술夜</title>
</head>

<body>
	<div class="container m-auto">
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
								placeholder="로그인하지 말고 술 찾아요" aria-label="Search"
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
										<li><a class="dropdown-item"
											href="javascript:secession();">로그아웃</a></li>
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


		<!----------------------------------- Content ----------------------------------->
		<div class="container" style="width: 360px;">
			<form action="/login.member" method="post">
				<div style="text-align: center;">
					<h3>로그인</h3>
				</div>
					<div>
						<input type="text" class="textBox" id="id" name="id"
							placeholder="아이디">
					</div>
				<div><input type="password" class="textBox" id="pw" name="pw" placeholder="비밀번호"></div>
            <div id="search">
            <a href="/Member/searchId.jsp" id="searchIdbtn">아이디 찾기</a>
            <a href="/Member/searchPw.jsp" id="searchPwbtn">비밀번호 찾기</a>
            <div id="why"></div>
             </div>
             <div style="text-align: center;">
            <input type="submit" class="btn btn-outline-success" id="loginBtn_in" value="로그인하기">
            <input type="button" class="btn btn-outline-success" id="joinBtn_in" value="회원가입">
            </div>
    	</form>
   	 		<script>
	 			$("#loginBtn_in").on("click",function(){
	 				let id = $("#id").val();
	 				let idRegex = /^[\da-z_]{8,13}$/; //영어 소문자, 숫자, 언더바 8~13글자
	 				let idResult = idRegex.test(id);
	 				let pw = $("#pw").val();
	 				let pwRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,16}$/; //영문, 숫자를 하나 이상 포함한 8~16자
	 				let pwResult = pwRegex.test(pw);
	 				
	 				//아이디나 비번 빈값일 때
	 				if($("#id").val() ==""||$("#pw").val() == ""){
	 					alert("아이디 또는 비밀번호를 입력해주세요.");
	 					return false;
	 				//아이디나 비번이 유효성에 맞지 않을 때
	 				} else if(!idResult||!pwResult){
	 					if($("#id").val()=="admin"){
	 						alert("관리자 계정입니다.");
	 					} else {
		 					alert("아이디 또는 비밀번호를 형식에 맞게 입력해주세요.");
		 					$("id").val("");
		 					$("pw").val("");
		 					$("id").focus();
	 					}
	 				}
	 				//아이디나 비번이 유효성은 맞는데 틀렸을 때
	 				if(idResult&&pwResult){
		 				$.ajax({
	 						url:"/logincheck.member",
	 						type: "post",
							data: {id:$("#id").val(), pw:$("#pw").val()}
	 					}).done(function(resp){
	 						if(resp=="false"){
	 							alert("아이디 또는 비밀번호를 잘못 입력했습니다. 입력하신 내용을 다시 확인해주세요.");
	 							location.href="/Member/loginView.jsp";
	 						}
	 					})
		 				}
	 			});
	 			
	 			$("#joinBtn_in").on("click",function(){
	 				location.href="/Member/joinView.jsp";
	 			})
 			</script>
            <hr>
            <div class="sns">
                <div id="kakao" style="text-align: center;">
                <a id="kakao-login-btn" >
                    <img src="/img/loginFile/kakao_login_medium_narrow.png"></a>
				
<!--                     <a href="javascript:secession();">카카오 연동 해제</a> -->
                </div>
                <div id="test">
                </div>
            </div>
            	</div>

		<script>
			//카카오 로그인
			//a90276ed357ed7ce1c45d0863f399e1d 키값
			Kakao.init('a90276ed357ed7ce1c45d0863f399e1d');

			$("#kakao-login-btn").on("click", function() {
				//1. 로그인 시도
				Kakao.Auth.login({
					success : function(authObj) {
						//2. 로그인 성공시, API 호출
						Kakao.API.request({
							url : '/v2/user/me',
							success : function(res) {
								console.log(res);
								let accessToken = Kakao.Auth.getAccessToken(); // 액세스 토큰 할당
								Kakao.Auth.setAccessToken(accessToken); // 액세스 토큰 사용하게 등록
								//scope : 'account_email';
								let id = res.id;
								let name = res.properties.nickname;
								let email = res.kakao_account.email;
								let birthday = res.kakao_account.birthday;
								console.log(accessToken);

								$.ajax({
									url : "/kakaologin.member",
									// 							contentType : "application/json; charset:UTF-8",
									data : {
										id : id,
										name : name,
										email : email,
										birthday : birthday,
										token: accessToken
									},
									type : "POST",
									dataType : "json",
								}).done(function(resp) {
									console.log(resp);
								})
								alert("카카오계정으로 로그인 되었습니다.");
								location.href = "/index.jsp";
							}
						})
						console.log(authObj);
						var token = authObj.access_token;
					},
					fail : function(err) {
						alert(JSON.stringify(err));
					}
				});
			})
			//카카오 연결 끊기
			function secession() {
				if (Kakao.Auth.getAccessToken()) {
				Kakao.API.request({
					url : '/v1/user/unlink',
					success : function(response) {
						console.log(response);
						//callback(); //연결끊기 성공시 서버에서 처리할 함수
						alert("카카오 연결해제 O");
						window.location.href = '/index.jsp';
					},
					fail : function(error) {
						console.log("카카오 연결해제 X");
						console.log(error);
						},
					});
				}
			}
		</script>

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