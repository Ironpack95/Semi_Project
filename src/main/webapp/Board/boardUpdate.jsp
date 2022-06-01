<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>술이주夜 - 리뷰</title>
<jsp:include page="common/header.jsp" />
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet" type="text/css" href="../CSS/board.css">
<!-- <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> -->
<script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js"
	charset="utf-8"></script>


<link rel="stylesheet" href="../CSS/summernote/summernote-lite.css">
</head>
<body>
	<form id='target' action="/boardUpdateAction.board" method="post"
		enctype="multipart/form-data">
		<div class='boardCreateBody'>
			<h5>우리술 리뷰 수정</h5>
			<hr>
			<div class='alcoholInfo'>
				<!-- 술 정보 -->
				<div id='alcohoImg'>
					<img src='/img/productFile/${productOne.oriName}'>
				</div>
				<div id='alcohoContent'>
					<span id='alcohoName'>${productOne.product_name}</span><br> <span id='alcohoExp'>${productOne.smry}</span>
				</div>
				<input type="hidden" class='prodcutNum' name='prodcutNum' value='${productOne.seq}'>
				<button class='type_change' style="position: absolute; right: 0px; bottom: 0px; color: white; background-color: #2c6246; border: 0px;" type="button">변경하기</button>
			</div>
			<hr>
			<div class='boardSet'>
				<div class='boardUser'>작성자</div>
				<span id='userName'>${loginID}</span>
			</div>
			<hr>
			<div class='boardSet'>
				<div class='boardUser'>평가</div>
				<input type="hidden" id='score' name='score' value='${board.score}'>
				<input type="radio" class='score' id='scoreOne' name='boardScore'
					value='1' checked><label for="scoreOne">★</label> <input
					type="radio" class='score' id='scoreTwe' name='boardScore'
					value='2'><label for="scoreTwe">★★</label> <input
					type="radio" class='score' id='scoreThree' name='boardScore'
					value='3'><label for="scoreThree">★★★</label> <input
					type="radio" class='score' id='scoreFore' name='boardScore'
					value='4'><label for="scoreFore">★★★★</label> <input
					type="radio" class='score' id='scoreFive' name='boardScore'
					value='5'><label for="scoreFive">★★★★★</label>
			</div>
			<script>
			    $('input:radio[name=boardScore]').eq(${board.score}-1).attr("checked", true);
			</script>

			<hr>
			<input id='num' name='num' type="hidden" maxlength="35"
				value="${board.boardNum}">
			<div class='boardSet'>
				<div class='boardUser'>제목</div>
				<input id='boardTitle' name='title' type="text" maxlength="20"
					value="${board.title}" placeholder="제목을 입력하세요." required="required">
			</div>
			<hr>

			<div class='boardSet'>
				<div class='boardUser'>내용</div>
				<br>
				<!-- <input id='boardDetail' name='boardExp' type="text" maxlength="35"
					placeholder="내용을 입력하세요." style="height: 300px; "> -->
				<div id="smarteditor" style="width: 100%; display: inline-block;">
					<textarea name="editorTxt" id="editorTxt" rows="20" cols="10"
						placeholder="내용을 입력해주세요" style="width: 100%">${board.boardExp}
			        </textarea>
			        <p class="count"><span>0</span> / 800</p>
				</div>
			</div>
			<hr>
			<div class='boardLastBtn'>
				<button type="button" onclick="submitAdd()">수정</button>
				<button type="button"
					onclick="if(confirm('정말로 취소 하시겠습니까?')){location.href='/boardSelect.board?num=${board.boardNum}'}">취소</button>
			</div>
		</div>
	</form>
	<div class='background_box' style="display: none">
		<div class='backgroun_main'>
			<div class='product_option_select'>
				<c:forEach var="product" items="${product}">
					<div class='product_show_box' data-num="${product.seq}">
						<div class='product_img' data-src = '${product.oriName }'>
							<img src="/img/productFile/${product.oriName}">
						</div>
						<div class='product_name'>
							<span>${product.product_name}</span>
							<input type="hidden" value='${product.smry}'>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>

	<script>
		let oEditors = []

		smartEditor = function() {
			nhn.husky.EZCreator.createInIFrame({
				oAppRef : oEditors,
				elPlaceHolder : "editorTxt",
				sSkinURI : "/smarteditor/SmartEditor2Skin.html",
				fCreator : "createSEditor2"
			})
		}
		$(document).ready(function() {
			smartEditor()
		})

		function submitAdd() {
			var ctntarea = document.querySelector("iframe").contentWindow.document.querySelector("iframe").contentWindow.document.querySelector(".se2_inputarea");
			var text = ctntarea.innerHTML;
			text = text.replace(/<br>/ig, "");	// br 제거
			text = text.replace(/&nbsp;/ig, "");// 공백 제거
			text = text.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");	// html 제거
			if(text.length == 0){
				alert("내용을 입력하세요.");
				return false;
			}
			oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", []);
			alert("게시글이 수정되었습니다. :)");
			$("#target").submit();
		}
		
		 $("input[name='boardScore']:radio").change(function () {
	        //라디오 버튼 값을 가져온다.
	        var noticeCat = this.value;
	        $("#score").val(noticeCat);      
		});
		 
		 $(document).on("click",".product_show_box",function(){
			var num = $(this).data("num");
			var src = $(this).children('.product_img').data('src');
			$("#alcohoImg").children("img").attr("src",'/img/productFile/'+src);
			$(".prodcutNum").val(num);
			$(".background_box").hide();
			$("#alcohoName").text($(this).children(".product_name").children("span").text());
			$("#alcohoExp").text($(this).children(".product_name").children("input").val());
			$("body").removeClass("active");
		});
		
		$(document).on("click",".type_change",function(){
			$(".background_box").show();
			$("body").addClass("active");
		});
		
		setTimeout(function() {
			var ctntarea = document.querySelector("iframe").contentWindow.document.querySelector("iframe").contentWindow.document.querySelector(".se2_inputarea");
			ctntarea.addEventListener("keyup", function(e) {
				var text = this.innerHTML;
				var lenCheck = 800;
				text = text.replace(/<br>/ig, "");	// br 제거
				text = text.replace(/&nbsp;/ig, "");// 공백 제거
				text = text.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");	// html 제거
				
				var len = text.length;
				document.querySelector(".count span").innerHTML = len;
				
				if(len > lenCheck) {
					alert("최대 "+lenCheck+" byte까지 입력 가능합니다.");
					this.innerHTML = this.innerHTML.substring(0,lenCheck);	
				}	
			});	
		}, 1000)
	</script>


	<jsp:include page="common/footer.jsp" />
</body>
</html>