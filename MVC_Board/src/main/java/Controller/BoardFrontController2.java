package Controller;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vo.*;

// 서블릿 주소가 xxx.bo 로 끝날 경우 BoardController 클래스로 해당 요청이 전달됨
@WebServlet("*.do")
public class BoardFrontController2 extends HttpServlet {
		// GET방식 or POST 방식에 따른 처리를 별도로 구분하지 않고 공통으로 처리하기 위해
		// doProcess() 메서드를 정의하고 doGet(),doPost() 메서드에서 호출
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doProcess호출 ");
		
		// POST 방식 요청에 대한 한글 처리
		request.setCharacterEncoding("utf-8");
		
		//서블릿 주소 추출
		String command = request.getServletPath();
		System.out.println(command);
		
		ActionForward forward = null;
		
		//추출된 서블릿 주소를 if문을 사용하여 판별하고 각 주소에 따른 액션(작업) 요청
		// ex) "/BoardWriteForm.bo" 일 경우 board 폴더 내의 qna_board_write.jsp 페이지로 이동
		if(command.equals("/BoardWriteForm.do")) {
			System.out.println("완료");
//			response.sendRedirect("qna_board_write.jsp");
			// 글쓰기 폼 표시를 위한 View 페이지 (*.jsp) 로 포워딩
			// 별도의 비즈니스 로직(=DB 작업)이 없이 뷰페이지로 바로 연결
			// => 이때 , JSP 페이지의 url 
//			RequestDispatcher dispatcher = request.getRequestDispatcher("board/qna_board_write.jsp");
//			dispatcher.forward(request, response);
			
			
			forward.setPath("board/qna_board_write.jsp");
			forward.setRedirect(false); 
	
		}else if(command.equals("/BoardWritePro.do")) {
			System.out.println("글쓰기 로직!");
//			RequestDispatcher dispatcher = request.getRequestDispatcher("board/qna_board_list.jsp");
//			dispatcher.forward(request, response);
			
		
			forward.setPath("BoardList.do");
			forward.setRedirect(true); 
		
		}else if(command.equals("/BoardListo.do")) {
			forward.setPath("board/qna_board_list.jsp");
			forward.setRedirect(false);
			
		}
		
		if(forward!=null) {
			
			if(forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			}else {
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}
		
			
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet 감지");
		doProcess(request, response);
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost 감지");
		doProcess(request, response);
	}

}
