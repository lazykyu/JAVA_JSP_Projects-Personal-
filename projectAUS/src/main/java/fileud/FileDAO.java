package fileud;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Connection;

public class FileDAO {
	
	private Connection con;
	
	public FileDAO() {
		try {
			String DBURL = "jdbc:mysql://localhost:3306/projectforaus";
			String DBID = "projectYou";
			String DBPWD = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(DBURL,DBID,DBPWD);
		}catch (Exception e) {
			e.printStackTrace();
		}
	

	}
	
	public int upload(String fileName, String fileRealName){
		String sql = "insert into fileupdown values (?,?)";
		try{
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, fileName);
			pstmt.setString(2, fileRealName);
			return pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;//(오류 메세지)
	}
	
}