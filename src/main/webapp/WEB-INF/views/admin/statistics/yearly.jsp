<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<div class="container">
	<h2 class="display-6 my-3">Thống kê theo năm</h2>
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
                    labels : ${revenueByYear.keySet()},
                    datasets : [ {
                        label : 'Doanh thu',
                        backgroundColor : 'rgb(255, 99, 132)',
                        borderColor : 'rgb(255, 99, 132)',
                        data : ${revenueByYear.values()}
                    } ]
                },
                options : {}
            });
        </script>
	</section>
</div>
