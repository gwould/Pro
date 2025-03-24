<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${detail.name} - Product Details</title>
    <!-- Updated to Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <style>
        .gallery-wrap .img-big-wrap {
            position: relative;
            overflow: hidden;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .gallery-wrap .img-big-wrap img {
            width: 100%;
            height: 450px;
            object-fit: cover;
            transition: transform 0.3s ease;
        }
        
        .gallery-wrap .img-big-wrap img:hover {
            transform: scale(1.1);
        }

        .gallery-wrap .img-small-wrap .item-gallery {
            width: 70px;
            height: 70px;
            margin: 5px;
            border: 2px solid transparent;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .gallery-wrap .img-small-wrap .item-gallery:hover,
        .gallery-wrap .img-small-wrap .item-gallery.active {
            border-color: #007bff;
        }

        .gallery-wrap .img-small-wrap img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 3px;
        }

        .product-info {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .btn-modern {
            transition: all 0.3s ease;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .btn-modern:hover {
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <jsp:include page="Menu.jsp"></jsp:include>
    <div class="container py-5">
        <div class="row">
            <jsp:include page="Left.jsp"></jsp:include>
            <div class="col-sm-9">
                <nav aria-label="breadcrumb" class="mb-4">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                        <li class="breadcrumb-item active">${detail.name}</li>
                    </ol>
                </div>

                <div class="product-info p-4">
                    <div class="row">
                        <!-- Product Images -->
                        <aside class="col-md-5">
                            <article class="gallery-wrap"> 
                                <div class="img-big-wrap mb-3">
                                    <img src="${detail.image}" alt="${detail.name}" id="mainImage">
                                </div>
                                <div class="img-small-wrap d-flex flex-wrap justify-content-center">
                                    <!-- Add multiple images if available -->
                                    <div class="item-gallery">
                                        <img src="${detail.image}" alt="thumbnail" onclick="changeImage(this)">
                                    </div>
                                    <!-- Add more thumbnails if available -->
                                </div>
                            </article>
                        </aside>

                        <!-- Product Details -->
                        <aside class="col-md-7">
                            <article class="ps-md-4">
                                <h2 class="fw-bold mb-3">${detail.name}</h2>
                                
                                <div class="price-detail-wrap mb-4">
                                    <span class="price h3 text-danger fw-bold">
                                        <span class="currency">US $</span>${detail.price}
                                    </span>
                                    <span class="text-muted text-decoration-line-through ms-3">$ ${(detail.price * 1.2)}</span>
                                    <span class="badge bg-success ms-2">20% OFF</span>
                                </div>

                                <div class="mb-4">
                                    <h5 class="fw-bold">Description</h5>
                                    <p class="text-muted">${detail.description}</p>
                                </div>

                                <div class="row mb-4 align-items-end">
                                    <div class="col-md-4">
                                        <label class="form-label fw-bold">Quantity:</label>
                                        <div class="input-group w-75">
                                            <button class="btn btn-outline-secondary" onclick="updateQuantity(-1)">-</button>
                                            <input type="number" class="form-control text-center" id="quantity" value="1" min="1">
                                            <button class="btn btn-outline-secondary" onclick="updateQuantity(1)">+</button>
                                        </div>
                                    </div>
                                </div>

                                <div class="d-flex gap-3">
                                    <a href="#" class="btn btn-primary btn-modern btn-lg flex-grow-1">
                                        <i class="fas fa-shopping-bag me-2"></i>Buy Now
                                    </a>
                                    <a href="#" class="btn btn-outline-primary btn-modern btn-lg flex-grow-1">
                                        <i class="fas fa-cart-plus me-2"></i>Add to Cart
                                    </a>
                                </div>

                                <!-- Additional Info -->
                                <div class="mt-4">
                                    <small class="text-muted">
                                        <i class="fas fa-shipping-fast me-1"></i> Free Shipping<br>
                                        <i class="fas fa-undo me-1"></i> 30 Days Return
                                    </small>
                                </div>
                            </article>
                        </aside>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="Footer.jsp"></jsp:include>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/your-fontawesome-kit.js" crossorigin="anonymous"></script>
    <script>
        function changeImage(element) {
            document.getElementById('mainImage').src = element.src;
            document.querySelectorAll('.item-gallery').forEach(item => item.classList.remove('active'));
            element.parentElement.classList.add('active');
        }

        function updateQuantity(change) {
            let qtyInput = document.getElementById('quantity');
            let currentValue = parseInt(qtyInput.value);
            let newValue = currentValue + change;
            if (newValue >= 1) {
                qtyInput.value = newValue;
            }
        }
    </script>
</body>
</html>