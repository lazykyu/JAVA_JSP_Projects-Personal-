package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.JdbcUtil;

public class FileBoardDAO {
	
	// 게시물 등록 작업 수행을 위한 insertFileBoard() 메서드 정의
	// => 파라미터 : FileBoardDTO 객체(fileBoard), 리턴타입 : int(insertCount)
	public int insertFileBoard(FileBoardDTO fileBoard) {
		int insertCount = 0;
		
		PreparedStatement pstmt = null, pstmt2 = null;
		ResultSet rs = null;
		
		// 1단계 & 2단계
		Connection con = JdbcUtil.getConnection();

		try {
			// --------------------------------------------------------------------------------------
			// 새 글 작성 시 부여할 새 글의 번호 계산
			int idx = 1; // 기본값으로 새 글 번호를 1번으로 지정
			
			// 3단계
			// 기존 게시물에서 가장 큰 번호(idx)를 조회하여 있을 경우 조회결과 + 1 값이 새 글 번호
			String sql = "SELECT MAX(idx) FROM file_board";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				idx = rs.getInt(1) + 1; // 조회된 최대값 + 1
			}
			// --------------------------------------------------------------------------------------
			// 전달받은 게시물 정보(새 글) file_board 테이블에 추가
			// => 새 글 번호는 위에서 생성한 idx 변수값 활용(? 파라미터 추가 필요)
			sql = "INSERT INTO file_board VALUES (?,?,?,?,?,?,?,now(),0)";
			pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, idx);
			pstmt2.setString(2, fileBoard.getName());
			pstmt2.setString(3, fileBoard.getPass());
			pstmt2.setString(4, fileBoard.getSubject());
			pstmt2.setString(5, fileBoard.getContent());
			pstmt2.setString(6, fileBoard.getRealFile()); // real_file
			pstmt2.setString(7, fileBoard.getOriginalFile()); // original_file
			
			insertCount = pstmt2.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 발생! - " + e.getMessage());
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(pstmt2);
			JdbcUtil.close(con);
		}
		
		return insertCount;
	}
	
	// 전체 게시물 수 조회를 수행하는 selectListCount() 메서드 정의
	// => 파라미터 : 없음, 리턴타입 : int(listCount)
	public int selectListCount() {
		int listCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Connection con = JdbcUtil.getConnection();
		
		try {
			// 3단계
			String sql = "SELECT COUNT(*) FROM file_board";
			pstmt = con.prepareStatement(sql);
			
			// 4단계
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 발생! - " + e.getMessage());
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return listCount;
	}
	
	// 전체 게시물 수 조회를 수행하는 selectListCount() 메서드 정의
	// => 단, 메서드 오버로딩을 통해 동일한 이름으로 검색어를 포함하는 메서드 호출 
	// => 파라미터 : 검색어, 리턴타입 : int(listCount)
	public int selectListCount(String keyword) {
		int listCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Connection con = JdbcUtil.getConnection();
		
		try {
			// 3단계
			String sql = "SELECT COUNT(*) FROM file_board WHERE subject LIKE ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword + "%");
			
			// 4단계
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 발생! - " + e.getMessage());
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return listCount;
	}
	
	// 게시물 목록을 조회하는 selectFileBoardList() 메서드 정의
	// => 파라미터 : 현재 페이지 번호, 페이지 당 게시물 수
	// => 리턴타입 : List(ArrayList 객체)
	public List selectFileBoardList(int pageNum, int listLimit) {
		List fileBoardList = null;
		
		// 현재 페이지 번호를 활용하여 조회 시 시작행 번호 계산
		int startRow = (pageNum - 1) * listLimit;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Connection con = JdbcUtil.getConnection();
		
		try {
			String sql = "SELECT * FROM file_board ORDER BY idx DESC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, listLimit);
			
			rs = pstmt.executeQuery();
			
			// 전체 게시물 목록을 저장할 List(ArrayList) 객체 생성
			fileBoardList = new ArrayList(); // ArrayList -> List 업캐스팅
			
			while(rs.next()) {
				// 1개 게시물(레코드)을 저장할 BoardDTO 객체 생성
				FileBoardDTO fileBoard = new FileBoardDTO();
				fileBoard.setIdx(rs.getInt("idx"));
				fileBoard.setName(rs.getString("name"));
				fileBoard.setPass(rs.getString("pass"));
				fileBoard.setSubject(rs.getString("subject"));
				fileBoard.setContent(rs.getString("content"));
				fileBoard.setRealFile(rs.getString("real_file"));
				fileBoard.setOriginalFile(rs.getString("original_file"));
				fileBoard.setDate(rs.getDate("date"));
				fileBoard.setReadcount(rs.getInt("readcount"));
				
				// 1개 게시물을 다시 전체 게시물 저장 객체(boardList)에 추가
				fileBoardList.add(fileBoard);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 발생! - selectBoardList() : " + e.getMessage());
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return fileBoardList;
	}
	
	// 게시물 목록을 조회하는 selectFileBoardList() 메서드 정의
	// => 단, 메서드 오버로딩을 통해 동일한 이름으로 검색어를 포함하는 메서드 호출 
	// => 파라미터 : 검색어, 현재 페이지 번호, 페이지 당 게시물 수
	// => 리턴타입 : List(ArrayList 객체)
	public List selectFileBoardList(String keyword, int pageNum, int listLimit) {
		List fileBoardList = null;
		
		// 현재 페이지 번호를 활용하여 조회 시 시작행 번호 계산
		int startRow = (pageNum - 1) * listLimit;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Connection con = JdbcUtil.getConnection();
		
		try {
			// WHERE 절에서 검색에 사용할 LIKE XXX 형식의 구문을 지정하기 위해
			// LIKE 뒤에 검색어를 만능문자(?)로 지정
			// => 주의! SQL 문장 작성 시 %?% 형태로 작성하지 않고 setXXX() 메서드로 결합 시 % 결합
			String sql = "SELECT * FROM file_board WHERE subject LIKE ? ORDER BY idx DESC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword + "%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, listLimit);
			
			rs = pstmt.executeQuery();
			
			// 전체 게시물 목록을 저장할 List(ArrayList) 객체 생성
			fileBoardList = new ArrayList(); // ArrayList -> List 업캐스팅
			
			while(rs.next()) {
				// 1개 게시물(레코드)을 저장할 BoardDTO 객체 생성
				FileBoardDTO fileBoard = new FileBoardDTO();
				fileBoard.setIdx(rs.getInt("idx"));
				fileBoard.setName(rs.getString("name"));
				fileBoard.setPass(rs.getString("pass"));
				fileBoard.setSubject(rs.getString("subject"));
				fileBoard.setContent(rs.getString("content"));
				fileBoard.setRealFile(rs.getString("real_file"));
				fileBoard.setOriginalFile(rs.getString("original_file"));
				fileBoard.setDate(rs.getDate("date"));
				fileBoard.setReadcount(rs.getInt("readcount"));
				
				// 1개 게시물을 다시 전체 게시물 저장 객체(boardList)에 추가
				fileBoardList.add(fileBoard);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 발생! - selectBoardList() : " + e.getMessage());
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return fileBoardList;
	}
	
	// 게시물 조회수 증가를 수행하는 updateReadcount() 메서드 정의
	// => 파라미터 : 글번호(idx), 리턴타입 : void
	public void updateReadcount(int idx) {
		PreparedStatement pstmt = null;
		
		Connection con = JdbcUtil.getConnection();
		
		try {
			String sql = "UPDATE file_board SET readcount=readcount+1 WHERE idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - updateReadcount() : " + e.getMessage());
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
	}
		
	// 게시물 1개 정보 조회를 수행하는 selectFileBoard() 메서드 정의
	// => 파라미터 : 글번호(idx), 리턴타입 : FileBoardDTO(fileBoard)	
	public FileBoardDTO selectFileBoard(int idx) {
		FileBoardDTO fileBoard = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Connection con = JdbcUtil.getConnection();
		
		try {
			String sql = "SELECT * FROM file_board WHERE idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				// 1개 게시물(레코드)을 저장할 FileBoardDTO 객체 생성
				fileBoard = new FileBoardDTO();
				fileBoard.setIdx(rs.getInt("idx"));
				fileBoard.setName(rs.getString("name"));
				fileBoard.setPass(rs.getString("pass"));
				fileBoard.setSubject(rs.getString("subject"));
				fileBoard.setContent(rs.getString("content"));
				fileBoard.setRealFile(rs.getString("real_file"));
				fileBoard.setOriginalFile(rs.getString("original_file"));
				fileBoard.setDate(rs.getDate("date"));
				fileBoard.setReadcount(rs.getInt("readcount"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 발생! - selectFileBoard() : " + e.getMessage());
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return fileBoard;
	}
	
	// 작성자가 입력한 패스워드 확인
	// => board 테이블의 idx 가 일치하는 게시물의 패스워드를 비교
	// => 파라미터 : BoardDTO 객체, 리턴타입 : boolean(isCorrectPass)
	public boolean checkPass(BoardDTO board) {
		boolean isCorrectPass = false;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Connection con = JdbcUtil.getConnection();
		
		try {
			// idx 와 pass 가 모두 일치하는 레코드 검색
			String sql = "SELECT * FROM board WHERE idx=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board.getIdx());
			pstmt.setString(2, board.getPass());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 게시물 조회 성공(번호와 패스워드 일치)
				isCorrectPass = true; // 성공 표시
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - checkPass() : " + e.getMessage());
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return isCorrectPass;
	}
	
	// 글 수정 작업 수행하는 updateBoard() 메서드 정의
	// => 파라미터 : BoardDTO 객체, 리턴타입 : int(updateCount)
	public int updateBoard(BoardDTO board) {
		int updateCount = 0;
		
		PreparedStatement pstmt = null;
		
		Connection con = JdbcUtil.getConnection();
		
		try {
			// 글번호에 해당하는 게시물을 찾아 이름, 제목, 내용 수정
			String sql = "UPDATE board SET name=?,subject=?,content=? WHERE idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board.getName());
			pstmt.setString(2, board.getSubject());
			pstmt.setString(3, board.getContent());
			pstmt.setInt(4, board.getIdx());
			
			updateCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - updateBoard() : " + e.getMessage());
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return updateCount;
	}
	
	// 게시물 삭제 작업 수행하는 deleteBoard() 메서드 정의
	// => 파라미터 : BoardDTO 객체, 리턴타입 : int(deleteCount)
	public int deleteBoard(BoardDTO board) {
		int deleteCount = 0;
		
		PreparedStatement pstmt = null;
		
		Connection con = JdbcUtil.getConnection();
		
		try {
			// 글번호에 해당하는 게시물을 찾아 삭제
			String sql = "DELETE FROM board WHERE idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board.getIdx());
			
			deleteCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 - deleteBoard() : " + e.getMessage());
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return deleteCount;
	}
	
	// 최근 게시물 5개 조회
	// => 파라미터 : 없음, 리턴타입 : List(recentNoticeList)
	public List selectRecentNoticeList() {
		List boardList = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		Connection con = JdbcUtil.getConnection();
		
		try {
			// idx 기준 내림차순 정렬 후 5개만 조회
			String sql = "SELECT * FROM board ORDER BY idx DESC LIMIT 5";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			// 전체 게시물 목록을 저장할 List(ArrayList) 객체 생성
			boardList = new ArrayList(); // ArrayList -> List 업캐스팅
			
			while(rs.next()) {
				// 1개 게시물(레코드)을 저장할 BoardDTO 객체 생성
				BoardDTO board = new BoardDTO();
				board.setIdx(rs.getInt("idx"));
				board.setName(rs.getString("name"));
				board.setPass(rs.getString("pass"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setDate(rs.getDate("date"));
				board.setReadcount(rs.getInt("readcount"));
				
				// 1개 게시물을 다시 전체 게시물 저장 객체(boardList)에 추가
				boardList.add(board);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("SQL 구문 오류 발생! - selectRecentNoticeList() : " + e.getMessage());
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return boardList;
	}
	
}

























