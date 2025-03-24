<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Shopping Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .cart-container {
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .cart-item:hover {
            background: #f8f9fa;
            transition: background 0.3s;
        }
        
        .quantity-control {
            width: 150px;
        }
        
        .btn-modern {
            transition: all 0.3s ease;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .btn-modern:hover {
            transform: translateY(-2px);
        }
        
        .summary-section {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 15px;
        }
    </style>
</head>
<body>
    <jsp:include page="Menu.jsp"></jsp:include>
    <div class="shopping-cart py-5">
        <div class="container">
            <h2 class="mb-4 fw-bold">Your Cart</h2>
            
            <!-- Cart Items -->
            <div class="cart-container mb-5">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead class="bg-light">
                            <tr>
                                <th class="p-3 text-uppercase fw-bold">Product</th>
                                <th class="p-3 text-uppercase fw-bold">Price</th>
                                <th class="p-3 text-uppercase fw-bold">Quantity</th>
                                <th class="p-3 text-uppercase fw-bold">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${list}" var="o">
                                <tr class="cart-item align-middle" data-id="${o.id}">
                                    <td class="p-3">
                                        <div class="d-flex align-items-center">
                                            <img src="${o.image}" alt="${o.name}" class="rounded" style="width: 80px; height: 80px; object-fit: cover;">
                                            <div class="ms-3">
                                                <h5 class="mb-0"><a href="#" class="text-dark text-decoration-none">${o.name}</a></h5>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="p-3">
                                        <span class="fw-bold text-success">${o.price} $</span>
                                    </td>
                                    <td class="p-3">
                                        <div class="input-group quantity-control">
                                            <button class="btn btn-outline-secondary btn-modern btn-sub" type="button">-</button>
                                            <input type="number" class="form-control text-center qty-input" value="${o.amount}" min="1">
                                            <button class="btn btn-outline-secondary btn-modern btn-add" type="button">+</button>
                                        </div>
                                    </td>
                                    <td class="p-3">
                                        <button class="btn btn-danger btn-modern btn-delete">
                                            <i class="fas fa-trash me-1"></i>Delete
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Summary Section -->
            <div class="row g-4">
                <div class="col-lg-6">
                    <div class="summary-section p-4">
                        <h5 class="fw-bold mb-3">Voucher Code</h5>
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Enter voucher code">
                            <button class="btn btn-dark btn-modern" type="button">
                                <i class="fas fa-gift me-2"></i>Apply
                            </button>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-6">
                    <div class="summary-section p-4">
                        <h5 class="fw-bold mb-4">Order Summary</h5>
                        <ul class="list-unstyled">
                            <li class="d-flex justify-content-between py-2">
                                <span>Subtotal</span>
                                <strong id="subtotal">100 $</strong>
                            </li>
                            <li class="d-flex justify-content-between py-2">
                                <span>Shipping</span>
                                <strong class="text-success">Free</strong>
                            </li>
                            <li class="d-flex justify-content-between py-2">
                                <span>VAT</span>
                                <strong>10 $</strong>
                            </li>
                            <hr>
                            <li class="d-flex justify-content-between py-2">
                                <span class="fw-bold">Total</span>
                                <h4 class="fw-bold text-primary mb-0" id="total">110 $</h4>
                            </li>
                        </ul>
                        <a href="buy" class="btn btn-primary btn-modern w-100 py-3 mt-3">
                            Proceed to Checkout
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/your-fontawesome-kit.js" crossorigin="anonymous"></script>
    <script>
        // Quantity controls
        document.querySelectorAll('.btn-sub').forEach(btn => {
            btn.addEventListener('click', function() {
                const input = this.nextElementSibling;
                let value = parseInt(input.value);
                if (value > 1) {
                    input.value = value - 1;
                    updateTotal();
                }
            });
        });

        document.querySelectorAll('.btn-add').forEach(btn => {
            btn.addEventListener('click', function() {
                const input = this.previousElementSibling;
                let value = parseInt(input.value);
                input.value = value + 1;
                updateTotal();
            });
        });

        // Delete button (placeholder)
        document.querySelectorAll('.btn-delete').forEach(btn => {
            btn.addEventListener('click', function() {
                if (confirm('Remove this item from cart?')) {
                    this.closest('tr').remove();
                    updateTotal();
                }
            });
        });

        // Update total (basic implementation)
        function updateTotal() {
            let subtotal = 0;
            document.querySelectorAll('.cart-item').forEach(item => {
                const price = parseFloat(item.querySelector('.text-success').textContent);
                const qty = parseInt(item.querySelector('.qty-input').value);
                subtotal += price * qty;
            });
            
            document.getElementById('subtotal').textContent = subtotal.toFixed(2) + ' $';
            const vat = 10; // Should come from backend
            document.getElementById('total').textContent = (subtotal + vat).toFixed(2) + ' $';
        }

        // Initial total calculation
        updateTotal();
    </script>
</body>
</html>