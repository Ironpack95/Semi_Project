<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
<!-- CSS -->
<link rel="stylesheet" href="/CSS/join.css">
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

<script src="https://kit.fontawesome.com/7f0130da7d.js" crossorigin="anonymous"></script>

<!-- 주소 API -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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
									<li><a class="dropdown-item" href="/productA10.ProductController?cpage=1">막걸리</a></li>
									<li><a class="dropdown-item" href="/productA20.ProductController?cpage=1">전통 소주</a></li>
									<li><a class="dropdown-item" href="/productA30.ProductController?cpage=1">약주</a></li>
									<li><a class="dropdown-item" href="/productA40.ProductController?cpage=1">과실주</a></li>
									<li><a class="dropdown-item" href="/productA50.ProductController?cpage=1">리큐르</a></li>
									<li>
										<hr class="dropdown-divider">
									</li>
									<li><a class="dropdown-item" href="#">전체보기</a></li>
								</ul></li>

							<li class="d-none d-lg-block nav-item"><a href="/Search/search.jsp"
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
								placeholder="술이 넘어간다 쭉쭉쭉!" aria-label="Search" name="search_text"
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
								<button id="loginBtn" type="button" class="mx-1 d-none d-lg-inline btn btn-warning navbar-btn">로그인</button>
								<button id="joinBtn" type="button" class="mx-1 d-none d-lg-inline btn btn-dark navbar-btn">회원가입</button>
								
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

		<form method="post" action="/account.member" id="frm">

			<div class="container" style="width: 360px;">
				<div style="text-align: center;">
					<h3>회원정보 입력</h3>
				</div>
				<div class="join-box">
					<div class="title">이름</div>
					<div>
						<input type="text" id="name" name="name" placeholder="2~6자"
							class="join-input">
					<div class="searchclear" style="display: none;">X</div></div>
					<div class="check" id="nameinfo"></div>
				</div>
				<div class="join-box">
					<div class="title">
						아이디
					</div>
					<div>
						<input type="text" id="id" name="id"
							placeholder="영문(소문자), 숫자 8~13자" class="join-input">
					<span class="searchclear" style="display: none;">X</span></div>
					<div class="check" id="idinfo"></div>
				</div>
				<div class="join-box">
					<div class="title">
						비밀번호
					</div>
					<div>
					<input type="password" id="pw" name="pw"
						placeholder="영문, 숫자 각각 포함한 최소 8자" class="join-input">
					<span class="searchclear" style="display: none;">X</span></div>	
					<div class="check" id="pwinfo"></div>
				</div>
				<div class="join-box">
					<div>
					<input type="password" id="pwcheck" name="pwcheck"
						placeholder="비밀번호 재입력" class="join-input">
					<span class="searchclear" style="display: none;" id="pwcheckclear">X</span></div>
					<div class="check" id="pwcheckinfo"></div>
				</div>
				<div class="join-box">
					<div class="title">
						생년월일
					</div>
					<div>
						<input type="text" id="birthday" name="birthday"
							placeholder="990322" class="join-input">
					<span class="searchclear" style="display: none;">X</span></div>
					<div class="check" id="birthdayinfo"></div>
				</div>
				<div class="join-box">
					<div class="title">
						이메일
					</div>
					<div>
						<input type="text" id="email" name="email"
							placeholder="example@naver.com" class="join-input">
						<span class="searchclear" style="display: none;">X</span></div>
						<div class="check" id="emailinfo"></div>
				</div>
				<div class="join-box">
					<div class="title">
						휴대폰번호
					</div>
					<div>
						<input type="text" id="phone" name="phone"
							placeholder="01012349876" class="join-input">
					<span class="searchclear" style="display: none;">X</span></div>
					<div class="check" id="phoneinfo"></div>
				</div>
				<div class="join-box">
					<div class="title">
						우편번호
					</div>
					<div>
						<input type="text" name="zipcode" id="zipcode" class="join-input" />
						<button type="button" onclick="execDaumPostcode()"
							class="btn btn-success" id="zipcode_find">찾기</button>
					</div>
				</div>
				<div class="join-box">
					<div class="title">
						주소
					</div>
					<div>
						<input type="text" name="address1" id="address1"
							class="join-input">
					</div>
				</div>
				<div class="join-box">
					<div class="title">
						상세주소
					</div>
					<div>
						<input type="text" name="address2" id="address2"
							class="join-input">
					<span class="searchclear" style="display: none;">X</span></div>
				</div>
				<input type="submit" class="btn btn-outline-success" id="join"
					value="가입하기">
			</div>
		</form>


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


	<script>
	//삭제버튼
	$(".join-input").on("keyup", function(){
		$(this).siblings(".searchclear").show();
	});
	//text 비우기
	$(".searchclear").click(function(){
	  	$(this).siblings(".join-input").val("");
	  	$(this).siblings(".join-input").focus();
	  	$(this).hide();
	  	$(this).parent().parent().find(".check").css("display","none");
	});
	//비번 재확인용 삭제버튼
	$("#pwcheckclear").click(function(){
	  	$(this).siblings(".join-input").val("");
	  	$(this).siblings(".join-input").focus();
	  	$(this).hide();
	  	$(this).parent().parent().find(".check").css("display","none");
	});
			
	//이름 유효성 검사
	$("#name").on("keyup",function(){
		let name = $("#name").val();
		let nameRegex = /^[가-힣]{2,6}$/;//2~6글자 한글
		let nameResult = nameRegex.test(name);
		
		if(!nameResult){
			$("#nameinfo").css("color", "red");
			$("#nameinfo").text("2~6자 한글을 입력해주세요.");
		} else{
			$("#nameinfo").text("");
		}
	})
	//아이디 유효성 검사
	$("#id").on("keyup",function(){
		let id = $("#id").val();
		let idRegex = /^[\da-z_]{8,13}$/; //영어 소문자, 숫자, 언더바 8~13글자
		let idResult = idRegex.test(id);
		
		if(!idResult){
			$("#idinfo").css("color", "red");
			$("#idinfo").text("8~13자(영문 소문자,숫자,_)를 입력하세요.");
			$("#id").focus();
		} else{
			$.ajax({
				url:"/duplCheck.member",
				type:"post",
				data:{id:id}
			}).done(function(resp){
				let result = JSON.parse(resp);
				if(result == true){
					$("#idinfo").text("이미 사용중인 아이디입니다.");
					$("#idinfo").css("color", "red");
				}else{
					$("#idinfo").text("사용가능한 아이디입니다.");
					$("#idinfo").css("color", "dodgerblue");
				}
			});
		}

	})
	//비번 유효성 검사
	$("#pw").on("keyup",function(){
		let pw = $("#pw").val();
		let pwRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,16}$/; //영문, 숫자를 하나 이상 포함한 8~16자
		let pwResult = pwRegex.test(pw);
		
		if(!pwResult){
			$("#pwinfo").css("color", "red");
			$("#pwinfo").text("영문, 숫자를 각각 하나 이상 포함한 8~16자");
		} else{
			$("#pwinfo").text("");
		}
	})
	//비번재확인 유효성 검사
	$("#pwcheck").on("keyup",function(){
		let pw = $("#pw").val();
		let pwcheck = $("#pwcheck").val();
		let pwcheckRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,16}$/;
		let pwcheckResult = pwcheckRegex.test(pwcheck);
		
		if(!pwcheckResult){
			$("#pwcheckinfo").css("color", "red");
			$("#pwcheckinfo").text("영문, 숫자를 각각 하나 이상 포함한 8~16자");
		} else if(pw == pwcheck){
			$("#pwcheckinfo").css("color", "dodgerblue");
			$("#pwcheckinfo").text("비밀번호가 일치합니다.");
		} else {
			$("#pwcheckinfo").css("color", "red");
			$("#pwcheckinfo").text("비밀번호가 일치하지 않습니다.");
		}
	})
	//생일 유효성 검사(030101 이후 출생부터)
	$("#birthday").on("keyup",function(){
		let birthday = $("#birthday").val();
		let birthdayRegex = /^([0][0-3](0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1]))|([3-9][0-9](0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1]))/; //생일 6자리
		let birthdayResult = birthdayRegex.test(birthday);
		
		if(!birthdayResult){
			$("#birthdayinfo").css("color", "red");
			$("#birthdayinfo").text("※미성년자 가입불가. 생년월일 6자리를 입력하세요.");
		} else{
			$("#birthdayinfo").text("");
		}
	})
	//이메일 유효성 검사
	$("#email").on("keyup",function(){
		let email = $("#email").val();
		let emailRegex = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/; //이메일
		let emailResult = emailRegex.test(email);
		
		if(!emailResult){
			$("#emailinfo").css("color", "red");
			$("#emailinfo").text("이메일 형식에 맞게 작성해주세요.");
		} else{
			$("#emailinfo").text("");
		}
	})
	//휴대폰번호 유효성 검사
	$("#phone").on("keyup",function(){
		let phone = $("#phone").val();
	    let phoneRegex = /^010[0-9]{8}$/; //핸드폰 11자리
		let phoneResult = phoneRegex.test(phone);
		if(!phoneResult){
			$("#phoneinfo").css("color", "red");
			$("#phoneinfo").text("휴대폰번호 11자리를 작성해주세요.");
		} else{
			$("#phoneinfo").text("");
		}
	})		
	
	//회원가입 클릭시 유효성 검사+빈값 alert
	$("#join").on("click", function(){
		let name = $("#name").val();
		let nameRegex = /^[가-힣]{2,6}$/;//2~6글자 한글
		let nameResult = nameRegex.test(name);
		if(name.replace(/\s|　/gi, "").length == 0){
			alert("이름을 입력해주세요.");
			return false;
		} 
		if(!nameResult){
			alert("이름을 형식에 맞게 입력해주세요.");
			return false;
		}
		let id = $("#id").val();
		let idRegex = /^[\da-z_]{8,13}$/; //영어 소문자, 숫자, 언더바 8~13글자
		let idResult = idRegex.test(id);
		if(id.replace(/\s|　/gi, "").length == 0){
			alert("아이디를 입력해주세요.");
			return false;
		}
		if(!idResult){
			alert("아이디를 형식에 맞게 입력해주세요.");
			return false;
		}
		let pw = $("#pw").val();
		let pwRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,16}$/; //영문, 숫자를 하나 이상 포함한 8~16자
		let pwResult = pwRegex.test(pw);
		if(pw.replace(/\s|　/gi, "").length == 0){
			alert("비밀번호를 입력해주세요.");
			return false;
		}
		if($("#pwcheck").val().replace(/\s|　/gi, "").length == 0){
			alert("비밀번호 재확인을 입력해주세요.");
			return false;
		}
		if(!pwResult){
			alert("비밀번호를 형식에 맞게 입력해주세요.");
			return false;
		}
		let birthday = $("#birthday").val();
		let birthdayRegex = /^([0][0-3](0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1]))|([3-9][0-9](0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1]))/; //생일 6자리
		let birthdayResult = birthdayRegex.test(birthday);
		if(birthday.replace(/\s|　/gi, "").length == 0){
			alert("생년월일을 입력해주세요.");
			return false;
		}
		if(!birthdayResult){
			alert("생년월일을 형식에 맞게 입력해주세요.");
			return false;
		}
		let email = $("#email").val();
		let emailRegex = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/; //이메일
		let emailResult = emailRegex.test(email);
		if(email.replace(/\s|　/gi, "").length == 0){
			alert("이메일을 입력해주세요.");
			return false;
		}
		if(!emailResult){
			alert("이메일을 형식에 맞게 입력해주세요.");
			return false;
		}
		let phone = $("#phone").val();
	    let phoneRegex = /^010[0-9]{8}$/; //핸드폰 11자리
		let phoneResult = phoneRegex.test(phone);
		if(phone.replace(/\s|　/gi, "").length == 0){
			alert("휴대폰번호를 입력해주세요.");
			return false;
		}
		if(!phoneResult){
			alert("휴대폰번호를 형식에 맞게 입력해주세요.");
			return false;
		}
		if($("#zipcode").val().replace(/\s|　/gi, "").length == 0){
			alert("우편번호를 입력해주세요.");
			return false;
		}
		if($("#address1").val().replace(/\s|　/gi, "").length == 0){
			alert("주소를 입력해주세요.");
			return false;
		}
		if($("#address2").val().replace(/\s|　/gi, "").length == 0){
			alert("상세주소를 입력해주세요.");
			return false;
		}
		alert("가입이 완료되었습니다 :) 환영합니다!");
		});
	
	//우편번호
	function execDaumPostcode() {
	new daum.Postcode({
		oncomplete : function(data) {
			var addr = "";

			if (data.userSelectedType === "R") {
				addr = data.roadAddress;
			}

			document.getElementById("zipcode").value = data.zonecode;
			document.getElementById("address1").value = addr;
			document.getElementById("address2").focus();
			},
		}).open();
	}
	</script>
</body>

</html>
