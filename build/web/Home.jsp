<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <style>
        .chatbot-container {
            position: fixed;
            bottom: 20px;
            right: 20px;
            width: 350px;
            z-index: 1000;
            font-family: Arial, sans-serif;
        }
        .chatbot-header {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            padding: 12px;
            border-radius: 10px 10px 0 0;
            cursor: pointer;
            text-align: center;
            font-weight: bold;
        }
        .chatbot-body {
            display: none;
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 0 0 10px 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            max-height: 450px;
            overflow-y: auto;
            padding: 15px;
        }
        .chat-message-user {
            background: #e9ecef;
            padding: 10px;
            border-radius: 10px;
            margin: 5px 0;
            text-align: right;
            max-width: 80%;
            margin-left: auto;
        }
        .chat-message-bot {
            background: #007bff;
            color: white;
            padding: 10px;
            border-radius: 10px;
            margin: 5px 0;
            text-align: left;
            max-width: 80%;
        }
        .chat-suggestions {
            margin-top: 10px;
            display: flex;
            flex-wrap: wrap;
            gap: 5px;
        }
        .chat-suggestion {
            background: #f1f3f5;
            padding: 5px 10px;
            border-radius: 15px;
            cursor: pointer;
            font-size: 0.9em;
            transition: background 0.3s ease;
        }
        .chat-suggestion:hover {
            background: #dee2e6;
        }
        .chat-input-group {
            margin-top: 15px;
        }
        .chat-input {
            border-radius: 20px;
            padding: 0.75rem;
        }
        .chat-btn {
            border-radius: 20px;
            background: linear-gradient(135deg, #007bff, #0062cc);
            padding: 0.75rem 1.5rem;
        }
    </style>
</head>
<body>
    <jsp:include page="Menu.jsp"></jsp:include>
    <div class="container">
        <div class="row">
            <div class="col">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="Home.jsp">Home</a></li>
                        <li class="breadcrumb-item"><a href="#">Category</a></li>
                        <li class="breadcrumb-item active" aria-current="#">Sub-category</li>
                    </ol>
                </nav>
            </div>
        </div>
        <div class="row">
            <jsp:include page="Left.jsp"></jsp:include>
            <div class="col-sm-9">
                <div id="content" class="row">
                    <c:forEach items="${listP}" var="o">
                        <div class="product col-12 col-md-6 col-lg-4">
                            <div class="card">
                                <img class="card-img-top" src="${o.image}" alt="Card image cap">
                                <div class="card-body">
                                    <h4 class="card-title show_txt"><a href="detail?pid=${o.id}" title="View Product">${o.name}</a></h4>
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
                <button onclick="loadMore()" class="btn btn-primary">Load more</button>
            </div>
        </div>
    </div>

    <!-- Chatbot Widget -->
    <div class="chatbot-container">
        <div class="chatbot-header" onclick="toggleChat()">Chat với YataShop</div>
        <div class="chatbot-body" id="chatbot-body">
            <div id="chat-messages">
                <div class="chat-message-bot">Xin chào! Tôi là trợ lý của YataShop. Hỏi tôi bất cứ điều gì nhé!</div>
            </div>
            <div class="chat-suggestions">
                <span class="chat-suggestion" onclick="sendMessage('Sản phẩm có những gì?')">Sản phẩm có gì?</span>
                <span class="chat-suggestion" onclick="sendMessage('Giá áo sơ mi bao nhiêu?')">Giá áo sơ mi?</span>
                <span class="chat-suggestion" onclick="sendMessage('Cửa hàng ở đâu?')">Cửa hàng ở đâu?</span>
                <span class="chat-suggestion" onclick="sendMessage('Chính sách đổi hàng thế nào?')">Đổi hàng?</span>
            </div>
            <div class="input-group chat-input-group">
                <input type="text" id="chat-input" class="form-control chat-input" placeholder="Hỏi tôi nhé...">
                <div class="input-group-append">
                    <button class="btn btn-primary chat-btn" onclick="sendMessage()">Gửi</button>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="Footer.jsp"></jsp:include>

    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script>
        function toggleChat() {
            var chatBody = document.getElementById("chatbot-body");
            chatBody.style.display = chatBody.style.display === "none" ? "block" : "none";
        }

        function sendMessage(predefinedMessage) {
            var input = document.getElementById("chat-input");
            var message = predefinedMessage || input.value.trim();
            if (message === "") return;

            var messagesDiv = document.getElementById("chat-messages");
            messagesDiv.innerHTML += '<div class="chat-message-user">' + message + '</div>';
            if (!predefinedMessage) input.value = "";

            $.ajax({
                url: "/Project_banhang/chatbot",
                type: "post",
                data: { message: message },
                success: function(response) {
                    messagesDiv.innerHTML += '<div class="chat-message-bot">' + response + '</div>';
                    messagesDiv.scrollTop = messagesDiv.scrollHeight;
                },
                error: function(xhr) {
                    messagesDiv.innerHTML += '<div class="chat-message-bot">Lỗi: Không thể kết nối chatbot</div>';
                    messagesDiv.scrollTop = messagesDiv.scrollHeight;
                }
            });
        }

        $("#chat-input").keypress(function(e) {
            if (e.which == 13) {
                sendMessage();
            }
        });
    </script>
</body>
</html>