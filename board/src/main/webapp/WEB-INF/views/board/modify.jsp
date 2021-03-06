<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@include file="../includes/header.jsp"%>


<style>
#card{
width:100%;
}
@media (min-width: 768px){
.col-md-6 {
     flex: 0 0 100%; 
    max-width: 100%; 
}
}

.uploadResult {
	width: 100%;
	min-height:200px;
	background-color: gray;
	overflow:auto;
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
<sec:authentication var="user" property="principal" />
	<c:if test="${board.writer!=user.username}">
	<script>
	window.location.href="/board/list";
	</script>
	</c:if>
<div id=card class="col-md-6 grid-margin stretch-card">
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
					<input type="file" id='files' name='uploadFile' class="form-control file-upload-info"
						multiple="multiple">

				</div>

					<div class='uploadResult'>
					<ul>
					</ul>
					</div>
			
				<input type='hidden' name='page' value='${pageObj.page}'>
				 <input	type="hidden" name='bno' value='${board.bno}'> 
				 <input type='hidden' name='type' value='${pageObj.type}'> 
				 <input type='hidden' name='keyword' value='${pageObj.keyword}'>
				<input type='hidden' name='display' value='${pageObj.display}'>
 				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> 
			</form>
	</div>
			<form action="/board/remove" method="post">
				
				<input type="hidden" name='bno' value='${board.bno}'> 
				<input type='hidden' name='page' value='${pageObj.page}'>
				 <input type='hidden' name='type' value='${pageObj.type}'> 
				 <input type='hidden' name='keyword' value='${pageObj.keyword}'>
				 <input type='hidden' name='display' value='${pageObj.display}'>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> 
				<button id='modifyBtn' class="btn btn-success">수정</button>
				<button id='removeBtn' class="btn btn-warning">삭제</button>
				<button id='cancleBtn' class="btn btn-danger">취소</button>
			</form>
			<form id='actionForm' action="/board/read">
				<input type="hidden" name='bno' value='${board.bno}'> 
				<input type='hidden' name='page' value='${pageObj.page}'> 
				<input type='hidden' name='type' value='${pageObj.type}'> 
				<input type='hidden' name='keyword' value='${pageObj.keyword}'>
				<input type='hidden' name='display' value='${pageObj.display}'>
			</form>
		</div>
	</div>


<!-- content-wrapper ends -->
<!-- partial:../../partials/_footer.html -->

<%@include file="../includes/footer.jsp"%>



<script>
	$(document).ready(function() {
	
		var regex=new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize=5242880;
		var uploadResult=$('.uploadResult');
	    var csrfHearderName = "${_csrf.headerName}";
	      var csrfTokenValue = "${_csrf.token}";
	      
	      $(document).ajaxSend(function(e,xhr,options){
	         xhr.setRequestHeader(csrfHearderName, csrfTokenValue);
	      });
	      
	      uploadResult.on("dragenter dragover" ,function(e){
	    	  
		    	 e.preventDefault(); 
		      });
		      uploadResult.on("drop",function(e){
		    	  e.preventDefault();
		    	  var formData=new FormData();
		  		
					var files=e.originalEvent.dataTransfer.files;
					console.log(files);	
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
		      })
		//이미지 리스트 출력
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
					
					}else{
						  
						str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
						str += "<span> "+ attach.fileName+"</span>";
						str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn-rounded btn-outline-warning'>x</button><br>";
						str += "<img src='/resources/images/document.jpg'></a>";
						str += "</div>";
						str +"</li>";}
					
					});
				
				$(".uploadResult ul").html(str);
			});
		})();
		
		
		//수정버튼 클릭시
		var actionForm=$('#actionForm');
		$('#modifyBtn').on("click", function(e) {
			e.preventDefault();
			var str="";
			$(".uploadResult ul li").each(function(i,obj){
				var jobj=$(obj);
				console.log(jobj);
				str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
				
			})
			
			$("#modifyForm").append(str).submit();
		});
		
		//삭제버튼
		$('#cancleBtn').on("click", function(e) {
			e.preventDefault();
				$("#actionForm").submit();
		});
		
		//이미지 삭제
		$(".uploadResult").on("click","button",function(e){
			if(confirm("remove this file?")){
				var targetLi=$(this).closest("li");
				targetLi.remove();
			}
			
		});
		
		//파일 사이즈 ,확장자 체크
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
		
		//파일 업로드
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
		
		//업로드 출력
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
					str += "<img src='/resources/images/document.jpg'></a>";
					str += "</div>";
					str +"</li>";
				}
			});
			uploadUL.append(str);
			
		}
		
		
		
		
		
		
	
	})
</script>