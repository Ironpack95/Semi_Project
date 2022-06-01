<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">

<head>
<!-- CSS -->
<link rel="stylesheet" href="/CSS/productAdd.css">
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
<script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js"
	charset="utf-8"></script>

<title>상품 등록</title>
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

		<!--//////////////////////////////////////////////////////////////////////////////////-->
		<div class="container">
			<div class="row" id="manager">
				<div class="col-12" id="manager_head">
					<h2>관리 페이지</h2>
				</div>

				<div class="col-12 col-lg-3 d-none d-lg-block" id="mypage list">
					<ul class="list-group list-group-flush">
						<a href="/add.ProductController"
							class="list-group-item list-group-item-action"> 상품 등록 </a>

						<a href="/article.manager?cpage=1"
							class="list-group-item list-group-item-action"> 게시물 관리 </a>

						<a href="/member.manager?cpage=1"
							class="list-group-item list-group-item-action"> 회원 관리 </a>

					</ul>
				</div>

				<div class="col-12 d-lg-none" id="navmenu">
					<nav class="nav nav-pills nav-fill">
						<a class="nav-link" href="/add.ProductController">상품 등록</a> <a
							class="nav-link" href="/article.manager?cpage=1">게시물 관리</a> <a
							class="nav-link" href="/member.manager?cpage=1">회원 관리</a>

					</nav>
				</div>
				
				<div class="col-12 col-lg-9">

					<span id="title">
						<h3 class="mt-3 d-none d-lg-block">상품 등록</h3>
					</span>

					<form action="/input.ProductController" method="post"
						enctype="multipart/form-data" id="product_add">
						<div class="form-row pt-2">

							<div class="px-3 py-3 d-none d-lg-block" id="input_box">
								<div class="col-12 mb-1">기본 정보</div>
								<div class="input-group mb-3 ">
									<span class="input-group-text" id="basic-addon">상품명</span> <input
										type="text" class="form-control" placeholder=""
										aria-label="Username" aria-describedby="basic-addon1"
										name="product_name" required id="product_name"> <span
										class="input-group-text" id="basic-addon2">검색명</span> <input
										type="text" class="form-control form-inline"
										placeholder="공백을 제거하세요 ex) 밤 막걸리 -> 밤막걸리"
										aria-label="Recipient's username"
										aria-describedby="basic-addon2" name="search_name" required
										id="search_name">
								</div>

								<hr>

								<div class="col-12 mb-1">상세 정보</div>
								<div class="input-group mb-3">
									<label class="input-group-text" for="inputGroupSelect01">생산지역</label>
									<select class="form-select" id="inputGroupSelect01"
										name="product_area" required>
										<option selected>지역을 선택하세요</option>
										<option value="서울">서울</option>
										<option value="경기도">경기도</option>
										<option value="경상도">경상도</option>
										<option value="강원도">강원도</option>
										<option value="전라도">전라도</option>
										<option value="충청도">충청도</option>
									</select> <label class="input-group-text" for="inputGroupSelect01">술
										종류</label> <select class="form-select" id="inputGroupSelect01"
										name="kind" required>
										<option selected>술 종류를 선택하세요</option>
										<option value="막걸리">막걸리</option>
										<option value="전통소주">전통 소주</option>
										<option value="약주">약주</option>
										<option value="과실주">과실주</option>
										<option value="리큐르">리큐르</option>
									</select> <label class="input-group-text" for="inputGroupSelect01">제품
										코드</label> <select class="form-select" id="inputGroupSelect01"
										name="product_code" required>
										<option value="A10">A10 (막걸리)</option>
										<option value="A20">A20 (전통 소주)</option>
										<option value="A30">A30 (약주)</option>
										<option value="A40">A40 (과실주)</option>
										<option value="A50">A50 (리큐르)</option>
									</select>
								</div>

								<div class="input-group mb-2 ">
									<span class="input-group-text" id="basic-addon">가격</span> <input
										type="text" class="form-control" placeholder=""
										aria-label="Username" aria-describedby="basic-addon1"
										name="price" id="price" required> <span
										class="input-group-text" id="basic-addon2">ABV</span> <input
										type="text" class="form-control form-inline"
										aria-label="Recipient's username"
										aria-describedby="basic-addon2" name="abv" id="abv" required>
									<span class="input-group-text">%</span>
								</div>

								<div class="input-group mb-3">
									<input type="text" class="form-control" name="capacity"
										placeholder="용량을 입력하세요" id="capacity"> <span
										class="input-group-text">ml</span>


								</div>

								<div class="col-12 mb-1">평점</div>
								<input type="text" class="form-control mb-3 w-50" name="grade"
									placeholder="1~5" id="grade">


								<div class="col-12 mb-1">양조장</div>
								<div class="input-group mb-1 ">
									<span class="input-group-text" id="basic-addon">양조장명</span> <input
										type="text" class="form-control" placeholder=""
										aria-label="Username" aria-describedby="basic-addon1"
										name="brewery" id="brewery" required>

								</div>

								<div class="input-group mb-2 ">
									<span class="input-group-text" id="basic-addon3">주소</span> <input
										type="text" class="form-control" id="adress1"
										aria-describedby="basic-addon3" name="adress1" required>

									<span class="input-group-text">상세주소</span> <input type="text"
										class="form-control" name="adress2" id="adress2" required>
								</div>

								<hr>

								<div class="input-group mb-3">
									<span class="input-group-text">소개글</span>
									<textarea class="form-control" aria-label="With textarea"
										name="smry" id="smry" required> </textarea>
								</div>

								<div class="input-group mb-3">
									<label class="input-group-text" for="inputGroupFile02">상품
										사진</label> <input type="file" class="form-control"
										id="inputGroupFile02" name="product_img" required>
								</div>
								<div class="col-12 text-end">
									<button type='submit' id=update class="btn btn-outline-success">등록</button>
									<button type='reset' id=update class="btn btn-outline-danger">초기화</button>
								</div>
							</div>

					</form>
					
					<form action="/input.ProductController" method="post"
						enctype="multipart/form-data" id="product_add">
						<div class="form-row pt-2">

							<div class="px-3 py-3 d-lg-none" id="input_box">
								<div class="col-12 mb-1">기본 정보</div>
								<div class="input-group mb-3 ">
									<span class="input-group-text" id="basic-addon">상품명</span> 
									<input type="text" class="form-control" placeholder="" aria-label="Username" aria-describedby="basic-addon1" name="product_name" required id="product_name"> 
								</div>
								<div class="input-group mb-3 ">
									<span class="input-group-text" id="basic-addon2">검색명</span> 
									<input type="text" class="form-control form-inline" placeholder="공백을 제거하세요" aria-label="Recipient's username" aria-describedby="basic-addon2" name="search_name" required id="search_name">
								</div>
								

								<hr>

								<div class="col-12 mb-1">상세 정보</div>
								<div class="input-group mb-3">
									<label class="input-group-text" for="inputGroupSelect01">생산지역</label>
									<select class="form-select" id="inputGroupSelect01"
										name="product_area" required>
										<option selected>지역을 선택하세요</option>
										<option value="서울">서울</option>
										<option value="경기도">경기도</option>
										<option value="경상도">경상도</option>
										<option value="강원도">강원도</option>
										<option value="전라도">전라도</option>
										<option value="충청도">충청도</option>
									</select> 
								</div>
								
								<div class="input-group mb-3">
									<label class="input-group-text" for="inputGroupSelect01">술종류</label> <select class="form-select" id="inputGroupSelect01" name="kind" required>
										<option selected>술 종류를 선택하세요</option>
										<option value="막걸리">막걸리</option>
										<option value="전통소주">전통 소주</option>
										<option value="약주">약주</option>
										<option value="과실주">과실주</option>
										<option value="리큐르">리큐르</option>
									</select>
								</div>
								
								<div class="input-group mb-3">
									<label class="input-group-text" for="inputGroupSelect01">제품 코드</label> <select class="form-select" id="inputGroupSelect01" name="product_code" required>
										<option value="A10">A10 (막걸리)</option>
										<option value="A20">A20 (전통 소주)</option>
										<option value="A30">A30 (약주)</option>
										<option value="A40">A40 (과실주)</option>
										<option value="A50">A50 (리큐르)</option>
									</select>
								</div>

								<div class="input-group mb-2 ">
									<span class="input-group-text" id="basic-addon">가격</span> <input
										type="text" class="form-control" placeholder=""
										aria-label="Username" aria-describedby="basic-addon1"
										name="price" id="price" required> <span
										class="input-group-text" id="basic-addon2">ABV</span> <input
										type="text" class="form-control form-inline"
										aria-label="Recipient's username"
										aria-describedby="basic-addon2" name="abv" id="abv" required>
									<span class="input-group-text">%</span>
								</div>

								<div class="input-group mb-3">
									<input type="text" class="form-control" name="capacity"
										placeholder="용량을 입력하세요" id="capacity"> <span
										class="input-group-text">ml</span>


								</div>

								<div class="col-12 mb-1">평점</div>
								<input type="text" class="form-control mb-3 w-50" name="grade"
									placeholder="1~5" id="grade">


								<div class="col-12 mb-1">양조장</div>
								<div class="input-group mb-1 ">
									<span class="input-group-text" id="basic-addon">양조장명</span> <input
										type="text" class="form-control" placeholder=""
										aria-label="Username" aria-describedby="basic-addon1"
										name="brewery" id="brewery" required>

								</div>

								<div class="input-group mb-2 ">
									<span class="input-group-text" id="basic-addon3">주소</span> <input
										type="text" class="form-control" id="adress1"
										aria-describedby="basic-addon3" name="adress1" required>

									<span class="input-group-text">상세주소</span> <input type="text"
										class="form-control" name="adress2" id="adress2" required>
								</div>

								<hr>

								<div class="input-group mb-3">
									<span class="input-group-text">소개글</span>
									<textarea class="form-control" aria-label="With textarea"
										name="smry" id="smry" required> </textarea>
								</div>

								<div class="input-group mb-3">
									<label class="input-group-text" for="inputGroupFile02">상품
										사진</label> <input type="file" class="form-control"
										id="inputGroupFile02" name="product_img" required>
								</div>
								<div class="col-12 text-end">
									<button type='submit' id=update class="btn btn-outline-success">등록</button>
									<button type='reset' id=update class="btn btn-outline-danger">초기화</button>
								</div>
							</div>

					</form>
				</div>
			</div>
		</div>


		<!--//////////////////////////////////////////////////////////////////////////////////-->
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

        $("#product_add").on("submit", function () {

            let product_name = $("#product_name").val();
            let search_name = $("#search_name").val();
            let price = $("#price").val();
            console.log(price);
            let abv = $("#abv").val();
            console.log(abv);
            let capacity = $("#capacity").val();
            console.log(capacity);
            let grade = $("#grade").val();
            console.log(grade);
            let adress1 = $("#adress1").val();
            console.log(adress1);
            let adress2 = $("#adress2").val();
            console.log(adress2);
            let smry = $("#smry").val();
            console.log(smry);
            
            // file
            let fileVal = $("#inputGroupFile02").val();
            
            let maxSize = 10 * 1024 * 1024; // 10MB
           	let fileSize = $("#inputGroupFile02")[0].files[0].size;
            
            
     
            
            // regex
            let regexPname = /^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣0-9a-zA-Z]{1}[ㄱ-ㅎ|ㅏ-ㅣ|가-힣0-9a-zA-Z\s]{1,19}$/gs;
            let regexSname = /^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣0-9a-zA-Z]{1,20}$/gs;
            let regexPrice = /^[0-9]{1,6}$/g;
            let regexAbv = /^[0-9]{1,2}.?[0-9]{0,5}$/g;
            let regexCap = /^[0-9]{1,4}?$/g;
            let regexGrade= /^[0-9]{1}.?[0-9]{0,2}$/g;

            // 상품명 검사
            if (!(regexPname.test(product_name))) {
                alert("특수문자 제외 1~20글자");
                $("#product_name").val('')
                $("#product_name").focus();

                return false
            }

            // 검색명 검사
            if (!(regexSname.test(search_name))) {
                alert("공백을 제거하고 한글과 숫자만 입력하세요");
                $("#search_name").val('')
                $("#search_name").focus();

                return false
            }

            // 가격 검사
            if (!(regexPrice.test(price))) {
                alert("숫자만 입력이 가능합니다. (99만원까지)");
                $("#price").val('')
                $("#price").focus();

                return false
            }

            // 알콜 도수 검사
            if (!(regexAbv.test(abv))) {
                alert("정수 : 1~99 | 소수 : 다섯째까지");
                $("#abv").val('')
                $("#abv").focus();

                return false
            }

            // 용량 검사
            if (!(regexCap.test(capacity))) {
                
                alert("숫자만 입력가능합니다.(1~1500)");


                $("#capacity").val('');
                $("#capacity").focus();

                return false
            }
            
            // 평점 검사
            if (!(regexGrade.test(grade) && parseFloat(grade) <= 5)) {
                alert("1~5사이 소수점 2번째까지 가능합니다.");
                $("#grade").val('');
                $("#grade").focus();

                return false
            }
            
            // 파일 확장자 체크
            if (fileVal != ""){
            	let ext = fileVal.split('.').pop().toLowerCase();
            	
            	if($.inArray(ext, ['jpg', 'jpeg', 'png']) == -1){
            		alert('jpg, jpeg, png 파일만 업로드 할 수 있습니다.');
            		
            		return false;
            		
            	}
            	
            }
            
            // 파일 용량 체크
            if(fileSize > maxSize){
            	alert("첨부파일 사이즈는 10MB 이내로 등록 가능합니다.");
            	
            	return false;
            }
            


        });

    </script>

</body>

</html>

<!-- 여기가 HEAD -->