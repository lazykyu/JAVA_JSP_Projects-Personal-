package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql ="";
	
 private Connection getConnection() throws Exception{
	
	Context init = new InitialContext();
	DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/projectforaus");
	
	con = ds.getConnection();
	return con;
 }//getConnection()메소드 끝
 
 public void closeDB(){
	 try {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(con != null) con.close();
			System.out.println("자원해제 성공");
		} catch (SQLException e) {
			System.out.println("자원해제 실패");
			e.printStackTrace();
		}
 }//closeDB()메소드 끝
 
 public List<BoardBean> getBoardList(int startRow,int pageSize){
	List<BoardBean> boardList = new ArrayList<BoardBean>();
	
	try {
		con = getConnection();
		
		sql =  "select * from board order by re_ref desc,re_seq asc limit ?,?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, startRow);
		pstmt.setInt(2, pageSize);
		rs =pstmt.executeQuery();
		
		while(rs.next()){
			BoardBean bBean = new BoardBean();
			bBean.setNum(rs.getInt("num"));
			bBean.setId(rs.getString("id"));
			bBean.setPasswd(rs.getString("passwd"));
			bBean.setSubject(rs.getString("subject"));
			bBean.setImage(rs.getString("image"));
			bBean.setContent(rs.getString("content"));
			bBean.setFile(rs.getString("file"));
			bBean.setRe_ref(rs.getInt("re_ref"));
			bBean.setRe_lev(rs.getInt("re_lev"));
			bBean.setRe_seq(rs.getInt("re_seq"));
			bBean.setReadcount(rs.getInt("readcount"));
			bBean.setDate(rs.getTimestamp("date"));
			bBean.setIp(rs.getString("ip"));
			
			boardList.add(bBean);
			
		}
	} catch (Exception e) {
		System.out.println("getBoardList에서 에러 발생"+e);
	} finally {
		closeDB();
	}
	
	return boardList;
			
 }// getBoardList메소드 끝
 
 
 public int getBoardCount(){
	
	int count=0;
	
	try {
		con = getConnection();
		sql = "select count(*) from board";
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			count = rs.getInt(1);
		}
		
	} catch (Exception e) {
		System.out.println("getBoardCount메소드에서 에러 발생"+e);
	} finally {
		closeDB();
	}	
	return count;
 } //getBoardCount()메소드 끝

 public int insertBoard(BoardBean bBean){
	
	int check = 0;
	int num = 0;
	
	try {
		con = getConnection();
		
		sql = "select userPWD from user where userEMAIL=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, bBean.getId());
		rs = pstmt.executeQuery();
		
		if(rs.next()){	
			if(bBean.getPasswd().equals(rs.getString("passwd"))){
				
				check=1;
		
				//새글 추가시.. 글번호 구하기
				// -> board테이블에 저장되어 있는 가장 큰 글번호 얻기
				// -> 글이 없을 경우 : 글번호 1로 지정
				// -> 글이 있을 경우 : 최근 글번호(번호가 가장 큰 값)+1
				sql =" select max(num) from board";
				pstmt = con.prepareStatement(sql);
				rs=pstmt.executeQuery();
				
				if(rs.next()){
					num = rs.getInt(1) + 1;
				}else{
					num = 1;
				}		
				
				sql = "insert into board (num,id,passwd,image,subject,content,file,"
						+"re_ref,re_lev,re_seq,readcount,date,ip)"
						+" values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);//새 글 번호
				pstmt.setString(2, bBean.getId());//새글을 작성자
				pstmt.setString(3, bBean.getPasswd());//새글의 비밀번호
				pstmt.setString(4, bBean.getImage());//새글의 이미지
				pstmt.setString(5, bBean.getSubject());// 새글의 제목
				pstmt.setString(6, bBean.getContent());//새글의 글 내용
				pstmt.setString(7, bBean.getFile());//새글 데이터 중 업로드 파일명
				pstmt.setInt(8, num);//주글번호 기준 == re_ref 그룹번호
				pstmt.setInt(9, 0);//새글의 들여쓰기정도값 re_lev
				pstmt.setInt(10, 0);//글 순서 re_seq
				pstmt.setInt(11, 0);//글의 조회수
				pstmt.setTimestamp(12, bBean.getDate());
				pstmt.setString(13, bBean.getIp());
				
				pstmt.executeUpdate();
			} else{
				check = 0;
			}
		}	
	} catch (Exception e) {
		System.out.println("insertBoard메소드에서 오류 "+e);		
	}finally {
		closeDB();
	}return check;	
 }//insertBoard메소드 닫는 부분
 
//글번호를 매개변수로 전달받아 글번호에 해당되는 글의 조회수를 1 증가 시키는 메소드
 public void updateReadCount(int num){//content.jsp에서 호출되는 메소드
	
	 try {
		con = getConnection();
		sql = "update board set readcount = readcount+1 where num=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, num);
		pstmt.executeUpdate();
		
	} catch (Exception e) {
		System.out.println("updateReadCount메소드에서 에러 발생"+e);
	} finally {
		closeDB();
	}
	
	
 }//updateReadCount메소드 끝

 public BoardBean getBoard(int num){ //content.jsp에서 호출한 메소드
	 BoardBean bBean = null;
	 
	 try {
		con = getConnection();
		sql="select * from board where num = ?";
		pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, num);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			bBean = new BoardBean();
			
			bBean.setNum(rs.getInt("num"));
			bBean.setId(rs.getString("id"));
			bBean.setPasswd(rs.getString("passwd"));
			bBean.setImage(rs.getString("image"));
			bBean.setSubject(rs.getString("subject"));
			bBean.setContent(rs.getString("content"));
			bBean.setFile(rs.getString("file"));
			bBean.setRe_ref(rs.getInt("re_ref"));
			bBean.setRe_lev(rs.getInt("re_lev"));
			bBean.setRe_seq(rs.getInt("re_seq"));
			bBean.setReadcount(rs.getInt("readcount"));
			bBean.setDate(rs.getTimestamp("date"));
			bBean.setIp(rs.getString("ip"));
		}
	} catch (Exception e) {
		System.out.println("getBoard()메소드에서 에러 발생"+e);
	} finally {
		closeDB();
	}
	 
	 return bBean;
 }
 
 public int updateBoard(BoardBean bBean){
	 int check = 0;
	 try {		
		con = getConnection();
		sql = "select passwd, id from board where num=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, bBean.getNum());
		rs = pstmt.executeQuery();
		
		if(rs.next()){			
			if(bBean.getPasswd().equals(rs.getString("passwd"))){
					check=-1;
				
				if(bBean.getId().equals(rs.getString("id"))){
					
					check = 1;
					sql = "update board set id = ?, image=?, subject = ?, content =? where num = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, bBean.getId());
					pstmt.setString(2, bBean.getImage());				
					pstmt.setString(3, bBean.getSubject());
					pstmt.setString(4, bBean.getContent());
					pstmt.setInt(5, bBean.getNum());
					pstmt.executeUpdate();		
				}
			}else{
				check = 0;				
			}
		}		
	} catch (Exception e) {
		System.out.println("updateBoard()메소드에서 에러 발생"+e);
	} finally {
		closeDB();
	}
	 return check;
	
 }
 
 /*
  	답변 달기 변수 설명
  	re_ref -> 부모글과 그로부터 파생된 자식(답변)글들이  같은 값을 가지기 위한 변수의 값
  	re_seq -> 같은 그룹 글들 내에서의 순서
  	re_lev ->같은 그룹내에서의 깊이(들여쓰기 정도 레벨)
  	
  	답변 달기 규칙 설명
  	1. re_ref값은 부모글(주글)의 그룹번호(re_ref)를 사용해야 한다.
  	2. re_seq값은 부모글의 re_seq에서 +1 증가한 값을 사용해야 한다.
  	3. re_lev 값은 re_lev에서 +1 증가한 값을 사용해야 한다.
  */
 //답변글 추가 메소드
 public int reInsertBoard(BoardBean bBean){
	 int num = 0;
	 int check = 0;
	 
	 try {
		con = getConnection();
		sql = "select passwd from board where num=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, bBean.getNum());
		rs = pstmt.executeQuery();
		
		if(rs.next()){			
			if(bBean.getPasswd().equals(rs.getString("passwd"))){
		
				check=1;
		
				sql = "select max(num) from board";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					num = rs.getInt(1) + 1; 
				}else{
					num = 1;
				}
				//re_seq 답글순서 재배치
				//부모글 그룹과 같은 그룹이면서..부모글의 seq값보다 큰 답변글들은
				//seq값을 1증가시킨다.
				sql ="update board set re_seq = re_seq+1 where re_ref=? and re_seq > ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, bBean.getRe_ref());//부모글의 그룹번호
				pstmt.setInt(2, bBean.getRe_seq());//부모글의 글 입력 순서
				pstmt.executeUpdate();
				
				//답변글 달기
				//insert
				sql = "insert into board (num,id,passwd,image,subject,content,file,"
						+"re_ref,re_lev,re_seq,readcount,date,ip)"
						+" values(?,?,?,?,?,?,?,?,?,?,?,now(),?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);//추가할 새 글 번호
				pstmt.setString(2, bBean.getId());//새글을 추가한 작성자의 이름
				pstmt.setString(3, bBean.getPasswd());//추가할 새글의 비밀번호
				pstmt.setString(4, bBean.getImage());//추가할 새글의 비밀번호
				pstmt.setString(5, bBean.getSubject());//추가할 새글의 글 제목
				pstmt.setString(6, bBean.getContent());//추가할 새글의 글 내용
				pstmt.setString(7, bBean.getFile());//추가할 새글 데이터 중 업롤드할 파일명
				pstmt.setInt(8, bBean.getRe_ref());//부모글 그룹번호 re_ref값을 사용한다.
				pstmt.setInt(9, bBean.getRe_lev()+1);//부모글의 re_lev에 +1을 하여 들여쓰기 값을 사용한다.
				pstmt.setInt(10, bBean.getRe_seq()+1);//글 순서 re_seq
				pstmt.setInt(11, 0);//답변글의 조회수		
				pstmt.setString(12, bBean.getIp());//답변글을 작성하는 사람의 IP주소
				pstmt.executeUpdate();
			}else{
				check = 0;
			}
			
		}	
		
	} catch (Exception e) {
		System.out.println("reInsertBoard()메소드에서 에러 발생"+e);
		e.printStackTrace();
	}finally {
		closeDB();
	}return check;
 }//reInsertBoard()메소드의 끝
 
 public int deleteBoard(int num, String passwd){
	 int check = 0 ;
	
	 try {
		con =getConnection();
		sql = "select passwd from board where num=?";		
		pstmt = con.prepareStatement(sql);		
		pstmt.setInt(1, num);		
		rs = pstmt.executeQuery();			
		if(rs.next()){			
			if(passwd.equals(rs.getString("passwd"))){				
				check = 1;
				sql ="delete from board where num=?";				
				pstmt = con.prepareStatement(sql);				
				pstmt.setInt(1,num);				
				pstmt.executeUpdate();				
			}else{
				System.out.println("비밀번호가 일치하지 않습니다.");
				check = 0;
			}
		}
	} catch (Exception e) {
		System.out.println("deleteBoard()메소드에서 에러 발생"+e);
	}finally {
		closeDB();
	}	 
	 return check;
 }
 
 
}
