
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<body>
<div class="container mb-4">
	<div class="row">
		<div class="col-12">
			<div class="table-responsive">
				<table class="table table-striped">
					<thead>
					<tr>
						<th scope="col"></th>
						<th scope="col">Sản phẩm</th>
						<th scope="col" class="text-center">Số lượng</th>
						<th scope="col" class="text-center">Đơn giá</th>
						<th scope="col" class="text-right">Tổng tiền</th>
						<th></th>
					</tr>
					</thead>
					<tbody>
					<c:if test="${listCartProduct == null}">
						<tr>
							<td colspan="6">Không có sản phẩm nào trong giỏ hàng</td>
						</tr>
					</c:if>
					<c:if test="${listCartProduct != null}">
						<c:forEach var="i" items="${listCartProduct}">
							<tr>
								<td>
									<c:if test="${i.product.images.size() > 0}">
										<img style="width:50px; height:50px" class="card-img-top" src="<c:url value="/templates/images/${i.product.images[0].imageLink}"/>" alt="Card image cap">
									</c:if>
									<c:if test="${i.product.images.size() == 0}">
										<img style="width:50px; height:50px" class="card-img-top" src="<c:url value="/templates/images/no-image.png"/>" alt="Card image cap">
									</c:if>
								</td>
								<td>${i.product.name}</td>
								<td><input class="form-control" type="text" value="${i.quantity}" disabled/></td>
								<td class="text-center">
									<c:if test="${i.product.discountPercent == 0}">
										<p class="price" data-price="${i.product.price}">${i.product.price} VNĐ</p>
									</c:if>
									<c:if test="${i.product.discountPercent != 0}">
												<span class="price" style="text-decoration: line-through" data-price="${i.product.price}">
													${i.product.price} VNĐ
												</span>
										<p></p>
										<span class="price_discounted" data-price="${i.product.price - i.product.discountPercent * i.product.price}">
            										<fmt:formatNumber value="${i.product.price - i.product.discountPercent * i.product.price}" maxFractionDigits="0"/> VNĐ
												</span>
									</c:if>
								</td>
								<td class="text-right" data-price="${i.totalPrice}">${i.totalPrice} VNĐ</td>
								<td class="text-right">
									<form:form method="post" action="/cart/delete_cartProduct/${i.id}">
										<input type="submit" class="btn btn-sm btn-danger" value="Xóa">
									</form:form>
								</td>
							</tr>
						</c:forEach>
					</c:if>

					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td>Sub-Total</td>
						<td class="text-right" data-price="${totalPrice}">
							<c:if test="${totalPrice == null}">
								0 VNĐ
							</c:if>
							<c:if test="${totalPrice != null}">
								${totalPrice} VNĐ
							</c:if>
						</td>
					</tr>

					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td><strong>Total</strong></td>
						<td class="text-right" data-price="${totalPrice}"><strong>${totalPrice} VNĐ</strong></td>
					</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="col mb-2">
			<div class="row">
				<div class="col-sm-12  col-md-6">
					<a href="/category/" class="btn btn-block btn-light">Continue Shopping</a>
				</div>
				<div class="col-sm-12 col-md-6 text-right">
					<form action="/order_cart/${sessionScope.cart_id}" method="get">
						<button class="btn btn-lg btn-block btn-success text-uppercase">
							Thanh toán
						</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	// Format prices to VNĐ format using JavaScript
	document.addEventListener("DOMContentLoaded", function () {
		const formatCurrency = (value) => {
			return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND', minimumFractionDigits: 0 })
					.format(value)
					.replace('₫', '') + ' VNĐ'; // Remove ₫ symbol and add VNĐ

		};

		// Format all elements with the `data-price` attribute
		document.querySelectorAll("[data-price]").forEach((element) => {
			const priceValue = parseFloat(element.getAttribute("data-price"));
			if (!isNaN(priceValue)) {
				element.innerText = formatCurrency(priceValue);
			}
		});
	});
</script>
</body>
