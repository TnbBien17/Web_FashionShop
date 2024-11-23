<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>

<!DOCTYPE html>
<div class="container">
    <h2 class="display-6 my-3">Khách hàng</h2>
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
    <div class="table-responsive">
        <table style="margin: 10px 5px;" id="table"
            class="table-striped table bg-white">
            <thead class="table-dark">
                <tr style="font-weight: bold">
                    <th>ID</th>
                    <th>Tên</th>
                    <th>SDT</th>
                    <th>Email</th>
                    <th>Ngày sinh</th>
                    <th>Giới tính</th>
                    <th>Trạng thái</th>
                    <th>Đăng nhập cuối</th>
                    <th style="width: 200px;">Tác vụ</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="i" items="${list}">
                    <tr>
                        <td>${i.id}</td>
                        <td>${i.firstName} ${i.lastName}</td>
                        <td>${i.phone}</td>
                        <td>${i.email}</td>
                        <td><fmt:formatDate value="${i.dob}" pattern="yyyy-MM-dd"/></td>
                        <td>${i.gender ? "Nữ" : "Nam"}</td>
                        <td>
                            <c:if test="${i.active}">
                                <span class="badge text-bg-success">Hoạt động</span>
                            </c:if>
                            <c:if test="${!i.active}">
                                <span class="badge text-bg-danger">Đã khóa</span>
                            </c:if>
                        </td>
                        <td>${i.lastLogin}</td>
                        <td>
                            <a href="customer/banOrUnban/${i.id}" class="btn btn-outline-${i.active ? 'danger' : 'success'}">
                                <i class="fa-solid fa-ban"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.5.0/js/responsive.bootstrap5.min.js"></script>
<script>
    new DataTable('#table', {
				pagingType : 'full_numbers',
				"pageLength" : 5,
				responsive: true,
			});
</script>