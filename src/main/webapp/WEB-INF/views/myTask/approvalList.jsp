<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="isTaskSide" value="active" />
	<jsp:param name="isTaskList" value="active" />
</jsp:include>

<link rel="stylesheet" href="${path}/resources/vendors/jquery-datatables/jquery.dataTables.bootstrap5.min.css">
<link rel="stylesheet" href="${path}/resources/vendors/fontawesome/all.min.css">

<style>
.nav-tabs .nav-link.active {
	color: white;
}

.nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
	background-color: #435ebe;
}
</style>

<script>
$(document).ready(function() {
	$("#cbx_chkAll1").click(function() {	
		if($("#cbx_chkAll1").is(":checked")) 
			$("input[name=chk1]").prop("checked", true);
		else 
			$("input[name=chk1]").prop("checked", false);
	});
		
	$("input[name=chk1]").click(function() {			
		let total = $("input[name=chk1]").length;
		let checked = $("input[name=chk1]:checked").length;
		
		if(total != checked) 
			$("#cbx_chkAll1").prop("checked", false);
		else 
			$("#cbx_chkAll1").prop("checked", true); 
	});
});

$(document).ready(function() {
	$("#cbx_chkAll2").click(function() {	
		if($("#cbx_chkAll2").is(":checked")) 
			$("input[name=chk2]").prop("checked", true);
		else 
			$("input[name=chk2]").prop("checked", false);
	});
		
	$("input[name=chk2]").click(function() {			
		let total = $("input[name=chk2]").length;
		let checked = $("input[name=chk2]:checked").length;
		
		if(total != checked) 
			$("#cbx_chkAll2").prop("checked", false);
		else 
			$("#cbx_chkAll2").prop("checked", true); 
	});
});
</script>

<div id="main-content" style="padding-top: 0">
	<div class="page-heading">
		<div class="page-title">
			<div class="row">
				<div class="col-12 col-md-6 order-md-1 order-last">
					<h3>내 작업</h3>
				</div>
			</div>
		</div>
		
		<section class="section">
			<div class="card">
				<div class="card-header">
						<p class="fw-bold">내 결재</p>
				</div>
				
				<div class="card-body">
					<ul class="nav nav-tabs" id="myTab" role="tablist">
						<li class="nav-item" role="presentation">
							<a class="nav-link active" id="home-tab" data-bs-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">승인대기</a>
						</li>
						<li class="nav-item" role="presentation">
							<a class="nav-link" id="profile-tab" data-bs-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">승인완료</a>
						</li>
						<li class="nav-item" role="presentation">
							<a class="nav-link" id="contact-tab" data-bs-toggle="tab" href="#contact" role="tab" aria-controls="contact" aria-selected="false">반려</a>
						</li>
					</ul>
					<div class="tab-content" id="myTabContent">
						<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
							<div class="row pt-3" style="background-color: #f2f7ff;">
								<div class="col-md-3">
									<fieldset class="form-group">
										<select class="form-select" id="basicSelect">
											<option>프로젝트를 선택하세요</option>
											<option>OTP 개발</option>
										</select>
									</fieldset>
								</div>
								<div class="col-md-3">
									<div class="input-group mb-3">
										<input type="text" class="form-control" placeholder="검색어를 입력하세요">
										<button class="btn btn-primary" type="button" id="searchBtn">검색</button>
									</div>
								</div>
								<div class="col-md-6">
									<div class="input-group mb-3 justify-content-end">
										<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#primary2" id="regBtn">회수</button>
									</div>
								</div>
							</div>
								
							<!-- Basic Tables start -->
							<table class="table" id="table1">
								<thead>	
									<tr>
										<th>
											<input type="checkbox" id="cbx_chkAll1" class="form-check-input">
										</th>
										<th>작업</th>
										<th>프로젝트</th>
										<th>승인자</th>
										<th>상태</th>
										<th>요청일</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
			                      		<c:when test="${WaitingList.size() > 0}">
			                      			<c:forEach var="wait" items="${WaitingList}">
												<tr>
													<td>
														<input type="checkbox" id="checkbox1" name="chk1" class="form-check-input">
 													</td>
														<td>${wait.taskName}</td>
														<td>${wait.pTitle}</td>
														<td>${wait.approver}</td>
														<td><span class="badge bg-secondary">${wait.apStatus}</span></td>
														<td><fmt:formatDate value="${wait.createAt}" pattern="yyyy-MM-dd"/></td>
													</tr>
			                       			</c:forEach>
			                      		</c:when>
			                      		<c:otherwise>
			                      			<tr>
			                      				<td colspan="6" style="text-align: center;"><h6>승인 대기중인 결재가 없습니다.</h6></td>
			                      			</tr>
			                      		</c:otherwise>
			                      	</c:choose>		
			                    </tbody>				
							</table>
							<!-- Basic Tables end -->
						</div>
	
						<div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
							<div class="row pt-3" style="background-color: #f2f7ff;">
								<div class="col-md-3">
									<fieldset class="form-group">
										<select class="form-select" id="basicSelect">
											<option>프로젝트를 선택하세요</option>
											<option>5G 수신환경</option>
										</select>
									</fieldset>
								</div>
								<div class="col-md-3">
									<div class="input-group mb-3">
										<input type="text" class="form-control" placeholder="검색어를 입력하세요">
										<button class="btn btn-primary" type="button" id="searchBtn">검색</button>
									</div>
								</div>
							</div>
									
							<!-- Basic Tables start -->
							<table class="table" id="table2">
								<thead>
									<tr>
										<th>작업</th>
										<th>프로젝트</th>
										<th>승인자</th>
										<th>상태</th>
										<th>요청일</th>
										<th>승인일</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
			                      		<c:when test="${CompletedList.size() > 0}">
			                      			<c:forEach var="complete" items="${CompletedList}">
												<tr>
													<td>${complete.taskName}</td>
													<td>${complete.pTitle}</td>
													<td>${complete.approver}</td>
													<td><span class="badge bg-secondary">${complete.apStatus}</span></td>
													<td><fmt:formatDate value="${complete.createAt}" pattern="yyyy-MM-dd"/></td>
													<td><fmt:formatDate value="${complete.approvalAt}" pattern="yyyy-MM-dd"/></td>
												</tr>
			                       			</c:forEach>
			                      		</c:when>
			                      		<c:otherwise>
			                      			<tr>
			                      				<td colspan="6" style="text-align: center;"><h6>승인 완료된 결재가 없습니다.</h6></td>
			                      			</tr>
			                      		</c:otherwise>
			                      	</c:choose>		
								</tbody>
							</table>
							<!-- Basic Tables end -->			
						</div>
							
						<div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
							<div class="row pt-3" style="background-color: #f2f7ff;">
								<div class="col-md-3">
									<fieldset class="form-group">
										<select class="form-select" id="basicSelect">
											<option>프로젝트를 선택하세요</option>
											<option>OTP 개발</option>
										</select>
									</fieldset>
								</div>
								<div class="col-md-3">
									<div class="input-group mb-3">
										<input type="text" class="form-control" placeholder="검색어를 입력하세요">
										<button class="btn btn-primary" type="button" id="searchBtn">검색</button>
									</div>
								</div>
								<div class="col-md-6">
									<div class="input-group mb-3 justify-content-end">
										<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#primary2" id="regBtn">회수</button>
									</div>
								</div>
							</div>
								
							<!-- Basic Tables start -->
							<table class="table" id="table3">
								<thead>
									<tr>
										<th>
											<input type="checkbox" id="cbx_chkAll2" class="form-check-input">
										</th>
										<th>작업</th>
										<th>프로젝트</th>
										<th>승인자</th>
										<th>상태</th>
										<th>요청일</th>
										<th>반려일</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
			                      		<c:when test="${RejectedList.size() > 0}">
			                      			<c:forEach var="reject" items="${RejectedList}">
												<tr>
													<td>
														<input type="checkbox" id="checkbox1" name="chk2" class="form-check-input">
 													</td>
														<td>${reject.taskName}</td>
														<td>${reject.pTitle}</td>
														<td>${reject.approver}</td>
														<td><span class="badge bg-secondary">${reject.apStatus}</span></td>
														<td><fmt:formatDate value="${reject.createAt}" pattern="yyyy-MM-dd"/></td>
														<td><fmt:formatDate value="${reject.rejectAt}" pattern="yyyy-MM-dd"/></td>
													</tr>
			                       			</c:forEach>
			                      		</c:when>
			                      		<c:otherwise>
			                      			<tr>
			                      				<td colspan="12" style="text-align: center;"><h6>반려된 결재가 없습니다.</h6></td>
			                      			</tr>
			                      		</c:otherwise>
			                      	</c:choose>		
								</tbody>
							</table>
							<!-- Basic Tables end -->
	                        </div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
	
	<!-- 작업정보 modal -->
	<div class="modal fade text-left" id="primary" tabindex="-1"
		role="dialog" data-bs-backdrop="static"
		aria-labelledby="myModalLabel160" aria-hidden="true">
		<div
			class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg"
			role="document">
			<div class="modal-content">
				<div class="modal-header" style="padding-bottom: 0;">
					<ul class="nav nav-tabs" id="myTab" role="tablist">
						<li class="nav-item" role="presentation">
							<a class="nav-link active" id="home-tab" data-bs-toggle="tab" href="#home2" role="tab" aria-controls="home2" aria-selected="true">작업정보</a>
						</li>
						<li class="nav-item" role="presentation">
							<a class="nav-link" id="profile-tab" data-bs-toggle="tab" href="#profile2" role="tab" aria-controls="profile2" aria-selected="false">산출물</a>
						</li>
					</ul>
				</div>
				<div class="tab-content" id="myTabContent">
					<div class="tab-pane fade show active" id="home2" role="tabpanel" aria-labelledby="home-tab">
						<div class="modal-body">
							<form class="form">
								<div class="row">
									<div class="col-12">
									</div>
									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="first-name-column" style="padding-bottom: 6px;">작업</label>
                                            <input type="text" style="background-color: white;" id="first-name-column" class="form-control"
                                                value="시장 환경 조사" name="fname-column" readonly>
										</div>
									</div>
									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="first-name-column"  style="padding-bottom: 6px;">프로젝트</label>
                                            <input type="text" style="background-color: white;" id="first-name-column" class="form-control"
                                                value="빌링서비스 개발" name="fname-column" readonly>
										</div>
									</div>
									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="first-name-column"  style="padding-bottom: 6px;">시작일</label>
                                            <input type="text" style="background-color: white;" id="first-name-column" class="form-control"
                                                value="2022-04-15" name="fname-column" readonly>
										</div>
									</div>
									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="first-name-column"  style="padding-bottom: 6px;">완료일</label>
                                            <input type="text" style="background-color: white;" id="first-name-column" class="form-control"
                                                value="2022-04-28" name="fname-column" readonly>
										</div>
									</div>
									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="first-name-column" style="padding-bottom: 6px;">진행률(%)</label>
                                            <input type="number" style="background-color: white;" id="first-name-column" class="form-control"
                                                value="100" name="fname-column" readonly>
										</div>
									</div>
									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="first-name-column"  style="padding-bottom: 6px;">승인자</label>
                                            <input type="text" style="background-color: white;" id="first-name-column" class="form-control"
                                                value="홍길동" name="fname-column" readonly>
										</div>
									</div>
									<div class="col-12">
										<div class="form-group">
											<label for="exampleFormControlTextarea1" class="form-label">작업 세부내용</label>
											<textarea class="form-control" id="exampleFormControlTextarea1" rows="3" readonly style="background-color: white"></textarea>
										</div>
									</div>
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary ml-1">
								<i class="bx bx-check d-block d-sm-none"></i>
								<span class="d-none d-sm-block">등록</span>
							</button>
							<button type="button" class="btn btn-light-secondary" data-bs-dismiss="modal">
								<i class="bx bx-x d-block d-sm-none"></i> 
								<span class="d-none d-sm-block">취소</span>
							</button>
						</div>
					</div>
					
					<div class="tab-pane fade" id="profile2" role="tabpanel" aria-labelledby="profile-tab">
						<div class="modal-body">
							<form class="form">
								<div class="row">
									<div class="col-12">
									</div>
									<div class="col-12">
										<div class="form-group">
											<label for="first-name-column" style="padding-bottom: 6px;">파일</label>
                                            <input type="text" style="background-color: white;" id="first-name-column" class="form-control"
                                                value="파일명" name="fname-column" readonly>
										</div>
									</div>
									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="first-name-column"  style="padding-bottom: 6px;">프로젝트</label>
                                            <input type="text" style="background-color: white;" id="first-name-column" class="form-control"
                                                value="2022-04-15" name="fname-column" readonly>
										</div>
									</div>
									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="first-name-column"  style="padding-bottom: 6px;">작업</label>
                                            <input type="text" style="background-color: white;" id="first-name-column" class="form-control"
                                                value="2022-04-28" name="fname-column" readonly>
										</div>
									</div>
									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="first-name-column" style="padding-bottom: 6px;">산출물 카테고리</label>
                                            <input type="number" style="background-color: white;" id="first-name-column" class="form-control"
                                                value="100" name="fname-column" readonly>
										</div>
									</div>
									<div class="col-md-6 col-12">
										<div class="form-group">
											<label for="first-name-column"  style="padding-bottom: 6px;">산출물 종류</label>
                                            <input type="text" style="background-color: white;" id="first-name-column" class="form-control"
                                                value="홍길동" name="fname-column" readonly>
										</div>
									</div>
									<div class="col-12">
										<div class="form-group">
											<label for="exampleFormControlTextarea1" class="form-label">산출물 설명</label>
											<textarea class="form-control" id="exampleFormControlTextarea1" rows="3" readonly style="background-color: white;"></textarea>
										</div>
									</div>
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary ml-1">
								<i class="bx bx-check d-block d-sm-none"></i>
								<span class="d-none d-sm-block">등록</span>
							</button>
							<button type="button" class="btn btn-light-secondary"
								data-bs-dismiss="modal">
								<i class="bx bx-x d-block d-sm-none"></i> 
								<span class="d-none d-sm-block">취소</span>
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
<script src="${path}/resources/vendors/jquery-datatables/jquery.dataTables.min.js"></script>
<script src="${path}/resources/vendors/jquery-datatables/custom.jquery.dataTables.bootstrap5.min.js"></script>
<script src="${path}/resources/vendors/fontawesome/all.min.js"></script>

<script>
	// Jquery Datatable
	$("#table1").DataTable({
		"searching": false,
		"info": false,
		"lengthChange": false,
		"autoWidth" : false,
		"columnDefs": [
		    {"className": "dt-center", "targets": "_all"},
		    {"orderable": false, "targets": 0},
		    {"width": "5%", "targets": 0},
		    {"width": "25%", "targets": 1},
		    {"width": "25%", "targets": 2}
		],
		"order": [5, 'desc']
	});

	$("#table2").DataTable({
		"searching": false,
		"info": false,
		"lengthChange": false,
		"autoWidth" : false,
		"columnDefs": [
		    {"className": "dt-center", "targets": "_all"},
		    {"width": "25%", "targets": 0},
		    {"width": "25%", "targets": 1}
		],
		"order": [5, 'desc']
	});
	
	$("#table3").DataTable({
		"searching": false,
		"info": false,
		"lengthChange": false,
		"autoWidth" : false,
		"columnDefs": [
		    {"className": "dt-center", "targets": "_all"},
		    {"orderable": false, "targets": 0},
		    {"width": "5%", "targets": 0},
		    {"width": "25%", "targets": 1},
		    {"width": "25%", "targets": 2}
		],
		"order": [6, 'desc']
	});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>