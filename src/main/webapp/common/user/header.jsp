<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<meta charset="UTF-8">
<nav class="navbar navbar-expand-md navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="/">
            <img src="<c:url value="/templates/images/logo.jpg"/>"  width="120" alt="logo" class="container_nav_image">
            FASHION SHOP
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-end" id="navbarsExampleDefault">
            <ul class="navbar-nav m-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="/">Home <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/category">Products</a>
                </li>
                <%-- <li class="nav-item">
                    <a class="nav-link" href="/product">Product</a>
                </li> --%>

                <sec:authorize access="hasAnyAuthority('ROLE_ADMIN')" var="isAuthenticated"></sec:authorize>
                <c:if test="${isAuthenticated}">
                    <li class="nav-item">
                        <a class="nav-link" href="/admin">Admin</a>
                    </li>
                </c:if>
            </ul>

            <form class="form-inline my-2 my-lg-0" action="/product/seach" method="post">
                <div class="input-group input-group-sm">
                    <input type="text" class="form-control" name="keyword" placeholder="Search...">
                    <div class="input-group-append">
                        <button type="submit" class="btn btn-secondary btn-number">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                    <div class="container_search" style="display: none;">
                        <ul class="box_search">
                            <c:forEach var="item" items="${sessionScope.listProduct}">
                                <li class="box_search item">
                                    <div class="item_image">
                                        <c:if test="${fn:length(item.images) > 0}">
                                            <img src="<c:url value="/templates/images/${item.getImages()[0].imageLink}"/>" alt="">
                                        </c:if>
                                        <c:if test="${fn:length(item.images) == 0}">
                                            <img src="<c:url value="/templates/images/no-image.png"/>" alt="">
                                        </c:if>
                                    </div>

                                    <div class="item_title">
                                        <a href="/product/${item.id}">${item.name} </a>
                                        <p class="text-left" style="font-size: 15px; font-family: 'Be VietNam pro';">Giá bán: ${item.price}vnđ</p>
                                    </div>
                                </li>
                            </c:forEach>

                        </ul>
                    </div>

                    <script>
                        var text_input=document.querySelector(".form-control");
                        var box_search=document.querySelector(".container_search");
                        text_input.addEventListener("click",function(){
                            if(box_search.style.display =='none'){
                                box_search.style.display='block';
                            }
                            else{
                                box_search.style.display='none'
                            }
                        });

                        var search_input=document.querySelector(".input-group.input-group-sm input")
                        search_input.addEventListener('input', function(e){
                            let txtSearch=e.target.value.trim();
                            // nhận diện tiếng việt có dấu
                            // txtSearch=removeAccents(txtSearch);
                            let list_itemDom=document.querySelectorAll(".box_search.item");
                            list_itemDom.forEach(item=>{
                                if(item.innerText.includes(txtSearch)){
                                    item.classList.remove('hide');

                                }
                                else{
                                    item.classList.add('hide')

                                }
                            })
                        });
                    </script>

                </div>
                <a class="btn btn-success btn-sm ml-3" href="/cart">
                    <i class="fa fa-shopping-cart"></i> Cart
                    <c:if test="${sessionScope.user_id!=null}">
                        <c:if test="${sessionScope.CountCart != null}">
                        <span class="badge badge-light">
                                ${sessionScope.CountCart}
                        </span>
                        </c:if>
                    </c:if>

                </a>
            </form>

            <c:if test="${pageContext.request.userPrincipal != null}">

            <div class="header_action_user">
                <div class="header_action_logo_user">
                    <div class="user_logo">
                        <c:if test="${sessionScope.image_user == null}">
                            <img src="<c:url value="/templates/images/account.png"/>" width="30" alt="logo">
                        </c:if>
                        <c:if test="${sessionScope.image_user != null}">
                            <img src="<c:url value="/templates/images/${sessionScope.image_user}"/>" width="30" alt="logo">
                        </c:if>
                    </div>
                    <div class="profile_user">
                        <div class="profile_user_info">
                            <div class="profile_user_info_col3">
                                <c:if test="${sessionScope.image_user == null}">
                                    <img src="<c:url value="/templates/images/account.png"/>" width="30" alt="logo">
                                </c:if>
                                <c:if test="${sessionScope.image_user != null}">
                                    <img src="<c:url value="/templates/images/${sessionScope.image_user}"/>" width="30" alt="logo">
                                </c:if>
                            </div>
                            <div class="profile_user_info_col6">
                                <span>${sessionScope.FirstName} ${sessionScope.LastName} </span>
                            </div>
                        </div>
                        <div class="profile_user_col">
                            <a href="/profile_user/">Hồ sơ của tui</a>
                        </div>
                        <div class="profile_user_col">
                            <a href="/order_cart/ ">Đơn đặt hàng</a>
                        </div>
                        <div class="profile_user_col">
                            <a href="/checkout">Đăng xuất</a>
                        </div>
                    </div>
                </div>
            </div>
            </c:if>
            <c:if test="${pageContext.request.userPrincipal == null}">
                <div class="header_action_user">
                    <a href="/login/">Đăng nhập</a>
                    <a href="/register/">Đăng ký</a>
                </div>
            </c:if>
        </div>

    </div>
</nav>
<style>
    .text-border {
        text-shadow: 1px 0 #fff, -1px 0 #fff, 0 1px #fff, 0 -1px #fff,
             1px 1px #fff, -1px -1px #fff, 1px -1px #fff, -1px 1px #fff;
    }
</style>
<section class="jumbotron text-center">
    <div class="container">
        <h1 class="jumbotron-heading text-border" style="color: #0b0b0b; font-size: 2.5rem">Fashion SHOP </h1>
        <p class="lead text-muted mb-0 text-border" style="color: #373434!important; font-size: 30px; font-weight: 600; ">
            Đồng hành cùng bạn trải nghiệm với
            hệ thống bán hàng chất lượng
            đến từ các nhãn hiệu trong và ngoài nước</p>
    </div>
</section>

