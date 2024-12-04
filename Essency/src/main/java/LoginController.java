

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Essency.*;

import java.io.IOException;

@WebServlet("/loginControl")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	UserDAO userDAO;
    public LoginController() {
        super();
    }
    
    public void init(ServletConfig config) throws ServletException {
		super.init(config);
		userDAO = new UserDAO();
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 요청에서 데이터 가져오기
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            // DAO를 통해 사용자 정보 확인
            User user = userDAO.getUserByUsername(username);

            if (user != null && user.getPassword().equals(password)) {
                // 로그인 성공: 세션에 사용자 정보 저장
                HttpSession session = request.getSession();
                session.setAttribute("loggedInUser", user);
                response.sendRedirect("/Essency/webservice/index.jsp"); // 성공 시 환영 페이지로 이동
            } else {
                // 로그인 실패: 에러 메시지와 함께 로그인 페이지로 포워드
                request.setAttribute("errorMessage", "아이디 또는 비밀번호가 잘못되었습니다.");
                request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "아이디 또는 비밀번호가 잘못되었습니다. 다시 로그인해주세요.");
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
        }
    
	}

}
