<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/common/taglib.jsp"%>
<body>
    <div class="form_login fill_code">
        <form action="/register/verify" method="post" class="form_fill_code_content">
            <div class="form_fill_code_content_title">
                <h4>Xác thực tài khoản</h4>
                <p>Nhập mã xác nhận đã được gửi đến email của bạn</p>
            </div>
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
            <div class="form_fill_code_content_input">
                <input name="authcode" type="text" placeholder="Nhập mã xác nhận">
            </div>
            <div class="form_fill_code_content_btn">
                <button type="submit" class="btn btn-primary">Tiếp tục</button>
            </div>
            <div class="form_fill_code_content_back">
                <a href="/login/fill_email">Quay lại</a>
            </div>
        </form>
    </div>
</body>