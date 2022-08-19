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
 }//getConnection()�޼ҵ� ��
 
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
 }//closeDB()�޼ҵ� ��
 
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
		System.out.println("getBoardList���� ���� �߻�"+e);
	} finally {
		closeDB();
	}
	
	return boardList;
			
 }// getBoardList�޼ҵ� ��
 
 
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
		System.out.println("getBoardCount�޼ҵ忡�� ���� �߻�"+e);
	} finally {
		closeDB();
	}	
	return count;
 } //getBoardCount()�޼ҵ� ��

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
		
				//���� �߰���.. �۹�ȣ ���ϱ�
				// -> board���̺� ����Ǿ� �ִ� ���� ū �۹�ȣ ���
				// -> ���� ���� ��� : �۹�ȣ 1�� ����
				// -> ���� ���� ��� : �ֱ� �۹�ȣ(��ȣ�� ���� ū ��)+1
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
				pstmt.setInt(1, num);//�� �� ��ȣ
				pstmt.setString(2, bBean.getId());//������ �ۼ���
				pstmt.setString(3, bBean.getPasswd());//������ ��й�ȣ
				pstmt.setString(4, bBean.getImage());//������ �̹���
				pstmt.setString(5, bBean.getSubject());// ������ ����
				pstmt.setString(6, bBean.getContent());//������ �� ����
				pstmt.setString(7, bBean.getFile());//���� ������ �� ���ε� ���ϸ�
				pstmt.setInt(8, num);//�ֱ۹�ȣ ���� == re_ref �׷��ȣ
				pstmt.setInt(9, 0);//������ �鿩���������� re_lev
				pstmt.setInt(10, 0);//�� ���� re_seq
				pstmt.setInt(11, 0);//���� ��ȸ��
				pstmt.setTimestamp(12, bBean.getDate());
				pstmt.setString(13, bBean.getIp());
				
				pstmt.executeUpdate();
			} else{
				check = 0;
			}
		}	
	} catch (Exception e) {
		System.out.println("insertBoard�޼ҵ忡�� ���� "+e);		
	}finally {
		closeDB();
	}return check;	
 }//insertBoard�޼ҵ� �ݴ� �κ�
 
//�۹�ȣ�� �Ű������� ���޹޾� �۹�ȣ�� �ش�Ǵ� ���� ��ȸ���� 1 ���� ��Ű�� �޼ҵ�
 public void updateReadCount(int num){//content.jsp���� ȣ��Ǵ� �޼ҵ�
	
	 try {
		con = getConnection();
		sql = "update board set readcount = readcount+1 where num=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setInt(1, num);
		pstmt.executeUpdate();
		
	} catch (Exception e) {
		System.out.println("updateReadCount�޼ҵ忡�� ���� �߻�"+e);
	} finally {
		closeDB();
	}
	
	
 }//updateReadCount�޼ҵ� ��

 public BoardBean getBoard(int num){ //content.jsp���� ȣ���� �޼ҵ�
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
		System.out.println("getBoard()�޼ҵ忡�� ���� �߻�"+e);
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
		System.out.println("updateBoard()�޼ҵ忡�� ���� �߻�"+e);
	} finally {
		closeDB();
	}
	 return check;
	
 }
 
 /*
  	�亯 �ޱ� ���� ����
  	re_ref -> �θ�۰� �׷κ��� �Ļ��� �ڽ�(�亯)�۵���  ���� ���� ������ ���� ������ ��
  	re_seq -> ���� �׷� �۵� �������� ����
  	re_lev ->���� �׷쳻������ ����(�鿩���� ���� ����)
  	
  	�亯 �ޱ� ��Ģ ����
  	1. re_ref���� �θ��(�ֱ�)�� �׷��ȣ(re_ref)�� ����ؾ� �Ѵ�.
  	2. re_seq���� �θ���� re_seq���� +1 ������ ���� ����ؾ� �Ѵ�.
  	3. re_lev ���� re_lev���� +1 ������ ���� ����ؾ� �Ѵ�.
  */
 //�亯�� �߰� �޼ҵ�
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
				//re_seq ��ۼ��� ���ġ
				//�θ�� �׷�� ���� �׷��̸鼭..�θ���� seq������ ū �亯�۵���
				//seq���� 1������Ų��.
				sql ="update board set re_seq = re_seq+1 where re_ref=? and re_seq > ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, bBean.getRe_ref());//�θ���� �׷��ȣ
				pstmt.setInt(2, bBean.getRe_seq());//�θ���� �� �Է� ����
				pstmt.executeUpdate();
				
				//�亯�� �ޱ�
				//insert
				sql = "insert into board (num,id,passwd,image,subject,content,file,"
						+"re_ref,re_lev,re_seq,readcount,date,ip)"
						+" values(?,?,?,?,?,?,?,?,?,?,?,now(),?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);//�߰��� �� �� ��ȣ
				pstmt.setString(2, bBean.getId());//������ �߰��� �ۼ����� �̸�
				pstmt.setString(3, bBean.getPasswd());//�߰��� ������ ��й�ȣ
				pstmt.setString(4, bBean.getImage());//�߰��� ������ ��й�ȣ
				pstmt.setString(5, bBean.getSubject());//�߰��� ������ �� ����
				pstmt.setString(6, bBean.getContent());//�߰��� ������ �� ����
				pstmt.setString(7, bBean.getFile());//�߰��� ���� ������ �� ���ѵ��� ���ϸ�
				pstmt.setInt(8, bBean.getRe_ref());//�θ�� �׷��ȣ re_ref���� ����Ѵ�.
				pstmt.setInt(9, bBean.getRe_lev()+1);//�θ���� re_lev�� +1�� �Ͽ� �鿩���� ���� ����Ѵ�.
				pstmt.setInt(10, bBean.getRe_seq()+1);//�� ���� re_seq
				pstmt.setInt(11, 0);//�亯���� ��ȸ��		
				pstmt.setString(12, bBean.getIp());//�亯���� �ۼ��ϴ� ����� IP�ּ�
				pstmt.executeUpdate();
			}else{
				check = 0;
			}
			
		}	
		
	} catch (Exception e) {
		System.out.println("reInsertBoard()�޼ҵ忡�� ���� �߻�"+e);
		e.printStackTrace();
	}finally {
		closeDB();
	}return check;
 }//reInsertBoard()�޼ҵ��� ��
 
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
				System.out.println("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
				check = 0;
			}
		}
	} catch (Exception e) {
		System.out.println("deleteBoard()�޼ҵ忡�� ���� �߻�"+e);
	}finally {
		closeDB();
	}	 
	 return check;
 }
 
 
}
