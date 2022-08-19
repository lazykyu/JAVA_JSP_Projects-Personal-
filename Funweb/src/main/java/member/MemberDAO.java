package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.JdbcUtil;

public class MemberDAO {
	// 회원가입 작업 수행하는 insert() 메서드 정의
	// => 파라미터 : MemberDTO 객체, 리턴타입 : int(insertCount)
	public int insert(MemberDTO member) {
		int insertCount = 0;
		
		PreparedStatement pstmt = null;
		
		// 1단계, 2단계
		Connection con = JdbcUtil.getConnection();
		
		try {
			// 3단계.
			String sql = "INSERT INTO member VALUES (?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPass());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getAddress());
			pstmt.setString(6, member.getPhone());
			pstmt.setString(7, member.getMobile());
			
			// 4단계.
			insertCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			// 3단계 또는 4단계 과정에서 예외(오류) 발생 시 실행할 코드를 기술하는 블럭
			System.out.println("SQL 구문 오류 발생! - " + e.getMessage());
			e.printStackTrace();
		} finally {
			// 자원 반환 코드를 기술하는 블럭
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return insertCount;
	}
	
	// 로그인 작업 수행하는 login() 메서드 정의
	// => 파라미터 : MemberDTO 객체, 리턴타입 : boolean(isLoginSuccess)
	public boolean login(MemberDTO member) {
		boolean isLoginSuccess = false;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 1단계&2단계
		Connection con = JdbcUtil.getConnection();
		
		try {
			// 3단계. SQL 구문 작성 및 전달
			// 로그인 판별 : 아이디와 패스워드가 일치하는 레코드 조회
			String sql = "SELECT * FROM member WHERE id=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPass());
			
			// 4단계. SQL 구문 실행 및 결과 처리
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// 로그인 성공(조회 결과가 있을 경우) isLoginSuccess 를 true 로 변경
				isLoginSuccess = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 발생! - " + e.getMessage());
		} finally {
			// 자원 반환
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return isLoginSuccess;
	}
	
	// 아이디 존재 여부 판별(중복 판별)을 수행하는 checkUser() 메서드 정의
	// => 파라미터 : 아이디(id), 리턴타입 : boolean(isDuplicate)
	public boolean checkUser(String id) {
		boolean isDuplicate = false;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 1단계&2단계
		Connection con = JdbcUtil.getConnection();
		
		try {
			// 3단계. SQL 구문 작성 및 전달
			// 중복 아이디 판별 : id 값이 일치하는 레코드 조회(전체 컬럼 또는 id 컬럼 상관없음)
			String sql = "SELECT id FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			// 4단계. SQL 구문 실행 및 결과 처리
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// 아이디 중복(레코드 조회 성공 시) isDuplicate 변수를 true 로 변경
				isDuplicate = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 발생! - " + e.getMessage());
		} finally {
			// 자원 반환
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return isDuplicate;
	}
	
}













