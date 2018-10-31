<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>

<style>
.uploadResult {
  width:100%;
  background-color: gray;
}
.uploadResult ul{
  display:flex;
  flex-flow: row;
  justify-content: center;
  align-items: center;
}
.uploadResult ul li {
  list-style: none;
  padding: 10px;
  align-content: center;
  text-align: center;
}
.uploadResult ul li img{
  width: 100px;
}
.uploadResult ul li span {
  color:white;
}
.bigPictureWrapper {
  position: absolute;
  display: none;
  justify-content: center;
  align-items: center;
  top:0%;
  width:100%;
  height:100%;
  background-color: gray; 
  z-index: 100;
  background:rgba(255,255,255,0.5);
}
.bigPicture {
  position: relative;
  display:flex;
  justify-content: center;
  align-items: center;
}
</style>
<div class="bigPictureWrapper">
	<div class='bigPicture'>
	
	
	</div>
</div>
<div class="col-md-6 grid-margin stretch-card">
	<div class="card">
		<div class="card-body">
			<h4 class="card-title">Basic form</h4>
			<p class="card-description">Basic form elements</p>

			<div class="form-group">
				<label for="exampleInputName1">BNO</label> <input type="text"
					class="form-control" id="exampleInputName1" placeholder="Name"
					value='<c:out value="${board.bno}"/>' readonly="readonly">
			</div>
			<div class="form-group">
				<label for="exampleInputEmail3">WRITER</label> <input type="email"
					class="form-control" id="exampleInputEmail3" placeholder="Email"
					value='<c:out value="${board.writer}"/>' readonly="readonly">
			</div>
			<div class="form-group">
				<label for="exampleInputPassword4">TITLE</label> <input type="text"
					class="form-control" id="exampleInputPassword4"
					placeholder="Password" value='<c:out value="${board.title}"/>'
					readonly="readonly">
			</div>

			<label for="exampleTextarea1">CONTENT</label>
			<textarea class="form-control" id="exampleTextarea1" rows="2"
				readonly="readonly"><c:out value="${board.content}" /></textarea>
		</div>

		<div class="form-group">
			<label>File upload</label> <input type="file" name="img[]"
				class="file-upload-default">
			<div class="input-group col-xs-12">
				<input type="text" class="form-control file-upload-info" disabled
					placeholder="Upload Image"> 
			</div>
			
			<div class='uploadResult'>
			
				<ul>
				</ul>
			</div>
			
			
			<form id='actionForm' action='/board/list'>
				<input type='hidden' name='page' value='${pageObj.page}'>
				<button id='modify'class="btn btn-success mr-2">수정/삭제</button>
				<button class="btn btn-danger">목록</button>
			</form>		
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
	
</div>


<!-- content-wrapper ends -->
<!-- partial:../../partials/_footer.html -->

<%@include file="../includes/footer.jsp"%>



<script>
	$(document).ready(function() {
		$('.uploadResult').on("click","li",function(e){
			var liObj=$(this);
			var path=encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));
			
			if(liObj.data("type")){
				showImage(path.replace(new RegExp(/\\/g),"/"));
			}else{
				self.location="/download?fileName="+path;
			}
		});
		function showImage(fileCallPath){
			
			$(".bigPictureWrapper").css("display","flex").show();
			
			$(".bigPicture")
			.html("<img src='/display?fileName="+fileCallPath+"'>").animate({width:'100%',height:'100%'},1000);
		}
		$(".bigPictureWrapper").on("click",function(e){
			$(".bigPicture").animate({width:'0%',height:'0%'},1000);
			setTimeout(function(){
			$(".bigPictureWrapper").hide();}
		,1000);
		});
		(function() {
			var bno='<c:out value="${board.bno}"/>';
			$.getJSON("/board/getAttachList",{bno:bno},function(arr){
				console.log(arr);
				var str="";
				$(arr).each(function(i, attach){
					
					//image type
					if(attach.fileType){
						var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
						
						str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
						str += "<img src='/display?fileName="+fileCallPath+"'>";
						str += "</div>";
						str +"</li>";
					}else{
						  
						str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
						str += "<span> "+ attach.fileName+"</span><br/>";
						str += "<img src='/resources/img/attach.png'></a>";
						str += "</div>";
						str +"</li>";
					}
				});
				
				$(".uploadResult ul").html(str);
			});
		})();
		var actionForm=$('#actionForm');
		$('#modify').on("click", function(e) {
			e.preventDefault();
			console.log("등록~");

			actionForm.append("<input type='hidden' name='bno' value='"+${pageObj.bno}+"'>")
			.attr("action","/board/modify")
			.submit();
		})
		var result = '<c:out value="${result}"/>';
var msg = $('#myModal');

checkModal(result);
history.replaceState({}, null, null);

function checkModal(result) {
	if (result === '' || history.state) {
		return;
	}

	if (result === 'SUCCESS') {
		$(".modal-body").html("작업이 완료되었습니다.");
		msg.modal("show");
	}
}
	
	});
</script>