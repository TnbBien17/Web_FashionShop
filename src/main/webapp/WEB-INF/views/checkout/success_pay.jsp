
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>Payment Success</title>
    <style>
        .custom-alert {
            position: relative;
            padding-left: 45px;
        }

        .custom-alert .icon {
            position: absolute;
            top: 10px;
            left: 10px;
            font-size: 24px;
        }
    </style>
</head>
<body>

<div class="container mb-4">
    <div class="row">
        <div class="col-12">
            <div class="alert alert-success custom-alert" role="alert">
                <i class="fas fa-check-circle icon"></i>
                <h4 class="alert-heading">Thanh toán đơn hàng thành công!</h4>
                <p>Fashion Shop trang web online uy tín, chất lượng và đa dạng mang đến cho khách hàng những sản phẩm chính hãng với giá cả hợp lý và dịch vụ giao hàng nhanh chóng.</p>
                <hr>
                <a class="mb-0" href="/category">Trở lại</a>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
