<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

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
	background-color: gray;
	overflow:auto;
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


</style>

<div id='card' class="col-md-12 grid-margin stretch-card">
	<div class="card">
		<div class="card-body">
			<form id='registerForm' class="forms-sample" method="post">
				<div class="form-group">
					<label for="exampleInputEmail3">WRITER</label> <input type="text"
						class="form-control" id="exampleInputEmail3"
						placeholder="아이디를 입력하세요" name='writer'>
				</div>
				<div class="form-group">
					<label for="exampleInputName1">TITLE</label> <input type="text"
						class="form-control" id="exampleInputName1"
						placeholder="제목을 입력하세요" name='title'>
				</div>

				<label for="exampleTextarea1">CONTENT</label>
				<textarea class="form-control" id="exampleTextarea1" rows="2"
					name='content' placeholder="내용을 입력하세요"></textarea>


				<div class="form-group">
					<input type="file" id='files' name='uploadFile' class="form-control file-upload-info"
						multiple="multiple">

				</div>
				<div class="uploadResult">
				<ul></ul>
				</div>

			</form>
		</div>
		<form action="/board/list">
			<div>
				<button id='registerBtn' class="btn btn-success mr-2">등록</button>
				<button id='cancleBtn' class="btn btn-danger">취소</button>
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
		var uploadResult=$('.uploadResult');
		
		$('.uploadResult').on("click","button",function(e){
			e.preventDefault();
			var targetFile=$(this).data("file");
			var type=$(this).data("type");
			var targetLi=$(this).closest('li');
			console.log(targetFile);
			$.ajax({
				url:'/deleteFile',
			data:{fileName:targetFile,type:type},
			dataType:'text',
			type:'POST',
			success:function(result){
				alert(result);
				targetLi.remove();
			}
			});
		});
		$('#registerBtn').on("click", function(e) {
			e.preventDefault();
			var registerForm=$('#registerForm');
			console.log($("uploadResult ul li"));
			var str="";
			$(".uploadResult ul li").each(function(i,obj){
				var jobj=$(obj);
				console.log(jobj);
				str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
				str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
				
			})
			console.log(str);
			registerForm.append(str).submit();
		});
		var result = '<c:out value="${result}"/>';

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