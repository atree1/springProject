<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>



<div class="col-md-6 grid-margin stretch-card">
	<div class="card">
		<div class="card-body">
			<h4 class="card-title">Basic form</h4>
			<p class="card-description">Basic form elements</p>
			<form id='modifyForm' class="forms-sample" role="form" action="/board/modify"
				method="post">
				<div class="form-group">
					<label for="exampleInputName1">BNO</label> <input type="text"
						class="form-control" id="exampleInputName1" name="bno"
						placeholder="Name" value='<c:out value="${board.bno}"/>'
						readonly="readonly">
				</div>
				<div class="form-group">
					<label for="exampleInputEmail3">WRITER</label> <input type="email"
						class="form-control" id="exampleInputEmail3" name="writer"
						placeholder="Email" value='<c:out value="${board.writer}"/>'
						readonly="readonly">
				</div>
				<div class="form-group">
					<label for="exampleInputName1">TITLE</label> <input type="text"
						class="form-control" id="exampleInputName1" name="title"
						placeholder="Password" value='<c:out value="${board.title}"/>'>
				</div>

				<label for="exampleTextarea1">CONTENT</label>
				<textarea class="form-control" id="exampleTextarea1" rows="2"
					name='content'><c:out value="${board.content}" /></textarea>
				<div class="form-group">
					<label>File upload</label> <input type="file" name="img[]"
						class="file-upload-default">
					<div class="input-group col-xs-12">
						<input type="text" class="form-control file-upload-info" disabled
							placeholder="Upload Image">
						</span>
					</div>


				</div>
				<input type='hidden' name='page' value='${pageObj.page}'> <input
					type="hidden" name='bno' value='${board.bno}'> <input
					type='hidden' name='type' value='${pageObj.type}'> <input
					type='hidden' name='keyword' value='${pageObj.keyword}'>

			</form>

				<form id='actionForm'  action="/board/read">
					<input type="hidden" name='bno' value='${board.bno}'> 
					<input type='hidden' name='page' value='${pageObj.page}'> 
					<input type='hidden' name='type' value='${pageObj.type}'> 				
					<input type='hidden' name='keyword' value='${pageObj.keyword}'>
					<button id='modifyBtn' class="btn btn-success">수정</button>
					<button id='removeBtn' class="btn btn-warning">삭제</button>
					<button id='cancleBtn' class="btn btn-danger">취소</button>
				</form>

		</div>
	</div>
</div>


<!-- content-wrapper ends -->
<!-- partial:../../partials/_footer.html -->

<%@include file="../includes/footer.jsp"%>



<script>
	$(document).ready(function() {

		var actionForm=$('#actionForm');
		$('#modifyBtn').on("click", function(e) {
			e.preventDefault();
			$("#modifyForm").submit();
		})
		$('#removeBtn').on("click", function(e) {
			e.preventDefault();
			$("#actionForm").attr("method",'post').attr("action","/board/remove").submit();
		})
		
	
	});
</script>