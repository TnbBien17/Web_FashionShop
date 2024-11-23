<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <style>
        /* Style for error messages */
        .error-message {
            color: red;
            font-size: 0.9em;
            margin-top: 5px;
        }
        .error-input {
            border-color: red;
        }
    </style>
</head>
<body>
<div class="container mb-4">
    <form:form action="/order_cart/add_orderCart/${order.cart.id}" class="order_form" modelAttribute="order" method="post" id="orderForm">
        <div id="allError" class="error-message" style="text-align: center"></div>
        <div class="mb-3">
            <label class="form-label">Họ và tên</label>
            <input type="text" class="form-control" name="name" id="name" value="${order.cart.user.firstName} ${order.cart.user.lastName}" placeholder="Nhập họ và tên">
            <div id="nameError" class="error-message"></div>
        </div>

        <div class="mb-3">
            <label class="form-label">Địa chỉ</label>
            <form:input path="address" type="text" class="form-control" name="address" id="address" placeholder="Nhập địa chỉ"/>
            <div id="addressError" class="error-message"></div>
        </div>

        <div class="mb-3">
            <label class="form-label">Số điện thoại</label>
            <input type="text" class="form-control" name="phone" id="phone" value="${order.cart.user.phone}" placeholder="Nhập số điện thoại">
            <div id="phoneError" class="error-message"></div>
        </div>

        <h3>Sản phẩm đã đặt</h3>
        <table class="table table-striped">
            <thead>
            <tr>
                <th scope="col"></th>
                <th scope="col">Sản phẩm</th>
                <th scope="col" class="text-center">Số lượng</th>
                <th scope="col" class="text-right">Giá</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="i_product" items="${order.cart.cart_products}">
                <tr>
                    <td>
                        <c:if test="${i_product.product.images.size() > 0}">
                            <img style="width:50px; height:50px" class="card-img-top" src="<c:url value="/templates/images/${i_product.product.images[0].imageLink}"/>" alt="Product Image">
                        </c:if>
                        <c:if test="${i_product.product.images.size() == 0}">
                            <img style="width:50px; height:50px" class="card-img-top" src="<c:url value="/templates/images/no-image.png"/>" alt="No Image">
                        </c:if>
                    </td>
                    <td>${i_product.product.name}</td>
                    <td class="text-center">${i_product.quantity}</td>
                    <td class="text-right price" data-price="${i_product.totalPrice}">${i_product.totalPrice} VNĐ</td>
                </tr>
            </c:forEach>
            </tbody>
            <tr>
                <td></td>
                <td></td>
                <td>Sub-Total</td>
                <td class="text-right price" data-price="${total}">${total} VND</td>
            </tr>
            <tr>
                <td></td>
                <td></td>
                <td><strong>Total</strong></td>
                <td class="text-right price" data-price="${totalPrice}"><strong>${totalPrice} VND</strong></td>
            </tr>
        </table>

        <div class="col mb-2">
            <div class="row">
                <div class="col-sm-12 col-md-6">
                    <a href="/category/" class="btn btn-block btn-light">Tiếp tục mua sắm</a>
                </div>
                <div class="col-sm-12 col-md-6 text-right">
                    <button class="btn btn-lg btn-block btn-success text-uppercase" type="submit">Xác nhận</button>
                </div>
            </div>
        </div>
    </form:form>
</div>

<script>
    // JavaScript to format prices to VNĐ format and validate the form
    document.addEventListener("DOMContentLoaded", function () {
        const formatCurrency = (value) => {
            return new Intl.NumberFormat("vi-VN", {
                style: "currency",
                currency: "VND",
                minimumFractionDigits: 0
            }).format(value).replace('₫', '').trim() + ' VNĐ';
        };

        // Format prices in VNĐ on page load
        document.querySelectorAll(".price, #subTotal, #totalPrice").forEach(element => {
            const priceValue = parseFloat(element.getAttribute("data-price"));
            if (!isNaN(priceValue)) {
                element.innerText = formatCurrency(priceValue);
            }
        });

        // Form validation
        const form = document.getElementById("orderForm");
        form.addEventListener("submit", function (event) {
            let isValid = true;

            // Name validation (>3 characters)
            const nameInput = document.getElementById("name");
            const nameError = document.getElementById("nameError");
            if (nameInput.value.length <= 3) {
                nameError.style.color = "red";
                nameError.textContent = "Tên phải dài hơn 3 ký tự.";
                nameInput.classList.add("error-input");
                isValid = false;
            } else {
                nameError.textContent = "";
                nameInput.classList.remove("error-input");
            }

            // Address validation (>3 characters)
            const addressInput = document.getElementById("address");
            const addressError = document.getElementById("addressError");
            if (addressInput.value.length <= 3) {
                addressError.style.color = "red";
                addressError.textContent = "Địa chỉ phải dài hơn 3 ký tự.";
                addressInput.classList.add("error-input");
                isValid = false;
            } else {
                addressError.textContent = "";
                addressInput.classList.remove("error-input");
            }

            // Phone number validation (10 digits)
            const phoneInput = document.getElementById("phone");
            const phoneError = document.getElementById("phoneError");
            const phoneRegex = /^\d{10}$/;
            if (!phoneRegex.test(phoneInput.value)) {
                phoneError.style.color = "red";
                phoneError.textContent = "Số điện thoại phải đúng 10 chữ số.";
                phoneInput.classList.add("error-input");
                isValid = false;
            } else {
                phoneError.textContent = "";
                phoneInput.classList.remove("error-input");
            }

            // Check if any field is invalid and show general error message
            const allError = document.getElementById("allError");
            if (!isValid) {
                allError.style.color = "red";
                allError.textContent = "Vui lòng nhập đầy đủ và đúng định dạng các thông tin cần thiết.";
                event.preventDefault(); // Prevent form submission if validation fails
            } else {
                allError.textContent = ""; // Clear the general error message if valid
            }
        });
    });
</script>
</body>
</html>
