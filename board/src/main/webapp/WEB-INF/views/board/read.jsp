<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@include file="../includes/header.jsp"%>
<sec:authentication var="user" property="principal" />
<style>
#card{
width:100%;
}
li{
 list-style:none;
 
}
.page-item{
	display: inline-flex;
}
small{
float:right}
#addReplyBtn{
float:right;
}

@media (min-width: 768px){
.col-md-6 {
     flex: 0 0 100%; 
    max-width: 100%; 
  
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
 .addReplyBtn{
	justify-content: flex-end;
	align-items: flex-end;
}

</style>
<div class="bigPictureWrapper">
	<div class='bigPicture'>
	
	
	</div>
</div>
<div id='card' class="col-md-6 grid-margin stretch-card">
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
			
				<input type='hidden' name='display' value='${pageObj.display}'>
			<c:if test="${board.writer==user.username}">
				<button id='modify'class="btn btn-success mr-2">수정/삭제</button>
				</c:if>
				<button class="btn btn-danger">목록</button>
			</form>		
		</div>
		
		
		<div class='row'>
		<div class='col-lg-12'>
			<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-superpowers"></i>Reply
				<button id='addReplyBtn' class='btn-primary' >New Reply</button>
			</div>
			<div class="panel-body">
				<ul class="chat">
				
				</ul>
			
			</div>
			<div class="panel-footer">
			
			</div>
	</div>
	</div>
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
	<!-- Modal -->
	<div class="modal fade" id="replyModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">Modal title</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
					<label>Reply</label>
					<input class="form-control" name='reply' value=''>
					</div>
					<div class="form-group">
					<label>Replyer</label>
					<input type="text" class="form-control"  name='replyer' value='<c:out value="${user.username}" />' readonly="readonly">
					</div>
					
						<div class="form-group">
					<label>Reply Date</label>
					<input class="form-control" name='replydate'>
					</div>
						
					
				
				</div>
				<div class="modal-footer">
				<button id='modalModBtn' type="button" class= "btn btn-warning">수정</button>
				<button id='modalDelBtn' type="button" class= "btn btn-danger">삭제</button>
				<button id='modalRegBtn' type="button" class= "btn btn-primary">등록</button>
				<button id='modalRegBtn2' type="button" class= "btn btn-primary">답글</button>
				<button id='modalCloseBtn' type="button" class= "btn btn-default">닫기</button>
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
<script type="text/javascript" src="/resources/js/reply.js"></script>

<script>
	$(document).ready(function() {
		var actionForm=$('#actionForm');
		var result = '<c:out value="${result}"/>';
		var msg = $('#myModal');
		var bnoValue='<c:out value="${board.bno}"/>';
		var replyUL=$('.chat');
			showList(1);
		var pageNum=1;
		var replyPageFooter=$(".panel-footer");
		
		var modal=$("#replyModal");
		var modalInputReply=modal.find("input[name='reply']");
		var modalInputReplyer=modal.find("input[name='replyer']");
		var modalInputReplyDate=modal.find("input[name='replydate']");
		
		var modalModBtn=$("#modalModBtn");
		var modalDelBtn=$("#modalDelBtn");
		var modalRegBtn=$("#modalRegBtn");
		var modalRegBtn2=$("#modalRegBtn2");
		var modalCloseBtn=$("#modalCloseBtn");
		
		
		var parent=0;
		//모달창 출력
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
	
	
	
		//이미지 클릭시 원본이미지 보여주기 파일 다운로드
		$('.uploadResult').on("click","li",function(e){
			var liObj=$(this);
			var path=encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));
			
			if(liObj.data("type")){
				showImage(path.replace(new RegExp(/\\/g),"/"));
			}
		});
		
		//이미지 다운로드
		$(".uploadResult ul").on("click",'a',function(e){
			e.preventDefault();
			e.stopPropagation();
			var liObj=$(this).closest("li");
			var fileName=liObj.data("filename").replace(".","_");
			var path=encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+fileName);
			
			console.log(path);
			
			var link="/download?fileName="+path;
			self.location=link;
			
		});
		
		//원본 이미지 파일 출력
		function showImage(fileCallPath){
			
			$(".bigPictureWrapper").css("display","flex").show();
			
			$(".bigPicture")
			.html("<img src='/display?fileName="+fileCallPath+"'>").animate({width:'100%',height:'100%'},1000);
		}
		
		
		// 원본 이미지 파일 닫기
		$(".bigPictureWrapper").on("click",function(e){
			$(".bigPicture").animate({width:'0%',height:'0%'},1000);
			setTimeout(function(){
			$(".bigPictureWrapper").hide();}
		,1000);
		});
		
		
		//이미지 출력 즉시실행함수
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
						str+="<p><a href='"+fileCallPath+"'>"+attach.fileName+"</a></p>"
						str += "</div>";
						str +"</li>";
						console.log("filePath: "+fileCallPath);
					}else{
						  
						str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
						str += "<img src='/resources/images/favicon.png'></a>";
						str+="<p><a href='#'>"+attach.fileName+"</a></p>"
						str += "</div>";
						str +"</li>";
					}
				});
				
				$(".uploadResult ul").html(str);
			});
		})();
		
		
		
	
		
		
		// 수정버튼 클릭
		$('#modify').on("click", function(e) {
			e.preventDefault();
			console.log("등록~");

			actionForm.append("<input type='hidden' name='bno' value='"+${pageObj.bno}+"'>")
			.attr("action","/board/modify")
			.submit();
		})
		

		//댓글 페이지 이동
		replyPageFooter.on("click","li a",function(e){
			e.preventDefault();
			
			var targetPageNum=$(this).attr("href");
			pageNum=targetPageNum;
			
			showList(pageNum);
		});
	
	
	
	
		//댓글 페이지 10개 출력
		function showReplyPage(replyCnt){
			var endNum= Math.ceil(pageNum/10.0)*10;
			var startNum=endNum-9;
			
			var prev=startNum!=1;
			var next=false;
			
			if(endNum*10>=replyCnt){
				endNum=Math.ceil(replyCnt/10.0);
			}
			if(endNum*10 <replyCnt){
				next=true;
				
			}
			var str="<span><ul class='pagenation pull-right'>";
			if(prev){
				str+="<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>Previous</a></li>";
			}
			
			for(var i=startNum;i<=endNum;i++){
				var active=pageNum==i?"active":"";
				
				str+="<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
			}
			
			if(next){
				str+="<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>Next</a></li>";
			}
			str+="</ul></span></div>";
			replyPageFooter.html(str);
			
		}
		
		//댓글 리스트 출력
		function showList(page){
			replyService.getList({bno:bnoValue ,page:page||1},
			function(replyCnt,list){
				
				console.log("str");
				
				if(page==-1){
					pageNum=Math.ceil(replyCnt/10.0);
					console.log("pageNum:"+pageNum);
					showList(pageNum);
					return;
				}
				
				var str="";
				
				if(list==null||list.length==0)
				{
					replyUL.html("");
					return ;
				}
				console.log("list: "+list);
				for(var i=0,len=list.length||0;i<len;i++){			
						
						str+="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
						if(list[i].depth==1){
							str+=" <div style='margin-left:30px'><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
						}else{
					str+=" <div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
						}
						str+="<small class='pull-right text-muted'>"+replyService.displayTime(list[i].replydate)+"</small></div>";
					str+="<p>"+list[i].reply+"</p>";
					str+="<button class='btn btn-outline-info' id='addDoubleReplyBtn' data-parent='"+list[i].parent+"' data-rno='"+list[i].rno+"'>답글</button></div></li>"
				
				
				}
				
				parent=list[list.length-1].parent;
				replyUL.html(str);
				
				showReplyPage(replyCnt);
			});
		}
		
		
		
		//댓글 추가 모달창   
		$("#addReplyBtn").on("click",function(e){
			//modal.find("input").val();
			modalInputReplyDate.closest('div').hide();
			modal.find("button[id!='modalCloseBtn']").hide();
			
		   modalRegBtn.show();
		modal.modal('show');
		
		});
		
		//댓글 등록
		modalRegBtn.on("click",function(e){
			var reply={
					reply:modalInputReply.val(),
					replyer:modalInputReplyer.val(),
					bno:bnoValue,
					parent:++parent,
					depth:0
			};
			replyService.add(reply,function(result){
				alert(result)
				
				modal.find("input").val("");
				modal.modal("hide");
				showList(1);
			});
			});
		
		//수정 모달창
		 $(".chat").on("click" ,"li",function(e){
			 var rno=$(this).data("rno");
			 replyService.get(rno,function(reply){
				 modalInputReply.val(reply.reply);
				 modalInputReplyer.val(reply.replyer);
				 modalInputReplyDate.val(replyService.displayTime(reply.replydate)).attr("readonly","readonly");
				 modal.data("rno",reply.rno);
				 
				 modal.find("button[id !='modalCloseBtn']").hide();
				 modalModBtn.show();
				 modalDelBtn.show();
				 
				 modal.modal("show");
			 
			 
			 })
		 });
		
		
		//댓글 수정
		modalModBtn.on("click",function(e){
			var reply={rno:modal.data("rno"),reply:modalInputReply.val()};
			replyService.update(reply,function(result){
				alert(result);
				modal.modal("hide");
				showList(1);
			})
		});
		
		//댓글 삭제
		modalDelBtn.on("click",function(e){
			var reply={rno:modal.data("rno"),reply:modalInputReply.val()};
			replyService.remove(reply,function(result){
				alert(result);
				modal.modal("hide");
				showList(1);
			})
		})
		
		//취소 버튼
		modalCloseBtn.on("click",function(e){
			modal.modal("hide");
		})
		
		
		//대댓글 추가 모달창
		$(".chat").on('click','li button',function(e){
			e.preventDefault();
			e.stopPropagation();
			var btn=e.target;
		
			parent=btn.getAttribute("data-parent");
			
			modalInputReplyDate.closest('div').hide();
			modal.find("button[id!='modalCloseBtn']").hide();
		
		   modalRegBtn2.show();
			modal.modal('show');
			
			
			
		});
		
		//대댓글 등록
		modalRegBtn2.on("click",function(e){
			var reply={
					reply:modalInputReply.val(),
					replyer:modalInputReplyer.val(),
					bno:bnoValue,
					parent:parent,
					depth:1
					
			};
			replyService.add(reply,function(result){
				alert(result)
				
				modal.find("input").val("");
				modal.modal("hide");
				showList(1);
			});
			
		});
	});
</script>