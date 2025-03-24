<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <style>
        .product-card {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        
        .product-card:hover {
            transform: translateY(-5px);
        }
        
        .card-img-top {
            height: 200px;
            object-fit: cover;
            border-bottom: 1px solid #eee;
        }
        
        .card-body {
            padding: 1.5rem;
        }
        
        .card-title {
            margin-bottom: 1rem;
            font-size: 1.25rem;
        }
        
        .card-text {
            color: #666;
            margin-bottom: 1.5rem;
        }
        
        .btn-danger {
            background: linear-gradient(135deg, #dc3545, #c82333);
            border: none;
            border-radius: 20px;
            padding: 0.5rem 1rem;
        }
        
        .btn-success {
            background: linear-gradient(135deg, #28a745, #218838);
            border: none;
            border-radius: 20px;
            padding: 0.5rem 1rem;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #007bff, #0062cc);
            border: none;
            border-radius: 20px;
            padding: 0.75rem 2rem;
            margin-top: 2rem;
        }
        
        .breadcrumb {
            background: #f8f9fa;
            padding: 1rem;
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <jsp:include page="Menu.jsp"></jsp:include>
    <div class="container py-5">
        <div class="row">
            <div class="col">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="Home.jsp">Home</a></li>
                        <li class="breadcrumb-item"><a href="#">Category</a></li>
                        <li class="breadcrumb-item active">Sub-category</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="row">
            <jsp:include page="Left.jsp"></jsp:include>

            <div class="col-sm-9">
                <div id="content" class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                    <c:forEach items="${listP}" var="o">
                        <div class="col product">
                            <div class="card product-card">
                                <img class="card-img-top" src="${o.image}" alt="Card image cap">
                                <div class="card-body">
                                    <h4 class="card-title show_txt">
                                        <a href="detail?pid=${o.id}" title="View Product" class="text-dark text-decoration-none">${o.name}</a>
                                    </h4>
                                    <p class="card-text show_txt">${o.title}</p>
                                    <div class="row">
                                        <div class="col">
                                            <p class="btn btn-danger btn-block">${o.price} $</p>
                                        </div>
                                        <div class="col">
                                            <a href="#" class="btn btn-success btn-block">Add to cart</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="text-center">
                    <button onclick="loadMore()" class="btn btn-primary">Load more</button>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="Footer.jsp"></jsp:include>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script>
        function loadMore() {
            var amount = document.getElementsByClassName("product").length;
            $.ajax({
                url: "/Project_banhang/load",
                type: "get",
                data: { exits: amount },
                success: function(data) {
                    var row = document.getElementById("content");
                    row.innerHTML += data;
                },
                error: function(xhr) {
                    //Do Something to handle error
                }
            });
        }
        
        function searchByName(param) {
            var txtSearch = param.value;
            $.ajax({
                url: "/Project_banhang/searchAjax",
                type: "get",
                data: { txt: txtSearch },
                success: function(data) {
                    var row = document.getElementById("content");
                    row.innerHTML = data;
                },
                error: function(xhr) {
                    //Do Something to handle error
                }
            });
        }
    </script>
</body>
</html>