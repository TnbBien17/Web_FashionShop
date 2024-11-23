<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>
    <div class="form_login fill_tel">
        <form action="/login/fill_email" method="post" class="form_fill_tel_content">
            <div class="form_fill_tel_content_title">
                <h4>Quên mật khẩu</h4>
                <p>Nhập email của bạn để nhận mật khẩu mới</p>
            </div>
            <c:if test="${error != null}">

                <div class="alert alert-danger alert-dismissible" role="alert">

                    <i>${error}</i>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>

            </c:if>
            <div class="form_fill_tel_content_input">
                <input name="email" style="width:100%;" type="email" placeholder="Nhập email">
            </div>
            <div class="form_fill_tel_content_btn">
                <button type="submit" class="btn btn-primary">Tiếp tục</button>
            </div>
            <div class="form_fill_tel_content_back">
                <a href="/login/">Quay lại</a>
            </div>
        </form>
    </div>
</body>