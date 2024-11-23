<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<body>

<div class="container mb-4">
    <div class="row">
        <div class="col-12">
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th scope="col">Tên giỏ hàng</th>
                        <th scope="col">Trạng thái thanh toán</th>
                        <th scope="col">Chi tiết</th>
                    </tr>
                    </thead>
                    <tbody class="row_cart">
                    <c:forEach items="${carts}" var="item">
                        <tr>
                            <td>${item.name}</td>
                            <td>
                                <c:if test="${item.active == false}">
                                    <p style="color:green">Đã thanh toán</p>
                                </c:if>

                                <c:if test="${item.active == true}">
                                    <p style="color:red">Chưa thanh toán</p>
                                </c:if>
                            </td>
                            <c:if test="${item.active == true}">
                                <td><a href="/order_cart/${item.id}">Thanh toán</a></td>
                            </c:if>
                            <c:if test="${item.active == false}">
                                <td></td>
                            </c:if>
                        </tr>
                    </c:forEach>
                    </tbody>

                </table>
            </div>
        </div>

    </div>
</div>
</body>
</html>
