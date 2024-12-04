
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Essency.*;

@WebServlet("/verifyPasswordControl")
public class VerifyPasswordController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO;

	public VerifyPasswordController() {
		super();
	}

	public void init() throws ServletException {
		userDAO = new UserDAO();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 세션에서 사용자명 가져오기
		HttpSession session = request.getSession();
		User loggedInUser = (User) session.getAttribute("loggedInUser");
		String username = loggedInUser.getUsername();
		String inputPassword = request.getParameter("password");
		if (username == null || inputPassword == null || inputPassword.isEmpty()) {
			request.setAttribute("error", "비밀번호를 입력해주세요.");
			request.getRequestDispatcher("/Essency/jsp/verifyPassword.jsp").forward(request, response);
			return;
		}

		try {
			// 데이터베이스에서 사용자 정보 가져오기
			User user = userDAO.getUserByUsername(username);

			if (user != null && user.getPassword().equals(inputPassword)) {
				// 비밀번호 일치: 세션에 인증 플래그 설정
				session.setAttribute("verified", true);
				response.sendRedirect("/Essency/jsp/editProfile.jsp"); // 개인정보 수정 페이지로 이동
			} else {
				// 비밀번호 불일치 또는 사용자 없음
				request.setAttribute("error", "비밀번호가 일치하지 않습니다.");
				request.getRequestDispatcher("/jsp/verifyPassword.jsp").forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
			request.getRequestDispatcher("/jsp/verifyPassword.jsp").forward(request, response);
		}
	}

}
