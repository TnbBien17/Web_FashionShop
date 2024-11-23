<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<h2 class="display-6 my-3">Cập nhật sản phẩm</h2>
		<form>
			<div class="row">
				<div class="col-md-6">
					<label for="recipient-name" class="col-form-label">ID:</label> 
					<input readonly type="text" class="form-control" id="recipient-name">
				</div>
				<div class="col-md-6 ms-auto">
					<label for="recipient-name" class="col-form-label">Tên sản
					phẩm:</label> <input type="text" class="form-control" id="recipient-name">
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<label for="recipient-name" class="col-form-label">Giá:</label> <input
						type="number" class="form-control" id="recipient-name">
				</div>
				<div class="col-md-6 ms-auto">
					<label for="recipient-name" class="col-form-label">Số lượng
						tồn:</label> <input type="number" class="form-control" id="recipient-name">
				</div>
			</div>

			<div class="row">
				<div class="col-md-6">
					<label for="recipient-name" class="col-form-label">Nhãn
						hiệu:</label> <select class="form-control" name="categoryID">
						<%-- 									<c:forEach var="item" items="${listcate}"> --%>
						<option value="test">test</option>
						<%-- 										/c:forEach> --%>
					</select>
				</div>
				<div class="col-md-6 ms-auto">
					<label for="recipient-name" class="col-form-label">Loại
						hàng:</label> <select class="form-control" name="categoryID">
						<%-- 										<c:forEach var="item" items="${listcate}"> --%>
						<option value="test">test</option>
						<%-- 										/c:forEach> --%>
					</select>
				</div>
			</div>

			<div class="mb-3">
				<label for="message-text" class="col-form-label">Mô tả:</label>
				<textarea class="form-control" id="message-text"></textarea>
			</div>
			<div class="d-flex align-items-center justify-content-center">
				<button style="" type="button" class="btn btn-primary">Xác
					nhận</button>
			</div>
		</form>
	</div>
</body>
</html>