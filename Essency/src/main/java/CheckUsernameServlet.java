

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@WebServlet("/checkUsername")
public class CheckUsernameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO;
	
    public CheckUsernameServlet() {
        super();
    }
    
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
            JsonObject jsonRequest = JsonParser.parseString(sb.toString()).getAsJsonObject();
            String username = jsonRequest.get("username").getAsString();

            boolean isAvailable = userDAO.isUsernameAvailable(username);

            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("available", isAvailable);

            response.getWriter().write(jsonResponse.toString());
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
	}

}
