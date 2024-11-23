<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<body>
        <div class="form_login register">
            <h4>Đăng ký</h4>
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
            <form:form method="post" action="register2" modelAttribute="new_user">
                <div class="mb-3">
                    <form:input type="email" class="form-control" path="email"
                                placeholder="Email"/>
                </div>
                <div class="mb-3">
                    <div class="mb-3-password reg">
                        <form:input type="password" class="form-control" path="passwordHashed" placeholder="Mật khẩu"/>
                        <div class="signup_input_show">
                            <i class='bx bx-show-alt'></i>
                        </div>
                        <div class="signup_input_hidden">
                            <i class='bx bx-low-vision'></i>
                        </div>
                    </div>
                </div>
                <div class="mb-3">
                    <div class="mb-3-password re-reg">
                        <input type="password" class="form-control" placeholder="Nhập lại mật khẩu" name="re-password"/>
                        <div class="signup_input_show-re-reg">
                            <i class='bx bx-show-alt'></i>
                        </div>
                        <div class="signup_input_hidden-re-reg">
                            <i class='bx bx-low-vision'></i>
                        </div>
                    </div>
                </div>
                <div class="mb-3">
                    <div class="form-login-btn">
                        <input type="submit" class="btn btn-primary" value="Đăng ký"/>
                    </div>
                    <div class="mb-3 form-check">

                        <div class="signup_policy">
                            <p>Bằng việc đăng ký, bạn đã đồng ý với shop về
                                <a href="">Điều khoản dịch vụ</a> &
                                <a href="">Chính sách bảo mật</a>
                            </p>
                        </div>
                        <div class="signup_not_have_account">
                            <p>Bạn đã có tài khoản. Hãy đăng nhập
                                <a href="/login/">tại đây</a>
                            </p>
                        </div>

                    </div>
                </div>
            </form:form>
        </div>

</body>

</html>
