<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@include file="../includes/header.jsp"%>
<sec:authorize access="hasRole('ADMIN')">

<div class="col-lg-12 stretch-card">

	<div class="card">
	 <div>
	    <select id='display' name="display">
	      <option <c:out value="${pageObj.display == null?'selected':'' }"/>>--</option>
	      <option value='10' <c:out value="${pageObj.display == 10?'selected':'' }"/> >10</option>
	      <option value="20" <c:out value="${pageObj.display == 20?'selected':'' }"/> >20</option>
	      <option value="50" <c:out value="${pageObj.display == 50?'selected':'' }"/> >50</option>
	      <option value="100" <c:out value="${pageObj.display == 100?'selected':''}"/> >100</option>     
	    </select>
	    
	  </div>
		<div class="card-body">
			<h4 class="card-title">Table with contextual classes</h4>
			<p class="card-description">
			<a href="/board/register"><button class="btn btn-dark btn-fw">Register</button></a>
			</p>
			<div class="table-responsive">
				<table class="table table-stripped">
					<thead>
						<tr>
							<th>BNO</th>
							<th>TITLE</th>
							<th>WRITER</th>
							<th>REGDATE</th>
							<th>UPDATEDATE</th>
							<th>VIEWCNT</th>
						</tr>
					</thead>
					<tbody>
						<tr class="table-info">
							<c:forEach items="${list }" var="board">
								<tr>
									<td><c:out value="${board.bno}" /></td>
									<td><a href="${board.bno}" class='board'><c:out
												value="${board.title}" /> <b>[ <c:out value="${board.replyCnt}" />]</b></a></td>
									<td><c:out value="${board.writer}" /></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss"
											value="${board.regdate}" /></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss"
											value="${board.updatedate}" /></td>
											<td><c:out value="${board.viewCnt}" /></td>
								</tr>
							</c:forEach>
						</tr>

					</tbody>
				</table>
			<div class="col-sm-12">
	  <div>
	    <select name="type">
	      <option <c:out value="${pageObj.type == null?'selected':'' }"/>>--</option>
	      <option value="t" <c:out value="${pageObj.type == 't'?'selected':'' }"/> >제목</option>
	      <option value="c" <c:out value="${pageObj.type == 'c'?'selected':'' }"/> >내용</option>
	      <option value="w" <c:out value="${pageObj.type == 'w'?'selected':'' }"/> >작성자</option>
	      <option value="tc" <c:out value="${pageObj.type == 'tc'?'selected':'' }"/> >제목 + 내용</option>
	      <option value="tcw" <c:out value="${pageObj.type == 'tcw'?'selected':'' }"/> >제목 + 내용 + 작성자</option>
	    </select>
	    <input type='text' name='keyword' value="${pageObj.keyword}">
	    <button id="searchBtn" class="btn btn-dark btn-fw">Search</button>
	  </div>
	</div>

			<div class="col-sm-12">
		<div class="dataTables_paginate paging_simple_numbers"
			id="dataTables-example_paginate">
			<ul class="pagination">
				<c:if test="${pageObj.prev}">
					<li ><a href="${pageObj.start-1 }"><button class="btn btn-outline-secondary"><<</button></a></li>
				</c:if>
				<c:forEach begin="${pageObj.start}" end="${pageObj.end }" var="num">
					<li class="paginate_button" data-page='${num}'>
					<a href="${num}"><button class="btn btn-outline-secondary"><c:out value="${num}"/></button></a></li>
				</c:forEach>
				<c:if test="${pageObj.next }">
					<li class="paginate_button next"><a
						href="${pageObj.end+1}"><button class="btn btn-outline-secondary">>></button></a></li>
				</c:if>
			</ul>
			
		</div>
	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">Modal title</h4>
				</div>
				<div class="modal-body"></div>
				<div class="modal-footer">
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	
	<form id='actionForm'>
		<input type='hidden' name='page' id='page' value='${pageObj.page }'> 
		 	<input type='hidden' name='type' value='${pageObj.type}'> 
			<input type='hidden' name='keyword' value='${pageObj.keyword}'>
 			<input type='hidden' name='display' value='${pageObj.display}'>
	</form>
</div>

</sec:authorize>

<%@include file="../includes/footer.jsp"%>
<script type="text/javascript" src="/resources/js/jquery.cookie.js"></script>

<script>
$(document).ready(function(){
	
	var actionForm = $('#actionForm');
	var currentNum = ${pageObj.page};
	var result = '<c:out value="${result}"/>';
	var msg = $('#myModal');

	
	//목록 출력 개수 변환
	$('#display').change(function(e){
		var displayValue=$("select[name='display'] option:selected").val();
		console.log(displayValue);
		actionForm.find("input[name='display']").val(displayValue).attr("action",'/board/list');
		$("#page").val(1);
		actionForm.submit();
	});
	
	//검색 
	$('#searchBtn').on("click",function(e){
		
		
		var searchTypeValue = $("select[name='type'] option:selected").val();
		console.log(searchTypeValue);
		var searchKeyword = $("input[name='keyword']").val();
		console.log(searchKeyword);
		
		if(searchKeyword.trim().length == 0 ){
			alert("검색어 없음");
			return;
		}
		
		
		actionForm.attr("action",'/board/list');
		actionForm.find('input[name="type"]').val(searchTypeValue);
		actionForm.find('input[name="keyword"]').val(searchKeyword);
		$("#page").val(1);
		actionForm.submit();
		
	})
	
	// 글 읽기 리드페이지 이동
	$('.board').on("click",function(e){
		e.preventDefault();
		var bno= $(this).attr('href');
		
		actionForm
		.append("<input type='hidden' name='bno' value='"+bno+"'>");
		actionForm.attr("action",
		'/board/read').attr(
		'method', 'get').submit();
	})
	$('.pagination li[data-page=' + currentNum + '] button')
	.attr("style","background-color:lightgray;");

	//페이지 이동
	$('.pagination li a').on(
		'click',
		function(e) {
		e.preventDefault();
		var target = $(this).attr('href');
		$("#page").val(target);
		actionForm.attr("action", "/board/list")
				.attr("method", 'get').submit();

	});

 
	checkModal(result);

	history.replaceState({}, null, null);

	//모달 창 출력
	function checkModal(result) {

		if (result === '' || history.state) {
		return;
	
		}

	
		if (result === 'SUCCESS') {
			$(".modal-body").html("작업이 완료되었습니다.");
			msg.modal("show");
		}

	
	}
})

</script>