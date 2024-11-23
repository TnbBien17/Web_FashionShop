<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,300,600" rel="stylesheet" type="text/css">
    <link rel='stylesheet' href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'>
    <link rel="stylesheet" href="<c:url value="/templates/login/css/login.css"/>" >
    <link rel="stylesheet" href="<c:url value="/templates/login/css/header.css"/>" >
    <link rel="stylesheet" href="<c:url value="/templates/user/css/style.css"/>" >
</head>

<body>
<nav class="navbar navbar-expand-md navbar-dark bg-dark">
    <div class="container">
        <div class="container image">
            <a class="navbar-brand" href="/">
                <img src="<c:url value="/templates/images/logo.jpg" />" width="120" alt="logo">
            </a>
        </div>

        <div class="container_nav_help">
            <a href="#">Bạn cần trợ giúp? </a>
        </div>


    </div>
</nav>

<div style="display: flex; flex-direction: row; height:660px;">
    <div class="block_info_image">
        <div class="block_image">
            <div class="block_image_container">
                <div class="block_logo_image">
                    <img src="/templates/images/logo.jpg" alt="">
                </div>
                <div class="block_logo_slogan">
                    <p style="font-size: 20px; text-align: center; font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">Trang online bán hàng chất lượng cao, uy tín và giá cả hợp lý cung cấp các sản phẩm từ các thương hiệu nổi tiếng trong và ngoài nước</p>
                </div>
            </div>

        </div>
    </div>

    <div class="container_body">
        <sitemesh:write property='body' />
    </div>
</div>


<script src="<c:url value="/templates/login/js/login.js"/>" ></script>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
        type="text/javascript"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" type="text/javascript"></script>
</body>

<footer class="text-light">
    <div class="container">
        <div class="row">
            <div class="col-md-3 col-lg-4 col-xl-3">
                <h5>About</h5>
                <hr class="bg-white mb-2 mt-0 d-inline-block mx-auto w-25">
                <p class="mb-0">
                    Welcome to FashionShop nơi cung
                    cấp sản phẩm thời trang
                </p>
            </div>

            <div class="col-md-2 col-lg-2 col-xl-2 mx-auto">
                <h5>Informations</h5>
                <hr class="bg-white mb-2 mt-0 d-inline-block mx-auto w-25">
                <ul class="list-unstyled">
                    <li><a href="">Liên hệ: admin</a></li>
                    <li><a href="">Liên hệ: SM</a></li>
                    <li><a href="">Liên hệ: staff</a></li>
                </ul>
            </div>

            <div class="col-md-4 col-lg-3 col-xl-3">
                <h5>Contact</h5>
                <hr class="bg-white mb-2 mt-0 d-inline-block mx-auto w-25">
                <ul class="list-unstyled">
                    <li><i class="fa fa-home mr-2"></i> Số 1 Võ văn Ngân</li>
                    <li><i class="fa fa-envelope mr-2"></i> shopvnn@gmail.com</li>
                    <li><i class="fa fa-phone mr-2"></i> + 33 12 14 15 16</li>
                    <li><i class="fa fa-print mr-2"></i> + 33 12 14 15 16</li>
                </ul>
            </div>

            <div class="column subscribe">
                <h3>Newsletter</h3>
                <div>
                    <input type="email" placeholder="Your email id here" />
                    <button>Subscribe</button>
                </div>
            </div>

        </div>

    </div>
</footer>


</html>
