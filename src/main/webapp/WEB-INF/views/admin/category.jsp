<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/common/taglib.jsp"%>
<div class="container">
	<h2 class="display-6 my-3">Loại hàng</h2>
	<c:if test="${message != null}">

		<div class="alert alert-primary alert-dismissible" role="alert">

			<i>${message}</i>
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>

	</c:if>
	<c:if test="${error != null}">

		<div class="alert alert-danger alert-dismissible" role="alert">

			<i>${error}</i>
			<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>

	</c:if>
	<button data-bs-toggle="modal" data-bs-target="#insertModal"
		data-bs-action="Thêm loại hàng" type="button"
		class="btn btn-primary createbtn">
		<i class="fa-solid fa-plus"></i> <span>Thêm loại hàng</span>
	</button>
	<div class="table-responsive">
		<table style="margin: 10px 5px;" id="table"
			class="table-striped table bg-white">
			<thead class="table-dark">
				<tr style="font-weight: bold">
					<th>ID</th>
					<th>Tên</th>
					<th>Mô tả</th>
					<th style="width: 200px;">Tác vụ</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="i" items="${list}">
					<tr>
						<td>${i.id}</td>
						<td>${i.name}</td>
						<td>${i.icon}</td>
						<td>
							<a class="btn btn-outline-info" href="<c:url value="/category/${i.id}"/>">
								<i class="fa-solid fa-circle-info"></i>
							</a> 
							<a data-bs-toggle="modal" data-bs-target="#insertModal"
			data-bs-action="Sửa loại hàng" class="btn btn-outline-warning editbtn">
								<i class="fa-solid fa-pen-to-square"></i> 
							</a>
							<a data-bs-id="${i.id}" data-bs-toggle="modal" data-bs-target="#warningModal" class="btn btn-outline-danger">
								<i class="fa-solid fa-trash"></i>
							</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<!-- 		Insert modal -->
	<div class="modal fade" id="insertModal" tabindex="-1"
		aria-labelledby="insertModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-scrollable modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="insertModalLabel">New message</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<form:form modelAttribute="category" action="category/save" method="post">
					<div class="modal-body">
						<div class="row">
							<div class="col-md-6">
								<label for="recipient-name" class="col-form-label">ID:</label> 
								<form:input path="id" readonly="true" type="text" class="form-control" id="id"/>
							</div>
							<div class="col-md-6 ms-auto">
								<label for="recipient-name" class="col-form-label">Tên:</label> 
								<form:input path="name" type="text" class="form-control" id="name"/>
							</div>
						</div>
						<div class="mb-3">
							<label for="message-text" class="col-form-label">Icon:</label>
							<form:input path="icon" type="text" class="form-control" id="icon"/>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Đóng</button>
						<button type="submit" class="btn btn-primary">
							<i class="fa-solid fa-floppy-disk"></i> <span>Xác nhận</span>
						</button>
					</div>
				</form:form>
			</div>
		</div>
	</div>
	<!-- 		End Insert modal -->
<!-- 	Delete warning modal -->
	<div class="modal fade" id="warningModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Cảnh báo</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
         <br> Xóa Loại Hàng
        Bạn muốn tiếp tục?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
        <a id="modalDeleteBtn" type="button" class="btn btn-danger">
        	<i class="fa-solid fa-trash"></i>
        	<span>Tiếp tục</span>
        </a>
      </div>
    </div>
  </div>
</div>
<!-- 	    End Delete warning modal -->
  </div>
</div>
</div>

<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.5.0/js/responsive.bootstrap5.min.js"></script>
<script>
		const insertModal = document.getElementById('insertModal')
		insertModal.addEventListener('show.bs.modal', event => {
		  // Button that triggered the modal
		  const button = event.relatedTarget
		  // Extract info from data-bs-* attributes
		  const action = button.getAttribute('data-bs-action')
		  const modalTitle = insertModal.querySelector('.modal-title')
	
		  modalTitle.textContent = action
		  
		})
		const warningModal = document.getElementById('warningModal')
		warningModal.addEventListener('show.bs.modal', event => {
		  // Button that triggered the modal
		  const button = event.relatedTarget
		  // Extract info from data-bs-* attributes
		  const id = button.getAttribute('data-bs-id')
		  const modalDeleteBtn = warningModal.querySelector('#modalDeleteBtn')
		  modalDeleteBtn.href = "category/delete/" + id
		})
// 		window.onload = () => {
// 	        $('#insertModal').modal('show');
// 	    }
		const id = document.getElementById('id')
		const name = document.getElementById('name')
		const icon = document.getElementById('icon')
		 $(document).ready(function(){
		        $('.editbtn').on('click', function(){
		
		            $('#insertModal').modal('show');
		            $tr =$(this).closest('tr');
		            var data= $tr.children("td").map(function(){
		              return $(this).text();
		            }).get();
					console.log(data)
					id.value = data[0]
					name.value = data[1]
					icon.value = data[2]
// 					var Imagedata = [];
// 					Imagedata.push($tr.find('img').attr('src'))
// 		            $('#SetImage').attr("src",Imagedata[0]);
					
// 		            $('#title').val(data[0]);
// 		            $('#quantity').val(data[1]);
// 		            $('#size').val(data[2]);
		            
		        });
		        $('.createbtn').on('click', function(){
		    		
		            $('#insertModal').modal('show');
		            $tr =$(this).closest('tr');
		            var data= $tr.children("td").map(function(){
		              return $(this).text();
		            }).get();
					console.log(data)
					id.value = ''
					name.value = ''
					price.value = ''
					stock.value = ''
					description.value = ''
		        });
		    });
		new DataTable('#table', {
				pagingType : 'full_numbers',
				"pageLength" : 5,
				responsive: true,
			});
	</script>