import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class CommentDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;

	final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	final String JDBC_URL = "jdbc:mysql://localhost:3306/team_project";

	public void open() {
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(JDBC_URL, "root", "root");
		} catch (SQLException e) {
			System.out.println("Database connection failed!");
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			System.out.println("JDBC Driver not found!");
			e.printStackTrace();
		}
	}

	public void close() {
		try {
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
