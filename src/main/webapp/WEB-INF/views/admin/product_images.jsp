<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<div class="container">
    <h2 class="display-6 my-3">Ảnh của <b>${product.name}</b> </h2>
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
	<div class="row">
		<div class="col-md-6">
			<form method="post" enctype='multipart/form-data'>
				<input type="hidden" name="id" value="${product.id}">
				<input name="image" class="form-control" type="file" accept="image/jpeg,image/png,image/gif" id="formFile" onchange="preview()">
				
				<button data-bs-toggle="modal" data-bs-target="#insertModal"
					data-bs-action="Thêm loại hàng" type="submit"
					class="btn btn-primary createbtn">
					<i class="fa-solid fa-floppy-disk"></i> <span>Xác nhận</span>
				</button>
			</form>
			<img id="frame" src="" class="img-fluid" />
		</div>
		<div class="col-md-6">
			<div style="width: 90%; height: 500px;" id="carouselExample" class="carousel carousel-dark slide">
			<div class="carousel-inner">
				<c:forEach items="${product.images}" var="image" varStatus="status">
				<div class="carousel-item ${status.index == 0 ? 'active' : ''}">
					<%-- <div class="col-md-3"> --%>
				<img src="<c:url value="/templates/images/${image.imageLink}"/>" style="height: auto;" class="d-block w-100" alt="...">
					<%-- delete button --%>
					<button data-bs-toggle="modal" data-bs-target="#warningModal"
						data-bs-id="${image.id}" type="submit"
						class="btn btn-danger deletebtn d-block w-75 mx-auto my-1">
						<i class="fa-solid fa-trash"></i> <span>Xóa</span>
					</button>
					<%-- </div> --%>
					</div>
				</c:forEach>


			</div>
			<button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
			</div>
		</div>
	</div>
</div>
<!-- 	Delete warning modal -->
	<div class="modal fade" id="warningModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Cảnh báo</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        Thao tác này không thể hoàn tác. <br>
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
 <script>
	function preview() {
		frame.src = URL.createObjectURL(event.target.files[0]);
	}
	function clearImage() {
		document.getElementById('formFile').value = null;
		frame.src = "";
	}
	const warningModal = document.getElementById('warningModal')
		warningModal.addEventListener('show.bs.modal', event => {
		  // Button that triggered the modal
		  const button = event.relatedTarget
		  // Extract info from data-bs-* attributes
		  const id = button.getAttribute('data-bs-id')
		  const modalDeleteBtn = warningModal.querySelector('#modalDeleteBtn')
		  modalDeleteBtn.href = "../image-delete/" + id 
		})
</script>