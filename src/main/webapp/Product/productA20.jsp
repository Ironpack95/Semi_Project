<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">

<head>
  <!-- CSS -->
  <link rel="stylesheet" href="/CSS/product.css"> <!-- 경로 수정 고려 -->

  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!-- Jquery -->
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>

  <!-- Bootstrap ver 5.1  -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
    crossorigin="anonymous"></script>

  <script src="https://kit.fontawesome.com/7f0130da7d.js" crossorigin="anonymous"></script>


  <title>막걸리</title>

</head>



<body>
  <div class="container">
    <header class="mb-5 pt-3">
      <nav class="navbar navbar-expand-lg navbar-light bg-white">
        <div class="container-fluid">
          <div class="navbar-header mx-2">
            <a class="navbar-brand" href="/index.jsp"> <img alt="" src="/img/logo2.jpg" id="logo"> <!-- 경로 수정 고려 -->
            </a>
          </div>


          <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">

              <li class="nav-item dropdown"><a class="nav-link dropdown-toggle mx-0 mx-md-0 mx-lg-3" href="#"
                  id="navbarDropdown" role="button" href="" data-bs-toggle="dropdown" aria-expanded="false"> 우리술 정보 </a>
                <ul class="dropdown-menu" aria-labelledby="navbarDropdown">

                  <li><a class="dropdown-item" href="/productA10.ProductController?cpage=1">막걸리</a></li>
                  <li><a class="dropdown-item" href="/productA20.ProductController?cpage=1">전통소주</a></li>
                  <li><a class="dropdown-item" href="/productA30.ProductController?cpage=1">약주</a></li>
                  <li><a class="dropdown-item" href="/productA40.ProductController?cpage=1">과실주</a></li>
                  <li><a class="dropdown-item" href="/productA50.ProductController?cpage=1">리큐르</a></li>
                  <li>
                    <hr class="dropdown-divider">
                  </li>
                  <li><a class="dropdown-item" href="/list.ProductController?cpage=1">전체보기</a></li>


                </ul>
              </li>

              <li class="d-none d-lg-block nav-item"><a href="/Search/search.jsp"
                  class="nav-link mx-0 mx-0 mx-md-0 mx-lg-3">우리술 검색</a></li>


              <li class="nav-item"><a class="nav-link mx-0 mx-md-0 mx-lg-3" href="/boardList.board" id="board">술꾼 술꾼</a>
              </li>
              <c:choose>
                <c:when test="${loginID != null}">

                  <li class="nav-item d-lg-none"><a class="nav-link mx-0 mx-md-0 mx-lg-3" href="/mypage.member"
                      id="board">내 정보</a></li>

                  <li class="nav-item d-lg-none"><a class="nav-link mx-0 mx-md-0 mx-lg-3" href="/logout.member"
                      id="board">로그아웃</a></li>

                </c:when>
                <c:when test="${kakaoemail != null}">

                  <li class="nav-item d-lg-none"><a class="nav-link mx-0 mx-md-0 mx-lg-3" href="/mypage.member"
                      id="board">내 정보</a></li>

                  <li class="nav-item d-lg-none"><a class="nav-link mx-0 mx-md-0 mx-lg-3" href="/logout.member"
                      id="board">로그아웃</a></li>

                </c:when>
                <c:otherwise>

                  <li class="nav-item d-lg-none"><a class="nav-link mx-0 mx-md-0 mx-lg-3" href="/Member/loginView.jsp"
                      id="board">로그인</a></li>

                  <li class="nav-item d-lg-none"><a class="nav-link mx-0 mx-md-0 mx-lg-3" href="/Member/joinView.jsp"
                      id="board">회원가입</a></li>

                </c:otherwise>
              </c:choose>

              <c:choose>
                <c:when test="${loginID eq 'admin'}">
                  <li class="nav-item"><a class="nav-link mx-0 mx-0 mx-md-0 mx-lg-3" href="/Manager/manager.jsp"
                      id="board">관리자 페이지</a></li>
                </c:when>

                <c:otherwise>

                </c:otherwise>
              </c:choose>

            </ul>
            <form action="/mini.search" class="d-flex">
              <input id="search_input" class="form-control mx-1" type="search" placeholder="우리술을 검색하세요!"
                aria-label="Search" name="search_text" required>
              <button class="btn btn-outline-success me-1" type="submit" id="search_btn">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search"
                  viewBox="0 0 16 16">
                  <path
                    d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
                </svg>
              </button>
            </form>

            <c:choose>
              <c:when test="${loginID != null}">
                <div class="d-none d-lg-inline btn-group">
                  <button type="button" class="btn btn-warning dropdown-toggle" data-bs-toggle="dropdown"
                    aria-expanded="false">
                    ${loginID }</button>
                  <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="/mypage.member">마이페이지</a></li>
                    <li><a class="dropdown-item" href="/logout.member">로그아웃</a></li>
                  </ul>
                </div>
              </c:when>

              <c:when test="${kakaoemail !=null}">
                <div class="d-none d-lg-inline btn-group">
                  <button type="button" class="btn btn-warning dropdown-toggle" data-bs-toggle="dropdown"
                    aria-expanded="false">
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
                <button id="joinBtn" type="button" class="mx-1 d-none d-lg-inline btn btn-dark navbar-btn">회원가입</button>

                <script>
                  $("#loginBtn")
                    .on(
                      "click",
                      function () {
                        location.href = "/Member/loginView.jsp";
                      })
                  $("#joinBtn").on("click", function () {
                    location.href = "/Member/joinView.jsp";
                  })
                </script>
              </c:otherwise>
            </c:choose>


          </div>
        </div>
      </nav>
    </header>

    <!----------------------------------- Main ----------------------------------->


    <!----------------------------------- Categori 1---------------------------------->

    <div class="col-12 " id="navmenu">
      <nav class="nav nav-pills nav-fill">
        <a class="nav-link categor_list_btn mx-2 my-2 my-lg-0" href="/list.ProductController?cpage=1">전체 상품</a>
        <a class="nav-link categor_list_btn mx-2 my-2 my-lg-0" href="/productA10.ProductController?cpage=1">막걸리</a>
        <a class="nav-link categor_list_btn mx-2 my-2 my-lg-0" href="#" style="background-color:#2c6246; color:white;">전통소주</a>
        <a class="nav-link categor_list_btn mx-2 my-2 my-lg-0" href="/productA30.ProductController?cpage=1">약주</a>
        <a class="nav-link categor_list_btn mx-2 my-2 my-lg-0" href="/productA40.ProductController?cpage=1">과실주</a>
        <a class="nav-link categor_list_btn mx-2 my-2 my-lg-0" href="/productA50.ProductController?cpage=1">리큐르</a>
      </nav>
    </div>

    <hr style="height: 4px; background-color: black" class="mt-3 mb-5">

    <!----------------------------------- Categori 2---------------------------------->

    <div class="row m-auto">

      <!-- a태그 처리해야 상세 페이지 볼 수 있음 -->

      <c:forEach var="i" items="${list}">
		<c:if test="${i.product_code eq 'A20' }">
        <div class="col-12 col-lg-4 Result_box mb-4">
          <a href="/Detail.ProductController?seq=${i.seq}">
            <div class="Result_img">
              <img src="../thumbnail/${i.sysName}" class="w-100"
                style="border-radius: 5px;">
            </div>
            <div class="Result_txt" style="text-align: center;">
              <div class="row Result_grade">
                <div class="col-6 px-0" style="text-align: right;">
                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star"
                    viewBox="0 0 16 16">
                    <path
                      d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.565.565 0 0 0-.163-.505L1.71 6.745l4.052-.576a.525.525 0 0 0 .393-.288L8 2.223l1.847 3.658a.525.525 0 0 0 .393.288l4.052.575-2.906 2.77a.565.565 0 0 0-.163.506l.694 3.957-3.686-1.894a.503.503 0 0 0-.461 0z" />
                  </svg>
                </div>

                <div class="col-6 px-1" style="text-align: left; line-height: 24px;">
                  ${i.grade}
                </div>
              </div>
              <p class="Result_name my-0">${i.product_name}</p>
              <p class="Result_price my-1">
                <fmt:formatNumber value="${i.price }" type="currency" />
              </p>
              <p class="Result_decs mb-4 mb-lg-0">${i.smry}</p>
            </div>
          </a>
        </div>
		</c:if>
      </c:forEach>

    </div>

    <!----------------------------------- footer ----------------------------------->

    <hr>

    <footer class="site-footer">

      <div class="container">
        <div class="row">
          <div class="d-none d-lg-block col-md-8 col-sm-6 col-xs-12">
            <p class="copyright-text">
              Copyright &copy; 2022 All Rights Reserved by <a href="#" style="text-decoration: none;">아이코올</a>.
            </p>
          </div>

          <div class="d-lg-none col-md-8 col-sm-6 col-xs-12">
            <p class="copyright-text">Copyright &copy;</p>
            <p class="copyright-text">
              2022 All Rights Reserved by <a href="#" style="text-decoration: none;">아이코올</a>.
            </p>
          </div>

          <div class="col-md-4 col-sm-6 col-xs-12 my-3 my-lg-0">
            <ul class="social-icons">
              <li><a class="facebook" href="#"><i class="fa fa-facebook"></i></a></li>
              <li><a class="twitter" href="#"><i class="fa fa-twitter"></i></a></li>
              <li><a class="dribbble" href="#"><i class="fa fa-dribbble"></i></a></li>
              <li><a class="linkedin" href="#"><i class="fa fa-linkedin"></i></a></li>
            </ul>
          </div>
        </div>
      </div>
    </footer>

    <a id="back-to-top" href="#" class="btn back-to-top" role="button" title="위로" data-toggle="tooltip"
      data-placement="left">

      <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="black" class="bi bi-arrow-up-circle-fill"
        viewBox="0 0 16 16">
        <path
          d="M16 8A8 8 0 1 0 0 8a8 8 0 0 0 16 0zm-7.5 3.5a.5.5 0 0 1-1 0V5.707L5.354 7.854a.5.5 0 1 1-.708-.708l3-3a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 5.707V11.5z" />
      </svg>

    </a>

  </div>

  <script>

    $("#search").on("submit", function () {

      let search_text = $("#search_text").val();
      console.log(search_text);


      let regexSearch = /^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]{1,20}$/g;

      if (!(regexSearch.test(search_text))) {
        alert("한글만 입력해주세요");
        $("#search_text").val('')
        $("#search_text").focus();

        return false
      }
    });
    
    $(document).ready(function(){
        $(window).scroll(function () {
               if ($(this).scrollTop() > 50) {
                   $('#back-to-top').fadeIn();
               } else {
                   $('#back-to-top').fadeOut();
               }
           });
           // scroll body to 0px on click
           $('#back-to-top').click(function () {
               $('#back-to-top').tooltip('hide');
               $('body,html').animate({
                   scrollTop: 0
               }, 600);
               return false;
           });
           
           $('#back-to-top').tooltip('show');

   });
  </script>

</body>

</html>