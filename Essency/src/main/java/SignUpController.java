import com.google.gson.JsonObject;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import Essency.User;


@WebServlet("/signUpControl")
public class SignUpController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private UserDAO userDAO;
	
    public SignUpController() {
        super();
    }
    
    public void init(ServletConfig config) throws ServletException {
		super.init(config);
		userDAO = new UserDAO();
	}
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 회원가입 처리
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "비밀번호가 일치하지 않습니다.");
            request.getRequestDispatcher("/jsp/signUp.jsp").forward(request, response);
            return;
        }
        
     // 새 사용자 생성
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setPhone(phone);

        boolean success = userDAO.registerUser(user);
        if (success) {
        	//아이디를 request에 저장하여 JSP에 전달
        	request.setAttribute("username", username);
		    request.getRequestDispatcher("/jsp/signUpSuccess.jsp").forward(request, response); // 포워드
        } else {
            request.setAttribute("error", "회원가입에 실패했습니다. 다시 시도해주세요.");
            request.getRequestDispatcher("/jsp/signUp.jsp").forward(request, response);
        }
	}
		
}
