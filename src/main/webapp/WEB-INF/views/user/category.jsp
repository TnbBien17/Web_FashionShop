<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--<%@ include file="/common/taglib.jsp" %>--%>
<c:set var="temp" value="0"/>
<body>
<div class="container">

    <div class="row">
        <div class="col-12 col-sm-3">
            <div class="card bg-light mb-3">
                <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Categories</div>
                <ul class="list-group category_block">

                    <li class="list-group-item">
                        <a href="/category">Tất cả</a>
                    </li>
                    <c:forEach var="i" items="${sessionScope.list_category}">

                        <li class="list-group-item"><a href="/category/${i.id}">${i.name} (${listCountProduct.get(temp)})</a></li>

                        <c:set var="temp" value="${temp + 1}"/>

                    </c:forEach>
                </ul>
            </div>
            <div class="card bg-light mb-3">
                <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Search for brand</div>
                <ul class="list-group category_block">
                    <li class="list-group-item"><a href="/category/">Tất cả</a></li>
                    <c:forEach var="i" items="${sessionScope.list_brand}">
                        <li class="list-group-item"><a href="/brand/${i.id}">${i.name}</a></li>
                    </c:forEach>
                </ul>
            </div>

        </div>
        <div class="col">
            <div class="row" id="content">

                <th:block th:if="${message != null}">
                    <p th:text="${message}" style="color: red; font-weight: bold; font-size: 18px; margin-bottom: 15px; height: 500px">${message}</p>
                </th:block>


                <c:forEach var="i" items="${sessionScope.list_product_category}">
                    <div class="product col-12 col-md-6 col-lg-4">
                        <div class="card prefix">
                            <div>
                                        <c:if test="${i.images.size() > 0}">
                                            <img class="card-img-top" src="<c:url value="/templates/images/${i.images[0].imageLink}"/>" alt="Card image cap">
                                        </c:if>
                                        <c:if test="${i.images.size() == 0}">
                                            <img  class="card-img-top" src="<c:url value="/templates/images/no-image.png"/>" alt="Card image cap">
                                        </c:if>
                                        </div>
                            <div class="card-body">
                                <h4 class="card-title"><a href="/product/${i.id}" title="View Product">${i.name} </a></h4>
                                <pre class="card-text">${i.description}</pre>
                                <div class="row">
                                    <div class="col">
                                        <p class="btn btn-danger btn-block price" data-price="${i.price}">${i.price}VNĐ</p>
                                    </div>
                                    <div class="col">
                                        <a href="/product/${i.id}" class="btn btn-success btn-block">Add to cart</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>


                <div class="col-12">

                    <nav aria-label="...">

                        <div class="data-container" id="data-container" style="display: flex;">
                            <button class="btn_page left page-item page-link" onclick="previous()">Previous</button>
                            <ul class="pagination" id="pagination">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#" tabindex="-1">Previous</a>
                                </li>
                                <li class="page-item"><a class="page-link" href="#">1</a></li>
                                <li class="page-item active">
                                    <a class="page-link" href="#">2 <span class="sr-only">(current)</span></a>
                                </li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="#">Next</a>
                                </li>
                            </ul>
                            <button class="btn_page right page-item page-link"  >Next</button>
                        </div>

                    </nav>
                </div>
            </div>
        </div>

    </div>
</div>
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<script>
   var listProduct = document.querySelectorAll(".product");
   var btn_previous = document.querySelector(".btn_page.left");
   var btn_next = document.querySelector(".btn_page.right");

   let thisPost=1;
   let limitPost=6;

    function previous() {
        if (thisPost > 1) {
            thisPost--;
            loadPost();
        }
    }
    function next() {
        if (thisPost < Math.ceil(listProduct.length / limitPost)) {
            thisPost++;
            loadPost();
        }
    }

    btn_next.addEventListener("click",()=>{
      if(thisPost<Math.ceil(listProduct.length/limitPost)){
         thisPost++;
         loadPost();
      }
    });
   function loadPost(){
     let begin = (thisPost-1)*limitPost;
     let end = thisPost*limitPost-1;
     listProduct.forEach((item,index)=>{
       if(index>=begin && index<=end){
         item.style.display="block";
       }else{
         item.style.display="none";
       }
     })
       listPost();
   }
   loadPost();

   function listPost() {
       let count = Math.ceil(listProduct.length / limitPost);
       document.querySelector(".pagination").innerHTML = "";

       for (i = 1; i <= count; i++) {
           let newPost = document.createElement("li");
           newPost.classList.add("page-item")
           newPost.classList.add("page-link")
           newPost.innerText = i;
           if (i === thisPost) {
               newPost.classList.add("active1");
           }
           newPost.setAttribute("onclick", "changePost(" + i + ")");
           document.querySelector(".pagination").appendChild(newPost);
       }

   }
   function changePost(post) {
       thisPost = post;
       loadPost();
   }

</script>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Chọn tất cả các phần tử có class 'price'
        const priceElements = document.querySelectorAll('.price');

        priceElements.forEach(priceElement => {
            // Lấy giá trị gốc từ thuộc tính data-price
            const originalPrice = parseFloat(priceElement.getAttribute('data-price'));

            if (!isNaN(originalPrice)) {
                // Định dạng giá trị thành dạng tiền tệ VNĐ
                priceElement.innerText = originalPrice.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
            }
        });
    });
</script>

</body>
