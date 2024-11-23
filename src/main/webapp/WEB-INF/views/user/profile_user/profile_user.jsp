<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
</head>
<body>
<div class="form_login profile_user_container">
    <h3>Hồ sơ của tôi</h3>
    <form method="post" action="update_user" enctype="multipart/form-data" id="profileForm">
        <div class="detail_form_info">
            <div class="detail_info">
                <div class="detail_author">
                    <label>Họ:</label>
                    <input type="text" value="${user.firstName}" name="firstName" id="firstName">
                </div>
                <div id="firstNameError" class="error-message"></div>

                <div class="detail_author">
                    <label>Tên:</label>
                    <input type="text" value="${user.lastName}" path="lastName" name="lastName" id="lastName">
                </div>
                <div id="lastNameError" class="error-message"></div>

                <div class="detail_author">
                    <label>Email</label>
                    <input type="email" value="${user.email}" name="email" id="email" disabled>
                </div>

                <div class="detail_author">
                    <label>Số điện thoại</label>
                    <input type="text" value="${user.phone}" name="phoneNumber" id="phoneNumber">
                </div>
                <div id="phoneError" class="error-message"></div>

                <div class="detail_author">
                    <label>Mật khẩu</label>
                    <input type="password" value="${user.passwordHashed}" disabled>
                </div>

                <a class="btn-profile-change-password" href="/profile_user/change_password" style="border:1px solid white">Thay đổi mật khẩu</a>

                <div class="detail_author">
                    <label>Giới tính</label>
                    <div class="checkoption">
                        <input type="radio" id="male" name="option_gender" value="male">
                        <label>Nam</label>
                        <input type="radio" id="female" name="option_gender" value="female">
                        <label>Nữ</label>
                    </div>
                </div>
                <script>
                    if (${user.gender} === true) {
                        document.getElementById("male").checked = true;
                    } else if (${user.gender} === false) {
                        document.getElementById("female").checked = true;
                    }
                </script>

                <div class="detail_author">
                    <label>Ngày sinh</label>
                    <input type="date" name="dob_user" value="${dob}" id="dob">
                    <div id="dobError" class="error-message"></div>
                </div>
            </div>

            <div class="detail_info_image">
                <div class="detail_image_user">
                    <c:if test="${user.avatarLink == null}">
                        <img src="<c:url value="/templates/images/account.png"/>" alt="" id="imageElement">
                    </c:if>
                    <c:if test="${user.avatarLink != null}">
                        <img src="<c:url value="/templates/images/${user.avatarLink}"/>" alt="" id="imageElement">
                    </c:if>
                    <input path="avatarLink" type="file" id="image_user" style="display: none;" name="image_user">
                    <button type="button" onclick="document.getElementById('image_user').click();">Chọn ảnh</button>
                </div>
                <script>
                    const fileInput = document.getElementById('image_user');
                    const imageElement = document.getElementById('imageElement');

                    fileInput.addEventListener('change', function() {
                        const file = fileInput.files[0];

                        if (file) {
                            const reader = new FileReader();
                            reader.onload = function(e) {
                                imageElement.src = e.target.result;
                            };
                            reader.readAsDataURL(file);
                        } else {
                            alert('Vui lòng chọn một tệp tin hình ảnh.');
                            imageElement.src = '';
                        }
                    });
                </script>
            </div>
        </div>

        <div class="detail_info_submit">
            <input type="submit" class="btn-primary" value="Lưu">
            <a href="/" class="btn-danger">Thoát</a>
        </div>
    </form>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.getElementById("profileForm");
        form.addEventListener("submit", function (event) {
            let isValid = true;

            // Name validation
            const firstName = document.getElementById("firstName");
            const firstNameError = document.getElementById("firstNameError");
            if (firstName.value.trim().length === 0) {
                firstNameError.textContent = "Họ không được để trống.";
                firstName.classList.add("error-input");
                isValid = false;
            } else {
                firstNameError.textContent = "";
                firstName.classList.remove("error-input");
            }

            // Last name validation
            const lastName = document.getElementById("lastName");
            const lastNameError = document.getElementById("lastNameError");
            if (lastName.value.trim().length === 0) {
                lastNameError.textContent = "Tên không được để trống.";
                lastName.classList.add("error-input");
                isValid = false;
            } else {
                lastNameError.textContent = "";
                lastName.classList.remove("error-input");
            }

            // Phone number validation (must be 10 digits)
            const phoneNumber = document.getElementById("phoneNumber");
            const phoneError = document.getElementById("phoneError");
            const phoneRegex = /^\d{10}$/;
            if (!phoneRegex.test(phoneNumber.value)) {
                phoneError.textContent = "Số điện thoại phải đúng 10 chữ số.";
                phoneNumber.classList.add("error-input");
                isValid = false;
            } else {
                phoneError.textContent = "";
                phoneNumber.classList.remove("error-input");
            }

            // Date of birth validation
            const dob = document.getElementById("dob");
            const dobError = document.getElementById("dobError");
            if (dob.value.trim().length === 0) {
                dobError.textContent = "Vui lòng chọn ngày sinh.";
                dob.classList.add("error-input");
                isValid = false;
            } else {
                dobError.textContent = "";
                dob.classList.remove("error-input");
            }

            if (!isValid) {
                event.preventDefault(); // Prevent form submission if validation fails
            }
        });
    });
</script>
<style>
    .error-message {
        color: red;
        font-size: smaller;
        margin-bottom: 8px;
    }

    .error-input {
        border-color: red; /* Highlight the input box with an error */
    }
</style>
</body>
</html>
