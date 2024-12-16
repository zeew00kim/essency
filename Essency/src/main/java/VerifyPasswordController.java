
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
			User user = userDAO.getUserByUsername(username);

			if (user != null && user.getPassword().equals(inputPassword)) {
				session.setAttribute("verified", true);
				response.sendRedirect("/Essency/jsp/editProfile.jsp"); 
			} else {
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
