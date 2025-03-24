<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" 
          integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" 
          crossorigin="anonymous">
    <link href="css/login.css" rel="stylesheet" type="text/css"/>
    <title>Login Form</title>
    <style>
        #logreg-forms {
            max-width: 400px;
            margin: 50px auto;
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            padding: 2rem;
        }
        
        .form-signin, .form-signup {
            display: block;
        }
        
        .form-control {
            border-radius: 10px;
            padding: 0.75rem 1rem;
            margin-bottom: 1rem;
            border: 1px solid #ced4da;
            transition: border-color 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0,123,255,0.3);
        }
        
        .btn-success {
            background: linear-gradient(135deg, #28a745, #218838);
            border: none;
            border-radius: 10px;
            padding: 0.75rem;
            transition: transform 0.3s ease;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #007bff, #0062cc);
            border: none;
            border-radius: 10px;
            padding: 0.75rem;
            transition: transform 0.3s ease;
        }
        
        .btn:hover {
            transform: translateY(-2px);
        }
        
        .form-check {
            margin-bottom: 1.5rem;
        }
        
        hr {
            margin: 1.5rem 0;
            border-color: #dee2e6;
        }
        
        h1.h3 {
            color: #343a40;
            font-weight: 600;
        }
        
        #cancel_signup {
            color: #6c757d;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        
        #cancel_signup:hover {
            color: #007bff;
        }
        
        .text-danger {
            margin-bottom: 1rem;
            padding: 0.5rem;
            background: #f8d7da;
            border-radius: 5px;
        }
    </style>
</head>
<body style="background: linear-gradient(135deg, #f8f9fa, #e9ecef);">
    <div id="logreg-forms">
        <form class="form-signin" action="login" method="post">
            <h1 class="h3 mb-3 text-center">Sign In</h1>
            <p class="text-danger text-center">${mess}</p>
            <input name="user" type="text" id="inputEmail" class="form-control" 
                   placeholder="Username" required autofocus>
            <input name="pass" type="password" id="inputPassword" class="form-control" 
                   placeholder="Password" required>

            <div class="form-group form-check">
                <input name="remember" value="1" type="checkbox" class="form-check-input" 
                       id="exampleCheck1">
                <label class="form-check-label" for="exampleCheck1">Remember me</label>
            </div>

            <button class="btn btn-success btn-block" type="submit">
                <i class="fas fa-sign-in-alt me-2"></i>Sign In
            </button>
            <hr>
            <button class="btn btn-primary btn-block" type="button" id="btn-signup">
                <i class="fas fa-user-plus me-2"></i>Sign Up New Account
            </button>
        </form>

        <form action="signup" method="post" class="form-signup" style="display: none;">
            <h1 class="h3 mb-3 text-center">Sign Up</h1>
            <input name="user" type="text" id="user-name" class="form-control" 
                   placeholder="User name" required autofocus>
            <input name="pass" type="password" id="user-pass" class="form-control" 
                   placeholder="Password" required>
            <input name="repass" type="password" id="user-repeatpass" class="form-control" 
                   placeholder="Repeat Password" required>

            <button class="btn btn-primary btn-block" type="submit">
                <i class="fas fa-user-plus me-2"></i>Sign Up
            </button>
            <a href="#" id="cancel_signup" class="d-block mt-3">
                <i class="fas fa-angle-left me-2"></i>Back
            </a>
        </form>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleResetPswd(e) {
            e.preventDefault();
            $('#logreg-forms .form-signin').toggle();
            $('#logreg-forms .form-reset').toggle();
        }

        function toggleSignUp(e) {
            e.preventDefault();
            $('#logreg-forms .form-signin').toggle();
            $('#logreg-forms .form-signup').toggle();
        }

        $(() => {
            $('#logreg-forms #forgot_pswd').click(toggleResetPswd);
            $('#logreg-forms #cancel_reset').click(toggleResetPswd);
            $('#logreg-forms #btn-signup').click(toggleSignUp);
            $('#logreg-forms #cancel_signup').click(toggleSignUp);
        });
    </script>
</body>
</html>