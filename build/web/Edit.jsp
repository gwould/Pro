<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edit Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="css/manager.css" rel="stylesheet" type="text/css"/>
    <style>
        .modal-content {
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .modal-header {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            border-radius: 15px 15px 0 0;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-control, .form-select {
            border-radius: 8px;
            padding: 0.5rem 1rem;
        }
        
        .preview-img {
            max-width: 200px;
            max-height: 120px;
            object-fit: cover;
            border-radius: 8px;
            margin-top: 0.5rem;
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
    <div class="container py-5">
        <div class="row mb-4">
            <div class="col-12">
                <h2 class="fw-bold">Edit Product</h2>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                        <li class="breadcrumb-item"><a href="#">Products</a></li>
                        <li class="breadcrumb-item active">Edit</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="modal-content">
                    <form action="edit" method="post" id="editForm">
                        <div class="modal-header">
                            <h4 class="modal-title">Edit Product Details</h4>
                            <a href="#" class="btn-close btn-close-white" aria-label="Close"></a>
                        </div>
                        
                        <div class="modal-body p-4">
                            <div class="form-group">
                                <label class="form-label fw-bold">Product ID</label>
                                <input value="${detail.id}" name="id" type="text" class="form-control" readonly required>
                            </div>

                            <div class="form-group">
                                <label class="form-label fw-bold">Name</label>
                                <input value="${detail.name}" name="name" type="text" class="form-control" required>
                            </div>

                            <div class="form-group">
                                <label class="form-label fw-bold">Image URL</label>
                                <input value="${detail.image}" name="image" type="text" class="form-control" required id="imageUrl">
                                <img src="${detail.image}" alt="Preview" class="preview-img" id="imagePreview">
                            </div>

                            <div class="form-group">
                                <label class="form-label fw-bold">Price ($)</label>
                                <input value="${detail.price}" name="price" type="number" step="0.01" class="form-control" required>
                            </div>

                            <div class="form-group">
                                <label class="form-label fw-bold">Title</label>
                                <textarea name="title" class="form-control" rows="2" required>${detail.title}</textarea>
                            </div>

                            <div class="form-group">
                                <label class="form-label fw-bold">Description</label>
                                <textarea name="description" class="form-control" rows="4" required>${detail.description}</textarea>
                            </div>

                            <div class="form-group">
                                <label class="form-label fw-bold">Category</label>
                                <select name="category" class="form-select" required>
                                    <c:forEach items="${listCC}" var="o">
                                        <option value="${o.cid}" ${o.cid == detail.category ? 'selected' : ''}>${o.cname}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="modal-footer p-3">
                            <a href="#" class="btn btn-secondary btn-modern me-2">Cancel</a>
                            <button type="submit" class="btn btn-success btn-modern">
                                <i class="fas fa-save me-2"></i>Save Changes
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/manager.js" type="text/javascript"></script>
    <script>
        // Image preview update
        const imageUrl = document.getElementById('imageUrl');
        const imagePreview = document.getElementById('imagePreview');
        
        imageUrl.addEventListener('input', function() {
            imagePreview.src = this.value || '${detail.image}';
        });

        // Form validation
        document.getElementById('editForm').addEventListener('submit', function(e) {
            const price = document.querySelector('input[name="price"]').value;
            if (price <= 0) {
                e.preventDefault();
                alert('Price must be greater than 0');
            }
        });
    </script>
</body>
</html>