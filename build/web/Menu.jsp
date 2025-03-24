<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--begin of menu-->
<nav class="navbar navbar-expand-md navbar-dark" 
     style="background: linear-gradient(135deg, #343a40, #212529); box-shadow: 0 2px 10px rgba(0,0,0,0.2);">
    <div class="container">
        <a class="navbar-brand fw-bold" href="home" 
           style="font-size: 1.5rem; letter-spacing: 1px; transition: color 0.3s ease;">YataShop</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" 
                data-bs-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" 
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-end" id="navbarsExampleDefault">
            <ul class="navbar-nav m-auto mb-2 mb-md-0">
                <c:if test="${sessionScope.acc.isAdmin == 1}">
                    <li class="nav-item">
                        <a class="nav-link px-3" href="#" 
                           style="transition: color 0.3s ease;">Manager Account</a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.acc.isSell == 1}">
                    <li class="nav-item">
                        <a class="nav-link px-3" href="manager" 
                           style="transition: color 0.3s ease;">Manager Product</a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.acc != null}">
                    <li class="nav-item">
                        <a class="nav-link px-3" href="#" 
                           style="transition: color 0.3s ease;">Hello ${sessionScope.acc.user}</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link px-3" href="logout" 
                           style="transition: color 0.3s ease;">Logout</a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.acc == null}">
                    <li class="nav-item">
                        <a class="nav-link px-3" href="login" 
                           style="transition: color 0.3s ease;">Login</a>
                    </li>
                </c:if>
            </ul>

            <form action="search" method="post" class="d-flex align-items-center ms-3">
                <div class="input-group" style="max-width: 250px;">
                    <input oninput="searchByName(this)" value="${txtS}" name="txt" type="text" 
                           class="form-control" placeholder="Search..." 
                           style="border-radius: 20px 0 0 20px; padding: 0.5rem 1rem;">
                    <button type="submit" class="btn btn-secondary" 
                            style="border-radius: 0 20px 20px 0; background: linear-gradient(135deg, #6c757d, #5a6268);">
                        <i class="fa fa-search"></i>
                    </button>
                </div>
                <a class="btn btn-success ms-3" href="show" 
                   style="border-radius: 20px; background: linear-gradient(135deg, #28a745, #218838); padding: 0.5rem 1rem;">
                    <i class="fa fa-shopping-cart me-1"></i> Cart
                    <span class="badge bg-light text-dark ms-1" 
                          style="border-radius: 10px; padding: 0.25em 0.5em;">3</span>
                </a>
            </form>
        </div>
    </div>
</nav>

<section class="jumbotron text-center py-5" 
         style="background: linear-gradient(135deg, #f8f9fa, #e9ecef);">
    <div class="container">
        <h1 class="jumbotron-heading display-4 fw-bold" 
            style="color: #343a40; text-shadow: 1px 1px 2px rgba(0,0,0,0.1);">YataShop</h1>
        <p class="lead text-muted mb-0" 
           style="font-size: 1.25rem; letter-spacing: 0.5px;">Thương hiệu quần áo nam cao cấp</p>
    </div>
</section>
<!--end of menu-->