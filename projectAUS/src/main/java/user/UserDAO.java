package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.SQLException;




public class UserDAO {

	Connection con = null;
	PreparedStatement pstmt =null;
	ResultSet rs = null;
	
	String sql="";
	
	private Connection getConnection() throws Exception{
		
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/projectforaus");
		
		con = ds.getConnection();
		return con;
	}
	
	public void closeDB(){
		try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(con != null) con.close();
			System.out.println("�ڿ����� ����");
		} catch (SQLException e) {
			System.out.println("�ڿ����� ����");
			e.printStackTrace();
		}
	}
	
	public int userCheck(String userEMAIL, String userPWD){
		int check = 1; // 1:�̸��� ��ġ,��й�ȣ ��ġ 
		                // 0:�̸��� ��ġ,��й�ȣ ����ġ
		                //-1:�̸��� ����ġ
		
		try {
			con = getConnection();
			
			sql= "select * from user where userEMAIL =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userEMAIL);
			rs = pstmt.executeQuery();
			
			System.out.println("rs.next(): " + rs.next());
			System.out.println("userEMAIL : " + userEMAIL);
			
			if(rs.next()){
				if(userPWD.equals(rs.getString("userPWD"))){
					check = 1; //���̵� ��ġ, ��й�ȣ ��ġ
				} else{
					check = 0; //���̵� ��ġ, ��й�ȣ ����ġ
				}
			}else{
				check = -1;
			}
			
			
		} catch (Exception e) {			
			e.printStackTrace();
		}finally{
			try {
				//�ڿ�����
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return check;		
		
	}
	
	public int userEMAILCheck(String userEMAIL){
		int check = 0;
		
		try {
			con = getConnection();
			sql = "select userEMAIL from user where userEMAIL= ?";
			pstmt = con.prepareStatement(sql);			
			pstmt.setString(1, userEMAIL);			
			rs = pstmt.executeQuery();			
			
			if(rs.next()){
				check = 1;				
			}else{
				check = 0;				
			}
			
		} catch (Exception e) {
		
		} finally{
			
			closeDB();
		}			
		
		
		return check;
	}//idCheck()�޼ҵ��� ��
	
	
	

	
	
public void insertUser(UserBean userBean){
		
		try {
			con = getConnection();
			sql = "insert into user (userEMAIL,userPWD,userNAME,userPOSTCODE,userADDRESS,userCPNUM)"
					+ " values(?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
					
	
			pstmt.setString(1, userBean.getUserEMAIL());
			pstmt.setString(2, userBean.getUserPWD());				
			pstmt.setString(3, userBean.getUserNAME());
			pstmt.setString(4, userBean.getUserPOSTCODE());
			pstmt.setString(5, userBean.getUserADDRESS());
			pstmt.setString(6, userBean.getUserCPNUM());			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}finally{
			
			closeDB();
		}			
}//��
	
	 public UserBean getUser(String userEMAIL){
		UserBean userBean = new UserBean();
		 
		 try {
			con = getConnection();
			sql = "select * from user where userEMAIL = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userEMAIL);
			rs = pstmt.executeQuery();
			if(rs.next()){
				userBean.setUserEMAIL(rs.getString("userEMAIL"));
				userBean.setUserPWD(rs.getString("userPWD"));
				userBean.setUserNAME(rs.getString("userNAME"));
				userBean.setUserPOSTCODE(rs.getString("userPOSTCODE"));
				userBean.setUserADDRESS(rs.getString("userADDRESS"));
				userBean.setUserCPNUM(rs.getString("userCPNUM"));
			}			
			
		} catch (Exception e) {
			
		}finally {
			closeDB();
		}		 
		 return userBean;
	 }//getMember()�޼ҵ��� ��
	
	 public void updateUser(UserBean userBean){
		 	int check =0;
		 
			try {				
				con = getConnection();		
				sql="select userPWD from user where userEMAIL=?";				
				pstmt=con.prepareStatement(sql);				
				pstmt.setString(1, userBean.getUserEMAIL());				
				rs= pstmt.executeQuery();				
				
				if(rs.next()){					
					if(userBean.getUserPWD().equals(rs.getString("userPWD"))){
						
						check =1;						
						sql = "update user set userPWD=?,userNAME=?,userPOSTCODE=?,userADDRESS=?,userCPNUM=? where userEMAIL=?";								
						
						pstmt = con.prepareStatement(sql);						
						
						pstmt.setString(1, userBean.getUserPWD());				
						pstmt.setString(2, userBean.getUserNAME());
						pstmt.setString(3, userBean.getUserPOSTCODE());
						pstmt.setString(4, userBean.getUserADDRESS());
						pstmt.setString(5, userBean.getUserCPNUM());
						pstmt.setString(6, userBean.getUserEMAIL());
						pstmt.executeUpdate();
						
					}else{
						check=0;
					}
				}
			} catch (Exception e) {		
				e.printStackTrace();
			}finally{				
				closeDB();
			}	
		}
	 
}


