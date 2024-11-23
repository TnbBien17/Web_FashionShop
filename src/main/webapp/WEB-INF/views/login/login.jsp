<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/common/taglib.jsp"%>

<body>

<div class="form_login signin">
    <h4>Đăng nhập</h4>
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
    <form method="post" action="/login/checklogin">
        <div class="mb-3">
            <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp"
                   placeholder="Email" name="Email">
        </div>
        <div class="mb-3">
            <div class="mb-3-password">
                <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Mật khẩu" name="password">
                <div class="login_input_show">
                    <i class='bx bx-show-alt'></i>
                </div>
                <div class="login_input_hidden">
                    <i class='bx bx-low-vision'></i>
                </div>
            </div>
        </div>


        <div class="form-login-btn">
            <button type="submit" class="btn btn-primary">Đăng nhập</button>
        </div>
        <div class="form-login-forgot-password">
            <a href="/login/fill_email">Quên mật khẩu</a>
        </div>
        <div class="mb-3 form-check">
            <p></p>
            <div class="signin_not_have_account">
                <p>Bạn chưa có tài khoản. Hãy đăng ký
                    <a href="/register/">tại đây</a>
                </p>
            </div>

        </div>
    </form>
</div>
</body>
