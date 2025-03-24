<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manage Products</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link href="css/manager.css" rel="stylesheet" type="text/css"/>
    <style>
        .table-wrapper {
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            padding: 20px;
        }
        
        .table-title {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            padding: 1.5rem;
            border-radius: 10px 10px 0 0;
        }
        
        .table {
            border-radius: 10px;
            overflow: hidden;
        }
        
        .table-hover tbody tr:hover {
            background: #f8f9fa;
        }
        
        img {
            width: 200px;
            height: 120px;
            object-fit: cover;
            border-radius: 5px;
        }
        
        .btn-success {
            background: linear-gradient(135deg, #28a745, #218838);
            border: none;
            border-radius: 20px;
        }
        
        .btn-danger {
            background: linear-gradient(135deg, #dc3545, #c82333);
            border: none;
            border-radius: 20px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #007bff, #0062cc);
            border: none;
            border-radius: 20px;
        }
        
        .modal-content {
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        }
        
        .modal-header {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            border-radius: 15px 15px 0 0;
        }
        
        .form-control, .form-select {
            border-radius: 8px;
            padding: 0.75rem;
        }
        
        .pagination .page-link {
            border-radius: 5px;
            margin: 0 2px;
        }
        
        .pagination .active .page-link {
            background: #007bff;
            border-color: #007bff;
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="table-wrapper">
            <div class="table-title">
                <div class="row align-items-center">
                    <div class="col-sm-6">
                        <h2>Manage <b>Products</b></h2>
                    </div>
                    <div class="col-sm-6 text-end">
                        <a href="#addEmployeeModal" class="btn btn-success" data-bs-toggle="modal">
                            <i class="material-icons"></i> <span>Add New Product</span>
                        </a>
                        <a href="#deleteEmployeeModal" class="btn btn-danger" data-bs-toggle="modal">
                            <i class="material-icons"></i> <span>Delete</span>
                        </a>
                    </div>
                </div>
            </div>
            <table class="table table-striped table-hover mt-3">
                <thead class="bg-light">
                    <tr>
                        <th>
                            <span class="custom-checkbox">
                                <input type="checkbox" id="selectAll">
                                <label for="selectAll"></label>
                            </span>
                        </th>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Image</th>
                        <th>Price</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listP}" var="o">
                        <tr>
                            <td>
                                <span class="custom-checkbox">
                                    <input type="checkbox" id="checkbox${o.id}" name="options[]" value="1">
                                    <label for="checkbox${o.id}"></label>
                                </span>
                            </td>
                            <td>${o.id}</td>
                            <td>${o.name}</td>
                            <td><img src="${o.image}"></td>
                            <td>${o.price} $</td>
                            <td>
                                <a href="loadProduct?pid=${o.id}" class="edit" data-bs-toggle="modal">
                                    <i class="material-icons" data-bs-toggle="tooltip" title="Edit"></i>
                                </a>
                                <a href="delete?pid=${o.id}" class="delete" data-bs-toggle="modal">
                                    <i class="material-icons" data-bs-toggle="tooltip" title="Delete"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="clearfix mt-4">
                <div class="hint-text">Showing <b>5</b> out of <b>25</b> entries</div>
                <ul class="pagination justify-content-end">
                    <li class="page-item disabled"><a href="#" class="page-link">Previous</a></li>
                    <li class="page-item"><a href="#" class="page-link">1</a></li>
                    <li class="page-item"><a href="#" class="page-link">2</a></li>
                    <li class="page-item active"><a href="#" class="page-link">3</a></li>
                    <li class="page-item"><a href="#" class="page-link">4</a></li>
                    <li class="page-item"><a href="#" class="page-link">5</a></li>
                    <li class="page-item"><a href="#" class="page-link">Next</a></li>
                </ul>
            </div>
            <a href="#"><button type="button" class="btn btn-primary mt-3">Back to home</button></a>
        </div>
    </div>

    <!-- Add Modal HTML -->
    <div id="addEmployeeModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="add" method="post">
                    <div class="modal-header">
                        <h4 class="modal-title">Add Product</h4>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-hidden="true"></button>
                    </div>
                    <div class="modal-body p-4">
                        <div class="form-group mb-3">
                            <label>Name</label>
                            <input name="name" type="text" class="form-control" required>
                        </div>
                        <div class="form-group mb-3">
                            <label>Image</label>
                            <input name="image" type="text" class="form-control" required>
                        </div>
                        <div class="form-group mb-3">
                            <label>Price</label>
                            <input name="price" type="text" class="form-control" required>
                        </div>
                        <div class="form-group mb-3">
                            <label>Title</label>
                            <textarea name="title" class="form-control" required></textarea>
                        </div>
                        <div class="form-group mb-3">
                            <label>Description</label>
                            <textarea name="description" class="form-control" required></textarea>
                        </div>
                        <div class="form-group mb-3">
                            <label>Category</label>
                            <select name="category" class="form-select" aria-label="Default select example">
                                <c:forEach items="${listCC}" var="o">
                                    <option value="${o.cid}">${o.cname}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="button" class="btn btn-secondary" data-bs-dismiss="modal" value="Cancel">
                        <input type="submit" class="btn btn-success" value="Add">
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/manager.js" type="text/javascript"></script>
</body>
</html>