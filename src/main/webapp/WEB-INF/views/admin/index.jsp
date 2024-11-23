<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang chủ - admin</title>
</head>
<body>
	<div class="container">
		<h2 class="display-6 my-3">Xin chào, Admin</h2>
		<section>
			<div class="title">
				<i class="fa-solid fa-gauge"></i> <span class="text">Tổng
					quan</span>
			</div>
			<div class="boxes">
				<div class="box box1">
					<i class="fa-solid fa-dollar-sign"></i> <span class="text">Doanh
						thu</span>
                    <span class="number">
                        ${revenue}Đ
<%--                        <fmt:formatNumber value="${revenue}" type="currency" currencySymbol="vn₫" groupingUsed="true" />--%>
                    </span>
				</div>

				<div class="box box2">
					<i class="fa-solid fa-receipt"></i> <span class="text">Số đơn hàng</span> 
					<span class="number">${orderCount}</span>
				</div>
				<div class="box box3">
					<i class="fa-solid fa-user"></i> <span class="text">Người
						dùng</span> <span class="number">${userCount}</span>
				</div>
				<div class="box box4">
					<i class="fa-solid fa-star"></i> <span class="text">Lượt
						đánh giá</span> <span class="number">${reviewCount}</span>
				</div>
			</div>
		</section>
		<div class="row">
			<div class="col-5">
				<section>
					<div class="title">
						<i class="fa-regular fa-clock"></i> <span class="text">Đơn hàng gần đây</span>
					</div>
					<div class="table">
						<table class="table-striped table bg-white">
							<thead>
								<tr>
									<th>Mã đơn hàng</th>
									<th>Ngày đặt</th>
									<th>Người nhận</th>
									<th>Địa chỉ</th>
									<th>Trạng thái</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${newOrder}" var="order">
									<tr>
										<td>${order.id}</td>
										<td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
										<td>${order.cart.user.firstName} ${order.cart.user.lastName}</td>
										<td>${order.address}</td>
										<c:if test="${order.paid && order.arriveDate != null}">
											<td><span class="badge text-bg-success">Đã giao</span></td>
										</c:if>
										<c:if test="${order.paid && order.arriveDate == null}">
											<td><span class="badge text-bg-warning">Đã thanh toán</span></td>
										</c:if>
										<c:if test="${!order.paid && order.arriveDate == null}">
											<td><span class="badge text-bg-danger">Đã hủy</span></td>
										</c:if>
									</tr>
								</c:forEach>
							</tbody>
						</table>
				</section>
			</div>
			<div class="col-7">
				<section>
					<div class="title">
						<i class="fa-regular fa-clock"></i> <span class="text">Đánh giá gần đây</span>
					</div>
					<div class="table">
						<table class="table-striped table bg-white">
							<thead>
								<tr>
									<th>Người đánh giá</th>
									<th>Sản phẩm</th>
									<th>Sao</th>
									<th>Đánh giá</th>
									<th>Ngày đánh giá</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${newReview}" var="review">
									<tr>
										<td>${review.user.firstName} ${review.user.lastName}</td>
										<td> <a href="<c:url value="/product/${review.product.id}" />">${review.product.name}</a> </td>
										<td>${review.rating}</td>
										<td>${review.content}</td>
										<td><fmt:formatDate value="${review.createdAt}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
				</section>
		</div>
		
	</div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const revenueElement = document.querySelector('.number');
                let revenue = parseFloat(revenueElement.innerText.replace('₫', '').replace('$', ''));

                if (!isNaN(revenue)) {
                    revenueElement.innerText = revenue.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
                }
            });
        </script>


</body>
</html>
