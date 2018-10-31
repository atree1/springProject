<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>


<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
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

.uploadResult ul li img {
	width: 100px;
}

.uploadResult ul li span {
	color: white;
}

.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255, 255, 255, 0.5);
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}
</style>
<div class="col-md-6 grid-margin stretch-card">
	<div class="card">
		<div class="card-body">
			<h4 class="card-title">Basic form</h4>
			<p class="card-description">Basic form elements</p>
			<form id='modifyForm' class="forms-sample" role="form"
				action="/board/modify" method="post">
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
					<label>File upload</label> <input type="file" name="uploadFile"
						multiple="multiple" class="file-upload-default">
					<div class="input-group col-xs-12">
						<input type="text" class="form-control file-upload-info" disabled
							placeholder="Upload Image"> </span>
					</div>

					<div class='uploadResult'></div>
				</div>
				<input type='hidden' name='page' value='${pageObj.page}'> <input
					type="hidden" name='bno' value='${board.bno}'> <input
					type='hidden' name='type' value='${pageObj.type}'> <input
					type='hidden' name='keyword' value='${pageObj.keyword}'>

			</form>

			<form id='actionForm' action="/board/read">
				<input type="hidden" name='bno' value='${board.bno}'> <input
					type='hidden' name='page' value='${pageObj.page}'> <input
					type='hidden' name='type' value='${pageObj.type}'> <input
					type='hidden' name='keyword' value='${pageObj.keyword}'>
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
						str += "<span> "+ attach.fileName+"</span>";
						str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-icons btn-rounded btn-outline-warning'>x</button><br>";
						str += "<img src='/display?fileName="+fileCallPath+"'>";
						str += "</div>";
						str +"</li>";
						str += "<img src='/display?fileName="+fileCallPath+"'>";
						str += "</div>";
						str +"</li>";
					}else{
						  
						str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
						str += "<span> "+ attach.fileName+"</span>";
						str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn-rounded btn-outline-warning'>x</button><br>";
						str += "<img src='/resources/images/favicon.png'></a>";
						str += "</div>";
						str +"</li>";
					}
				});
		var actionForm=$('#actionForm');
		$('#modifyBtn').on("click", function(e) {
			e.preventDefault();
			$("#modifyForm").submit();
		})
		$('#removeBtn').on("click", function(e) {
			e.preventDefault();
			$("#actionForm").attr("method",'post').attr("action","/board/remove").submit();
		})
		$(".uploadResult").on("click","button",function(e){
			if(confirm("remove this file?")){
				var targetLi=$(this).closest("li");
				targetLi.remove();
			}
			
		});
		var regex=new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize=5242880;
		function checkExtension(fileName,fileSize){
			if(fileSize>=maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			if(regex.test(fileName)){
				alert('해당 파일 업로드 불가');
				return false;
			}
			return true;
		}
	
		$('#files').change(function(e){
			var formData=new FormData();
		
			var inputFile=$("input[name='uploadFile']");
			
			var files=inputFile[0].files;
			
			for(var i=0;i<files.length;i++){
				if(!checkExtension(files[i].name,files[i].size)){
					return false;
				}
				console.log(files[i]);
				formData.append("uploadFile",files[i]);
			}
			$.ajax({
				url:'/upload',
				processData:false,
				contentType:false,
				data:formData,
				type:'POST',
				dataType:'json',
				success:function(result){
					console.log(result);
					showUploadResult(result);
				}
			});
		});
		function showUploadResult(uploadResultArr) {
			if(!uploadResultArr||uploadResultArr.length==0){
				return;
			}
			var uploadUL=$(".uploadResult ul");
			var str="";
			$(uploadResultArr).each(function(i,obj){
				
				if(obj.fileType){
					var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
					str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"' ><div>";
					str += "<span> "+ obj.fileName+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-icons btn-rounded btn-outline-warning'>x</button><br>";
					str += "<img src='/display?fileName="+fileCallPath+"'>";
					str += "</div>";
					str +"</li>";
				}else{
					var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);			      
				    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
				      
					str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"' ><div>";
					str += "<span> "+ obj.fileName+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn-rounded btn-outline-warning'>x</button><br>";
					str += "<img src='/resources/images/favicon.png'></a>";
					str += "</div>";
					str +"</li>";
				}
			});
			uploadUL.append(str);
			
		}
		
		
		
		
	
	});
</script>