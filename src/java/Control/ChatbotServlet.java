package Control;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.io.IOException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ChatbotServlet", urlPatterns = {"/chatbot"})
public class ChatbotServlet extends HttpServlet {
    private static final String OPENAI_API_KEY = "AIzaSyAX_ilrWvXCK3QU2kdeT9TpyAP8-odIYFc"; // Thay bằng key của bạn
    private static final String OPENAI_API_URL = "https://api.openai.com/v1/chat/completions";
    private final ObjectMapper mapper = new ObjectMapper();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String userMessage = request.getParameter("message").trim();
        String botResponse = getBotResponse(userMessage);
        
        response.setContentType("text/plain; charset=UTF-8");
        response.getWriter().write(botResponse);
    }
    
    private String getBotResponse(String message) {
        try {
            // Tạo prompt với ngữ cảnh cửa hàng
            String prompt = "Bạn là chatbot của YataShop, một cửa hàng quần áo " ;

            String jsonRequest = String.format(
                "{\"model\": \"gpt-3.5-turbo\", \"messages\": [{\"role\": \"user\", \"content\": \"%s\"}], \"max_tokens\": 150}",
                prompt.replace("\"", "\\\"")
            );

            // Gửi yêu cầu bằng HttpURLConnection
            URL url = new URL(OPENAI_API_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Bearer " + OPENAI_API_KEY);
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = jsonRequest.getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            int responseCode = conn.getResponseCode();
            if (responseCode != HttpURLConnection.HTTP_OK) {
                return "Xin lỗi, tôi gặp lỗi khi xử lý câu hỏi của bạn (HTTP " + responseCode + "). Hãy thử lại nhé!";
            }

            StringBuilder responseBody = new StringBuilder();
            try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"))) {
                String line;
                while ((line = br.readLine()) != null) {
                    responseBody.append(line);
                }
            }

            JsonNode jsonNode = mapper.readTree(responseBody.toString());
            return jsonNode.get("choices").get(0).get("message").get("content").asText();

        } catch (Exception e) {
            e.printStackTrace();
            return "Xin lỗi, có lỗi xảy ra: " + e.getMessage() + ". Bạn hãy thử lại sau nhé!";
        }
    }
}