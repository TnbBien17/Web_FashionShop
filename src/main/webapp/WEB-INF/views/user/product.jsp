<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/common/taglib.jsp" %>
<html>
<body>
<div class="container">
    <div class="row">
        <div class="col">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="/category">Loại sản phẩm</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Sản phẩm</li>
                </ol>
            </nav>
        </div>
    </div>
</div>
<div class="container">
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
        <!-- Image -->
        <div class="col-12 col-lg-6">
            <div class="card bg-light mb-3">
                <div class="card-body">
                    <div style="width: 100%; height: 500px;" id="carouselExample" class="carousel carousel-dark slide">
                        <div class="carousel-inner">
                            <c:forEach items="${product.images}" var="image" varStatus="status">
                                <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                        <%-- <div class="col-md-3"> --%>
                                    <img src="<c:url value="/templates/images/${image.imageLink}"/>"
                                         style="max-width: 100%; max-height:100%; object-fit: contain;" alt="...">

                                </div>
                            </c:forEach>


                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample"
                                data-bs-slide="prev" style="background-color: rgba(255,255,255,0.2); border:1px solid rgba(255,255,255,0.2);
                                 color:black; cursor:pointer">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden" style="font-size: 40px;"></span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselExample"
                                data-bs-slide="next" style="background-color: rgba(255,255,255,0.2); border:1px solid rgba(255,255,255,0.2);
                                 color:black; cursor:pointer">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden" style="font-size: 40px;"></span>
                        </button>
                    </div>
                    <%--                    <a href="" data-toggle="modal" data-target="#productModal">--%>
                    <%--                        <img src="<c:url value="/templates/images/${product.images}"/>"  width="120" alt="logo" class="container_nav_image">--%>
                    <%--                        --%>
                    <%--                        <p class="text-center">Zoom</p>--%>
                    <%--                    </a>--%>
                </div>
            </div>
        </div>

        <!-- Add to cart -->
        <div class="col-12 col-lg-6 add_to_cart_block">
            <div class="card bg-light mb-3">
                <p class="text-name-product">${product.name}</p>
                <c:if test="${product.available==false or product.stock==0}">
                    <p style="color: red; font-size: 25px; font-family: 'Be VietNam Pro', 'sans-serif'">Sản phẩm đã hết hàng</p>
                </c:if>
                <div class="card-body">
                    <c:if test="${product.discountPercent == 0}">
                        <p class="price price" data-price="${product.price}">${product.price} VNĐ</p>

                    </c:if>
                    <c:if test="${product.discountPercent != 0}">
                        <p class="price price" data-price="${product_discounted}">${product_discounted} VNĐ</p>
                        <p class="price_discounted price" data-price="${product.price}">${product.price} VNĐ</p>
                        <label>Chương trình áp dụng giảm giá với sản phẩm này từ :
                        <p> </p> Ngày
                        <fmt:formatDate value="${product.discountStart}" pattern="dd-MM-yyyy" /> đến
                        ngày <fmt:formatDate value="${product.discountEnd}" pattern="dd-MM-yyyy" />
                        </label>
                        <p></p>
                    </c:if>

                    <sec:authorize access="hasAnyAuthority('ROLE_ADMIN', 'ROLE_USER')" var="isAuthenticated">

                    </sec:authorize>
                    <c:if test="${isAuthenticated}">


                    <form:form method="post" action="/product/${product.id}/product_to_cart"
                               modelAttribute="cart_product">

                    <div class="form-group">
                        <div class="form-group">
<%--Thong bao loi--%>

<c:set var="activeCount" value="0" />

<c:forEach var="i_cart" items="${listCart}">
    <c:if test="${i_cart.active == true}">
        <c:set var="activeCount" value="${activeCount + 1}" />
    </c:if>
</c:forEach>

<%-- Thong bao loi--%>
                            <c:forEach var="item" items="${listCart}">
                                <c:forEach var="j" items="${item.cart_products}">
                                    <c:if test="${product.id == j.product.id and j.cart.active == true}">
                                        <label style="color:red">Sản phẩm này đã có trong giỏ hàng: "${item.name}"</label>
                                    </c:if>
                                </c:forEach>
                            </c:forEach>


                            <div class="form-group">
                                <label for="colors">Chọn giỏ hàng</label>
                                <form:select class="custom-select" id="colors" path="cart" >
                                    <c:forEach var="i_cart" items="${listCart}">
                                        <c:if test="${i_cart.active == true}">
                                            <option value="${i_cart.id}">${i_cart.name}</option>
                                        </c:if>
                                    </c:forEach>
                                </form:select>
                            </div>

                            <c:if test="${activeCount == 0}">
                                <!-- Thông báo khi không có sản phẩm nào active -->
                                <p style="color: red;">Vui lòng tạo giỏ hàng trước khi thêm sản phẩm.</p>
                            </c:if>

                            <a href="/cart">Thêm giỏ hàng</a></br>
                            <label>Quantity :</label>
                            <div class="input-group mb-3" style="width: 150px;">
                                <div class="input-group-prepend">
                                    <form:button type="button"
                                                 class="quantity-left-minus btn btn-danger btn-number"
                                                 data-type="minus" data-field="">
                                        <i class="fa fa-minus"></i>
                                    </form:button>
                                </div>
                                <form:input type="number" class="form-control" id="quantity" name="quantity"
                                            path="quantity" min="1" max="${product.stock}" value="${sessionScope.quantity}"/>
                                <div class="input-group-append">
                                    <form:button type="button"
                                                 class="quantity-right-plus btn btn-success btn-number"
                                                 data-type="plus" data-field="" onclick="limitQuantity()" value="1" >
                                        <i class="fa fa-plus"></i>
                                    </form:button>
                                </div>
                            </div>
                            <script>
                                function limitQuantity() {
                                    var quantity = document.getElementById("quantity").value;
                                    if (quantity >= ${product.stock}) {
                                        document.getElementById("quantity").value = ${product.stock}-1;
                                        alert("Số lượng sản phẩm trong kho không đủ")
                                    }
                                    if (quantity === 0 ) {
                                        document.getElementById("quantity").value = 1;
                                    }
                                }

                            </script>
                        </div>


                        <input type="submit" value="Thêm vào giỏ hàng"
                                   class="btn btn-success btn-lg btn-block text-uppercase"
                                   <c:if test="${activeCount == 0}">disabled</c:if>>


<%--                        <input type="submit" value="Thêm vào giỏ hàng"--%>
<%--                               class="btn btn-success btn-lg btn-block text-uppercase">--%>
                        </form:form>

                        </c:if>

                        <c:if test="${!isAuthenticated}">
                            <p class="text-center">Vui lòng đăng nhập để thêm vào giỏ hàng</p>
                        </c:if>

                        <script>
                            //nếu sản phẩm hết hàng hoặc không có sẵn thì không cho thêm vào giỏ hàng
                            if((${product.available})===false){
                                document.getElementById("quantity").disabled =true;
                                document.querySelector(".quantity-left-minus.btn.btn-danger.btn-number").disabled =true;
                                document.querySelector(".quantity-right-plus.btn.btn-success.btn-number").disabled =true;
                                document.getElementById("quantity").value = 0;
                                document.querySelector(".btn.btn-success.btn-lg.btn-block.text-uppercase").disabled =true;
                            }


                        </script>


                        <div class="product_rassurance">
                            <ul class="list-inline">
                                <li class="list-inline-item"><i class="fa fa-truck fa-2x"></i><br/>Fast
                                    delivery
                                </li>
                                <li class="list-inline-item"><i
                                        class="fa fa-credit-card fa-2x"></i><br/>Secure payment
                                </li>
                                <li class="list-inline-item"><i class="fa fa-phone fa-2x"></i><br/>+33
                                    1 22 54 65 60
                                </li>
                            </ul>
                        </div>
                        <div class="reviews_product p-3 mb-2 ">
                            <c:if test="${count_review==0}">
                                0 reviews
                            </c:if>
                            <c:if test="${count_review!=0}">
                                ${count_review} reviews
                            </c:if>

                            <c:set var="cnt_star" value="1"/>
                            <c:set var="temp" value="${avg_rating-1}"/>
                            <c:forEach var="i" begin="1" end="${avg_rating}">
                                <c:if test="${temp >=0}">
                                    <%-- <i class="fa fa-star"></i> --%>
                                    <i style="color: #ffd103;" class="fa-solid fa-star"></i>
                                    <c:set var="cnt_star" value="${cnt_star + 1}"/>
                                    <c:set var="temp" value="${temp - 1}"/>
                                </c:if>
                            </c:forEach>

                            <c:set var="temp" value="${temp+1}"/>
                            <c:if test="${temp==0.5}">
                                <%-- <i class="fa fa-star fa-star-half-o "></i> --%>
                                <i style="color: #ffd103;" class="fa-solid fa-star-half-stroke"></i>
                                <c:set var="cnt_star" value="${cnt_star + 1}"/>
                            </c:if>

                            <c:forEach var="i" begin="${cnt_star}" end="5">
                                <%-- <i class="fa fa-star fa-star-o"></i> --%>
                                <i style="color: #ffd103;" class="fa-regular fa-star"></i>
                                <c:set var="cnt_star" value="${cnt_star + 1}"/>
                            </c:forEach>

                            (<c:if test="${avg_rating==0}">
                                0/5
                            </c:if>
                            <c:if test="${avg_rating!=0}">
                                ${avg_rating}/5
                            </c:if> )

                            <a class="pull-right" href="#reviews">View all reviews</a>
                        </div>

                    </div>


                </div>
            </div>
        </div>

        <div class="row">
            <!-- Description -->
            <div class="col-12">
                <div class="card border-light mb-3">
                    <div class="card-header bg-primary text-white text-uppercase">
                        <i class="fa fa-align-justify"></i> Mô tả sản phẩm
                    </div>
                    <div class="card-body">
                        <pre style="font-family: 'Be VietNam Pro', 'sans-serif'; font-size: 20px; font-weight: 500;text-wrap:wrap;">${product.description}</pre>

                    </div>
                </div>
            </div>

            <div class="container mt-3">
                <div class="row">
                    <div class="col-sm">
                        <div class="card">
                            <div class="card-header bg-primary text-white text-uppercase">
                                <i class="fa fa-star"></i> Sản phẩm cùng hãng
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <c:forEach var="i" items="${listProductBrand}" varStatus="status">
                                        <c:if test="${status.index <4}">
                                            <c:if test="${i.id != product.id}">
                                                <div class="col-sm-3">
                                                    <div class="card">
                                                        <div >
                                                        <c:if test="${i.images.size() > 0}">
                                                            <img class="card-img-top" src="<c:url value="/templates/images/${i.images[0].imageLink}"/>" alt="Card image cap">
                                                        </c:if>
                                                        <c:if test="${i.images.size() == 0}">
                                                            <img  class="card-img-top" src="<c:url value="/templates/images/no-image.png"/>" alt="Card image cap">
                                                        </c:if>
                                                        </div>
                                                        <div class="card-body">
                                                            <h4 class="card-title"><a href="/product/${i.id}"
                                                                                      title="View Product">${i.name}</a>
                                                            </h4>
                                                            <p class="card-text">${i.description}</p>
                                                            <div class="row">
                                                                <div class="col">
<%--                                                                    <p class="btn btn-danger btn-block">${i.price}VNĐ</p>--%>
                                                                    <p class="btn btn-danger btn-block price" data-price="${i.price}">${i.price}VNĐ</p>
                                                                </div>
                                                                <div class="col">
                                                                    <a href="/product/${i.id}"
                                                                       class="btn btn-success btn-block">Add to cart</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%-- Same category --%>
            <div class="container mt-3">
                <div class="row">
                    <div class="col-sm">
                        <div class="card">
                            <div class="card-header bg-primary text-white text-uppercase">
                                <i class="fa fa-star"></i> Sản phẩm cùng loại
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <c:forEach var="i" items="${sameCategory}" varStatus="status">
                                        <c:if test="${status.index <4}">
                                            <c:if test="${i.id != product.id}">
                                                <div class="col-sm-3">
                                                    <div class="card">
                                                        <div >
                                                        <c:if test="${i.images.size() > 0}">
                                                            <img  class="card-img-top" src="<c:url value="/templates/images/${i.images[0].imageLink}"/>" alt="Card image cap">
                                                        </c:if>
                                                        <c:if test="${i.images.size() == 0}">
                                                            <img  class="card-img-top" src="<c:url value="/templates/images/no-image.png"/>" alt="Card image cap">
                                                        </c:if>
                                                        </div>
                                                        <div class="card-body">
                                                            <h4 class="card-title"><a href="/product/${i.id}"
                                                                                      title="View Product">${i.name}</a>
                                                            </h4>
                                                            <p class="card-text">${i.description}</p>
                                                            <div class="row">
                                                                <div class="col">
<%--                                                                    <p class="btn btn-danger btn-block">${i.price}VNĐ</p>--%>
<p class="btn btn-danger btn-block price" data-price="${i.price}">${i.price}VNĐ</p>
                                                                </div>
                                                                <div class="col">
                                                                    <a href="/product/${i.id}"
                                                                       class="btn btn-success btn-block">Add to cart</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- View History --%>
             <div class="container mt-3">
                <div class="row">
                    <div class="col-sm">
                        <div class="card">
                            <div class="card-header bg-primary text-white text-uppercase">
                                <i class="fa fa-star"></i> Sản phẩm đã xem
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <c:forEach var="i" items="${viewHistory}" varStatus="status">
                                        <c:if test="${status.index < 5}">
                                            <c:if test="${i.id != product.id}">
                                                <div class="col-sm-3">
                                                    <div class="card">
                                                        <div >
                                                        <c:if test="${i.images.size() > 0}">
                                                            <img  class="card-img-top" src="<c:url value="/templates/images/${i.images[0].imageLink}"/>" alt="Card image cap">
                                                        </c:if>
                                                        <c:if test="${i.images.size() == 0}">
                                                            <img  class="card-img-top" src="<c:url value="/templates/images/no-image.png"/>" alt="Card image cap">
                                                        </c:if>
                                                        </div>
                                                        <div class="card-body">
                                                            <h4 class="card-title"><a href="/product/${i.id}"
                                                                                      title="View Product">${i.name}</a>
                                                            </h4>
                                                            <p class="card-text">${i.description}</p>
                                                            <div class="row">
                                                                <div class="col">
                                                                    <p class="btn btn-danger btn-block price" data-price="${i.price}">${i.price}VNĐ</p>
                                                                </div>
                                                                <div class="col">
                                                                    <a href="/product/${i.id}"
                                                                       class="btn btn-success btn-block">Add to cart</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


<!-- Reviews -->
<div class="col-12" id="reviews">
    <div class="card border-light mb-3">
        <div class="card-header bg-primary text-white text-uppercase">
            <i class="fa fa-comment"></i> Reviews
        </div>
        <div class="review">
            <c:if test="${isAuthenticated}">
                <!-- Form for authenticated users to add a review -->
                <form:form class="post-review" method="post" action="/review/add/${product.id}"
                           modelAttribute="post_review" onsubmit="return validateReviewForm()">
                    <div class="post-review-user">
                        <c:if test="${sessionScope.image_user == null}">
                            <img class="rounded-circle" src="<c:url value="/templates/images/account.png"/>"
                                 width="80px" alt="logo">
                        </c:if>
                        <c:if test="${sessionScope.image_user != null}">
                            <img class="rounded-circle"
                                 src="<c:url value="/templates/images/${sessionScope.image_user}"/>"
                                 width="80px" alt="logo">
                        </c:if>
                        <span class="ml-2">POSTER_NAME</span>
                    </div>
                    <h4 class="text-uppercase">Give your review:</h4>

                    <!-- Rating Section with id -->
                    <div id="rating">
                        <input type="radio" id="star5" name="rating" value="5"/>
                        <label class="full" for="star5" title="Awesome - 5 stars"></label>

                        <input type="radio" id="star4" name="rating" value="4"/>
                        <label class="full" for="star4" title="Pretty good - 4 stars"></label>

                        <input type="radio" id="star3" name="rating" value="3"/>
                        <label class="full" for="star3" title="Meh - 3 stars"></label>

                        <input type="radio" id="star2" name="rating" value="2"/>
                        <label class="full" for="star2" title="Kinda bad - 2 stars"></label>

                        <input type="radio" id="star1" name="rating" value="1"/>
                        <label class="full" for="star1" title="Sucks big time - 1 star"></label>
                    </div>

                    <!-- Error message container for rating -->
                    <div id="rating-error" style="color: red; display: none;">
                        Vui lòng chọn số điểm đánh giá.
                    </div>

                    <form:textarea path="content" class="form-control animated" cols="5" id="new-review"
                                   name="new-review" placeholder="Enter your review here..." rows="5"/>
                    <input type="submit" value="Đăng bình luận" class="btn-post-review">
                </form:form>
            </c:if>
            <c:if test="${!isAuthenticated}">
                <p>Vui lòng đăng nhập để đánh giá sản phẩm</p>
            </c:if>
        </div>

        <h3>Tất cả các bình luận</h3>

        <div class="card-body">
            <c:forEach var="i" items="${product.reviews}">
                <div class="review">
                    <span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
                    <meta itemprop="datePublished" content="01-01-2016">
                    <td><fmt:formatDate value="${i.createdAt}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
                    <c:set var="cnt" value="1"/>
                    <c:forEach var="j" begin="1" end="${i.rating}">
                        <i style="color: #e8e80c;" class="fa-solid fa-star"></i>
                        <c:set var="cnt" value="${cnt + 1}"/>
                    </c:forEach>
                    <c:forEach var="j" begin="${cnt}" end="5">
                        <i style="color: #e8e80c;" class="fa-regular fa-star"></i>
                        <c:set var="cnt" value="${cnt + 1}"/>
                    </c:forEach>
                    ${i.user.firstName} ${i.user.lastName}
                    <p class="blockquote">
                    <pre class="mb-0" style="font-family: 'Be VietNam Pro', 'sans-serif';font-size: 20px">${i.content}</pre>
                    <hr>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<!-- JavaScript for client-side validation -->
<script>
    function validateReviewForm() {
        const ratingSelected = document.querySelector('input[name="rating"]:checked');
        const ratingError = document.getElementById('rating-error');

        // Show error if no rating is selected
        if (!ratingSelected) {
            ratingError.style.display = 'block';
            return false;
        }

        ratingError.style.display = 'none';
        return true;
    }
</script>

        </div>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
    //Plus & Minus for Quantity product
    $(document).ready(function () {
        var quantity = 1;

        $('.quantity-right-plus').click(function (e) {
            e.preventDefault();
            var quantity = parseInt($('#quantity').val());
            $('#quantity').val(quantity + 1);
        });

        $('.quantity-left-minus').click(function (e) {
            e.preventDefault();
            var quantity = parseInt($('#quantity').val());
            if (quantity > 1) {
                $('#quantity').val(quantity - 1);
            }
        });

    });
</script>

<script>
document.addEventListener('DOMContentLoaded', function () {
// Chọn tất cả các phần tử có class 'price'
const priceElements = document.querySelectorAll('.price');

priceElements.forEach(priceElement => {
// Lấy giá trị gốc từ thuộc tính data-price
const originalPrice = parseFloat(priceElement.getAttribute('data-price'));

if (!isNaN(originalPrice)) {
// Định dạng giá trị thành dạng tiền tệ VNĐ
priceElement.innerText = originalPrice.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
}
});
});
</script>
</body>
</html>
