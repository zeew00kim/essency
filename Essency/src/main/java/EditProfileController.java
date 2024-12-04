

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
    	// 세션에서 사용자명 가져오기
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        
        if (loggedInUser == null) {
            response.sendRedirect("/Essency/jsp/login.jsp");
            return;
        }
        
        String username = loggedInUser.getUsername();

        // 요청 데이터 가져오기
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
                loggedInUser.setPassword(password); // 비밀번호가 입력된 경우만 업데이트
                userDAO.updateUser(loggedInUser); // 비밀번호 포함 업데이트
            } else {
                userDAO.updateUserWithoutPassword(loggedInUser); // 비밀번호 제외 업데이트
            }

            // 세션 데이터 업데이트
            session.setAttribute("loggedInUser", loggedInUser);

            // 성공 페이지로 리다이렉트
            response.sendRedirect("/Essency/webservice/jsp/my_page.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "정보 수정 중 오류가 발생했습니다. 다시 시도해주세요.");
            request.getRequestDispatcher("/jsp/editProfile.jsp").forward(request, response);
        }
    }

}
