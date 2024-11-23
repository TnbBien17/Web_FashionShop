<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<div class="container">
	<h2 class="display-6 my-3">Thống kê theo tháng</h2>
    <form action="" method="get">
        <%-- year input, default is current year --%>
        <div class="form-group row">
            <label class="col-sm-1 col-form-label">Năm:</label>
            <div class="col-sm-2">
                <%-- get current year --%>
                <input type="number" class="form-control" name="year" value="${year}" min="2000" max="2100" required>
            </div>
            <%-- submit button --%>
            <div class="col-sm-4">
                <button type="submit" class="btn btn-primary">Xem</button>
            </div>
        </div>
    </form>
    <section>
        <div class="title">
            <i class="fa-regular fa-heart"></i> <span class="text">Biểu đồ doanh thu</span>
        </div>
        <div class="chart">
            <canvas id="revenueChart"></canvas>
        </div>
        <script>
            var ctx = document.getElementById('revenueChart').getContext('2d');
            var chart = new Chart(ctx, {
                type : 'line',
                data : {
                    labels : ${revenueByMonth.keySet()},
                    datasets : [ {
                        label : 'Doanh thu',
                        backgroundColor : 'rgb(255, 99, 132)',
                        borderColor : 'rgb(255, 99, 132)',
                        data : ${revenueByMonth.values()}
                    } ]
                },
                options : {}
            });
        </script>
	</section>

    <section>
        <div class="title">
            <i class="fa-regular fa-heart"></i> <span class="text">Biểu đồ doanh số theo hãng</span>
        </div>
        <c:if test="${brand1 != null}">
        <div class="chart">
            <canvas id="brandSalesChart"></canvas>
        </div>
        <script>
            var ctx = document.getElementById('brandSalesChart').getContext('2d');
            var chart = new Chart(ctx, { 
                type : 'bar',
                data : {
                    labels : ${brandSales1.keySet()},
                    datasets : [ <c:if test="${brand1 != null}"> {
                        label : '${brand1.name}',
                        backgroundColor : 'rgb(255, 99, 132)',
                        borderColor : 'rgb(255, 99, 132)',
                        data : ${brandSales1.values()}
                    }, </c:if> <c:if test="${brand2 != null}"> {
                        label : '${brand2.name}',
                        backgroundColor : 'rgb(54, 162, 235)',
                        borderColor : 'rgb(54, 162, 235)',
                        data : ${brandSales2.values()}
                    }, </c:if> <c:if test="${brand3 != null}"> {
                        label : '${brand3.name}',
                        backgroundColor : 'rgb(255, 206, 86)',
                        borderColor : 'rgb(255, 206, 86)',
                        data : ${brandSales3.values()}
                    } </c:if> ]
                },
                options : {}
            });
        </script>
        </c:if>
        <c:if test="${brand1 == null}">
            <div class="alert alert-info">Không có dữ liệu</div>
        </c:if>
	</section>
</div>
