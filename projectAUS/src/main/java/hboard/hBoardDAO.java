package hboard;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class hBoardDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public hBoardDAO() {
		try {
			String DBURL ="jdbc:mysql://localhost:3306/projectforaus";
			String DBID = "projectYou";
			String DBPWD = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DBURL,DBID,DBPWD);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		String sql ="select now()";
		try{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //DB 오류
	
	}
	
	public int getNext() {
		String sql ="select boardIDX from hboard order by boardIDX desc";
		try{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //첫 번째 게시물일 때
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //DB 오류
	
	}
	public int write(String boardTitle, String userID, String boardContent){
		String sql ="insert into hboard values(?,?,?,?,?,?)";
		try{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, boardTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, boardContent);
			pstmt.setInt(6, 1);
			pstmt.executeUpdate();
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //DB 오류
	}

	public ArrayList<hBoardBean> getList(int pageNumber){
		String sql ="select * from hboard where boardIDX < ? and boardAvailable = 1 order by boardIDX desc limit 10";
		ArrayList<hBoardBean> list = new ArrayList<hBoardBean>();
		try{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				hBoardBean hboard = new  hBoardBean();
				hboard.setBoardIDX(rs.getInt(1));
				hboard.setBoardTitle(rs.getString(2));
				hboard.setUserID(rs.getString(3));
				hboard.setBoardDate(rs.getString(4));
				hboard.setBoardContent(rs.getString(5));
				hboard.setBoardAvailable(rs.getInt(6));
				
				list.add(hboard);			
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	
	}
	
	public boolean nextPage(int pageNumber){
		String sql ="select * from hboard where boardIDX < ? and boardAvailable = 1";
		try{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				 return true;				
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	
	}
	
	public hBoardBean getBoard(int boardIDX){
		String sql = "select * from hboard where boardIDX =?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardIDX);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				hBoardBean hboard = new  hBoardBean();
				hboard.setBoardIDX(rs.getInt(1));
				hboard.setBoardTitle(rs.getString(2));
				hboard.setUserID(rs.getString(3));
				hboard.setBoardDate(rs.getString(4));
				hboard.setBoardContent(rs.getString(5));
				hboard.setBoardAvailable(rs.getInt(6));
				
				return hboard;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
			
			}
		
	public int update(int boardIDX, String boardTitle, String boardContent) {
		String sql= "update hboard set boardTitle = ?, boardContent =? where boardIDX =?"; 
		try{
			PreparedStatement pstmt = conn.prepareStatement(sql);
		
			pstmt.setString(1, boardTitle);
			pstmt.setString(2, boardContent);
			pstmt.setInt(3, boardIDX);
			return pstmt.executeUpdate(); 
		}catch (Exception e){
			e.printStackTrace();
		}
		return -1; //DB 오류
	}
	
	public int delete(int boardIDX){
		String sql= "update hboard set boardAvailable = 0 where boardIDX =?"; 
		try{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardIDX);
			return pstmt.executeUpdate(); 
		}catch (Exception e){
			e.printStackTrace();
		}
		return -1; //DB 오류
	}
}



