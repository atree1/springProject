<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@include file="../includes/header.jsp"%>
<div class="col-md-12 grid-margin stretch-card">
	<div class="card">
		<div class="card-body">
			<form id='registerForm' class="forms-sample" method="post">
				<div class="form-group">
					<label for="exampleInputEmail3">WRITER</label> <input type="text"
						class="form-control" id="exampleInputEmail3" placeholder="아이디를 입력하세요"
						name='writer'>
				</div>
				<div class="form-group">
					<label for="exampleInputName1">TITLE</label> <input type="text"
						class="form-control" id="exampleInputName1" placeholder="제목을 입력하세요"
						name='title'>
				</div>

				<label for="exampleTextarea1">CONTENT</label>
				<textarea class="form-control" id="exampleTextarea1" rows="2"
					name='content' placeholder="내용을 입력하세요"></textarea>


				<div class="form-group">
					<input type="file" id='files' class="form-control file-upload-info" multiple="multiple">

				</div>
		</div>
		</form>
		<form action="/board/list">
			<div>
				<button id='register' class="btn btn-success mr-2">등록</button>
				<button id='cancle' class="btn btn-danger">취소</button>
			</div>
		</form>
	</div>
</div>


<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
<%@include file="../includes/footer.jsp"%>
<script>
	$(document).ready(function() {

		$('#register').on("click", function(e) {
			e.preventDefault();
			console.log("등록~");

			$('#registerForm').submit();
		})
		var result = '<c:out value="${result}"/>';
	
	});
</script>