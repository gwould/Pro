<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="col-sm-3">
    <div class="card mb-4 shadow-sm" style="border-radius: 15px; overflow: hidden;">
        <div class="card-header bg-primary text-white text-uppercase py-3" 
             style="background: linear-gradient(135deg, #007bff, #0056b3);">
            <i class="fa fa-list me-2"></i>Categories
        </div>
        <ul class="list-group category_block flush">
            <c:forEach items="${listCC}" var="o">
                <li class="list-group-item ${tag == o.cid ? 'active' : ''}"
                    style="border: none; padding: 0;">
                    <a href="category?cid=${o.cid}" 
                       class="d-block px-4 py-3 text-dark text-decoration-none 
                              ${tag == o.cid ? 'text-white' : ''}"
                       style="transition: all 0.3s ease;">
                        ${o.cname}
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>

    <!-- Uncomment and upgrade this section if needed -->
    <!--
    <div class="card mb-4 shadow-sm" style="border-radius: 15px; overflow: hidden;">
        <div class="card-header bg-success text-white text-uppercase py-3"
             style="background: linear-gradient(135deg, #28a745, #218838);">
            <i class="fa fa-star me-2"></i>Last Product
        </div>
        <div class="card-body p-4">
            <img class="img-fluid rounded mb-3" src="${p.image}" 
                 style="max-height: 150px; object-fit: cover;" />
            <h5 class="card-title mb-2 fw-bold">${p.name}</h5>
            <p class="card-text text-muted">${p.title}</p>
            <p class="fw-bold text-success mb-0" 
               style="background: #e9ecef; display: inline-block; padding: 5px 15px; border-radius: 20px;">
                ${p.price} $
            </p>
        </div>
    </div>
    -->
</div>