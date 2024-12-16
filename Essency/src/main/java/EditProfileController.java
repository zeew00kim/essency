

import java.io.IOException;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Essency.User;

@WebServlet("/editProfileControl")
public class EditProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    
    public EditProfileController() {
        super();
    }
    
    public void init(ServletConfig config) throws ServletException {
		super.init(config);
		userDAO = new UserDAO();
	}
    
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        if (loggedInUser == null) {
            response.sendRedirect("/Essency/jsp/login.jsp");
            return;
        }
        
        String username = loggedInUser.getUsername();
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "비밀번호가 일치하지 않습니다.");
            request.getRequestDispatcher("/jsp/editProfile.jsp").forward(request, response);
            return;
        }
        
        try {
        	loggedInUser.setEmail(email);
            loggedInUser.setPhone(phone);

            if (password != null && !password.isEmpty()) {
                loggedInUser.setPassword(password); 
                userDAO.updateUser(loggedInUser); 
            } else {
                userDAO.updateUserWithoutPassword(loggedInUser);
            }

            session.setAttribute("loggedInUser", loggedInUser);
            response.sendRedirect("/Essency/webservice/jsp/my_page.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "정보 수정 중 오류가 발생했습니다. 다시 시도해주세요.");
            request.getRequestDispatcher("/jsp/editProfile.jsp").forward(request, response);
        }
    }

}
