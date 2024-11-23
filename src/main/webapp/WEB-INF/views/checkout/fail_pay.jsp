<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>Payment Failed</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"> <!-- Font Awesome -->
    <style>
        .failed-icon {
            font-size: 50px;
            color: red;
            vertical-align: middle;
            margin-right: 10px;
        }
        .message-container {
            margin-top: 50px;
        }
    </style>
</head>
<body>
<div class="container message-container">
    <div class="row">
        <div class="col-12">
            <div class="alert alert-danger" role="alert">
                <h4 class="alert-heading"><i class="failed-icon fas fa-times-circle"></i> Thanh toán đơn hàng thất bại!</h4>
                <p>Fashion Shop trang web online uy tín, chất lượng và đa dạng mang đến cho khách hàng những sản phẩm
                    chính hãng với giá cả hợp lý và dịch vụ giao hàng nhanh chóng.</p>
                <hr>
                <a class="mb-0" href="/category">Trở lại</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>