<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="temp" value="0"/>
<body>

<div class="container mb-4">
    <div class="row">
        <div class="col-12">
            <div class="table-responsive">
                <button id="btn_create" class="btn btn-sm btn-primary" onclick="create()">
                    <i class="fas fa-shopping-cart"></i> Thêm giỏ hàng
                </button>
                <table class="table table-striped">
                    <thead>
                    <tr>

                        <th scope="col">Tên giỏ hàng</th>
                        <th scope="col" class="text-center">Số loại sản phẩm</th>
                        <th scope="col" class="text-center">Số lượng sản phẩm</th>
                        <th scope="col">Tổng giá</th>
                        <th scope="col" class="text-center">Chi tiết</th>

                        <th> </th>
                    </tr>
                    </thead>
                    <tbody class="row_cart">
                    <c:forEach var="i_cart" items="${listCartUser}">
                        <c:if test="${i_cart.active == true}">
                            <tr class="rowCart${temp}">
                                <td>
                                    <div class="row_data1${temp}">
                                            ${i_cart.name}
                                    </div>
                                    <form action="/cart/updateCart/${i_cart.id}" method="post"
                                          class="form_update${temp}"
                                          style="display: none; padding: 10px; border: 1px solid #ccc; border-radius: 5px; background-color: #f9f9f9;">
                                        <input type="text" value="${i_cart.name}" name="nameCart"
                                               style="margin-bottom: 10px; padding: 5px; width: calc(100% - 12px); box-sizing: border-box;"/>
                                        <input type="submit" value="Thay đổi" class="btn btn-success"
                                               style="margin-bottom: 10px;">
                                        <div class="update_cancel" style="margin-top: 10px">
                                            <button class="btn btn-sm btn-primary" onclick="cancel${temp}()">
                                                <i class="fas fa-times-circle"></i> Hủy
                                            </button>
                                        </div>
                                    </form>

                                </td>
                                <td class="text-center">${countProductByCartID.get(temp)} </td>
                                <td class="text-center">${totalQuantityByCartID.get(temp)} </td>
                                <td class="price" data-price="${totalPriceByCartID.get(temp)}">${totalPriceByCartID.get(temp)} VNĐ</td>

                            <%--                                <td>${totalPriceByCartID.get(temp)} VNĐ</td>--%>

                                <td class="text-center"><a href="/cart/${i_cart.id}">Xem chi tiết</a></td>
                                <td class="text-right">
                                    <button class="btn btn-sm btn-primary" onclick="update${temp}()"><i
                                            class="fas fa-edit"></i> Sửa
                                    </button>
                                    <a href="/cart/delete_cart/${i_cart.id}" class="btn btn-sm btn-danger"><i
                                            class="fas fa-trash"></i> Xóa</a>
                                    <a class="btn btn-sm btn-primary" href="/order_cart/${i_cart.id}"><i
                                            class="fas fa-credit-card"></i> Thanh toán</a>

                                </td>
                                <script>
                                    function update${temp}(){
                                        var text = document.querySelector(".row_data1${temp}");
                                        var form = document.querySelector(".form_update${temp}");
                                        text.style.display = "none";
                                        form.style.display = "block";
                                    }
                                    function cancel${temp}(){
                                        var text = document.querySelector(".row_data1${temp}");
                                        var form = document.querySelector(".form_update${temp}");
                                        text.style.display = "block";
                                        form.style.display = "none";
                                    }

                                </script>
                                <c:set var="temp" value="${temp+1}"/>
                            </tr>

                        </c:if>
                        <c:if test="${i_cart.active==false}">
                            <c:set var="temp" value="${temp+1}"/>
                        </c:if>
                    </c:forEach>
                    </tbody>

                    <style>
                        .error-message {
                            color: red;
                            font-size: 12px;
                            margin-top: 5px;
                            margin-bottom: 5px;
                            display: none;
                        }
                    </style>

                    <script>
                        function create() {
                            row_cart = document.querySelector(".row_cart");
                            let cartNumber = document.querySelectorAll('.row_cart tr').length + 1;
                            let defaultName = "Giỏ Hàng " + cartNumber;

                            // Tạo hàng mới với input và thông báo lỗi

                            row_cart.innerHTML += '<tr class="rowCart${temp+1}"> <td> <form action="/cart/addCart" method="post" onsubmit="return validateInput(this)"> <input type="text" name="nameNewCart" value="' + defaultName + '"> <span class="error-message">Vui lòng nhập tên</span> <button type="submit" class="btn btn-primary"> <i class="fas fa-plus-circle"></i> Thêm giỏ hàng</button> </form> </td> <td class="text-center"><button class="btn btn-danger" onclick="cancel_add()"><i class="fas fa-times-circle"></i> Hủy</button></td> <td></td> <td></td> <td></td><td></td> </tr>';
                        }

                        function validateInput(form) {
                            let input = form.querySelector('input[name="nameNewCart"]');
                            let errorMessage = form.querySelector('.error-message');

                            if (input.value.trim() === "") {
                                errorMessage.style.display = 'block';  // Hiển thị thông báo lỗi
                                return false;  // Ngăn không cho gửi form
                            }

                            errorMessage.style.display = 'none';  // Ẩn thông báo lỗi nếu có giá trị
                            return true;
                        }

                        function cancel_add() {
                                                    row_cart = document.querySelector(".rowCart${temp+1}");
                                                    row_cart.remove();
                                                }

                    </script>



                </table>
            </div>
        </div>

    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        document.querySelectorAll('.price').forEach(function(element) {
            let price = parseInt(element.getAttribute('data-price'), 10);
            element.textContent = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(price);
        });
    });
</script>


</body>

