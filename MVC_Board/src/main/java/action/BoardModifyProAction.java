package action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.BoardModifyProService;
import vo.ActionForward;
import vo.BoardDTO;

public class BoardModifyProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("BoardModifyProAction");
		
		ActionForward forward = null;
		
		// 파라미터 가져와서 변수에 저장
		BoardDTO board = new BoardDTO();
		board.setBoard_num(Integer.parseInt(request.getParameter("board_num")));
		board.setBoard_name(request.getParameter("board_name"));
		board.setBoard_pass(request.getParameter("board_pass"));
		board.setBoard_subject(request.getParameter("board_subject"));
		board.setBoard_content(request.getParameter("board_content"));
//		System.out.println(board);
		
		// 게시물 수정 권한 판별을 위해 전달받은 파라미터 중 패스워드 비교
		// => BoardModifyProService 의 isBoardWriter() 메서드를 호출
		//    파라미터 : 글번호, 패스워드    리턴타입 : boolean(isBoardWriter)
		// => 작업 내용은 BoardDeleteProService 의 isBoardWriter() 와 동일
		BoardModifyProService service = new BoardModifyProService();
		boolean isBoardWriter = service.isBoardWriter(board.getBoard_num(), board.getBoard_pass());
		
		// 수정 가능 여부 판별(isBoardWriter 변수값 판별)
		// => 패스워드가 일치하지 않았을 경우(= isBoardWriter 가 false)
		//    자바스크립트를 사용하여 "수정 권한 없음" 출력 후 이전페이지로 돌아가기
		// => 아니면, "수정 권한 있음" 출력
		if(!isBoardWriter) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('수정 권한 없음!')");
			out.println("history.back()");
			out.println("</script>");
		} else { // 패스워드가 일치할 경우
			// BoardModifyProService 의 modifyBoard() 메서드 호출하여 글수정 작업 요청
			// => 파라미터 : BoardDTO 객체    리턴타입 : boolean(isModifySuccess)
			boolean isModifySuccess = service.modifyBoard(board);
			
			// 글 수정 작업 결과 판별
			// 실패 시 자바스크립트를 사용하여 "글 수정 실패!" 출력 후 이전페이지로 돌아가기
			// 성공 시 ActionForward 객체 생성하여 BoardDetail.bo 페이지 요청
			// => 파라미터 : 글번호, 페이지번호
			if(!isModifySuccess) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('글 수정 실패!')");
				out.println("history.back()");
				out.println("</script>");
			} else {
				forward = new ActionForward();
				forward.setPath("BoardDetail.bo?board_num=" + board.getBoard_num() + "&pageNum=" + request.getParameter("pageNum"));
				forward.setRedirect(true);
			}
		}
		
		return forward;
	}

}













