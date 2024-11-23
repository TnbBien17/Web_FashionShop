<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<div class="container">
	<h2 class="display-6 my-3">Nhãn hiệu</h2>
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
		data-bs-action="Thêm nhãn hiệu" type="button"
		class="btn btn-primary createbtn">
		<i class="fa-solid fa-plus"></i> <span>Thêm nhãn hiệu</span>
	</button>
	<div class="table-responsive">
		<table style="margin: 10px 5px;" id="table"
			class="table-striped table bg-white">
			<thead class="table-dark">
				<tr style="font-weight: bold">
					<th>ID</th>
					<th>Tên</th>
					<th style="width: 200px;">Tác vụ</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="i" items="${listBrands}">
					<tr>
						<td>${i.id}</td>
						<td>${i.name}</td>
						<td>
							<a class="btn btn-outline-info" href="<c:url value="/brand/${i.id}"/>">
								<i class="fa-solid fa-circle-info"></i>
							</a> 
							<a data-bs-toggle="modal" data-bs-target="#insertModal"
			data-bs-action="Sửa nhãn hiệu" class="btn btn-outline-warning editbtn">
								<i class="fa-solid fa-pen-to-square"></i> 
							</a>
							<a href="brand/delete/${i.id}" class="btn btn-outline-danger">
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
				<form action="brand/save" method="post">
					<div class="modal-body">
						<div class="row">
							<div class="col-md-6">
								<label for="recipient-name" class="col-form-label">ID:</label> 
								<input name="id" readonly type="text" class="form-control" id="id">
							</div>
							<div class="col-md-6 ms-auto">
								<label for="recipient-name" class="col-form-label">Tên nhãn hiệu:</label> 
								<input name="name" type="text" class="form-control" id="name">
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Đóng</button>
						<button type="submit" class="btn btn-primary">
							<i class="fa-solid fa-floppy-disk"></i> <span>Xác nhận</span>
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 		End Insert modal -->
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
// 		window.onload = () => {
// 	        $('#insertModal').modal('show');
// 	    }
		const id = document.getElementById('id')
		const name = document.getElementById('name')
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