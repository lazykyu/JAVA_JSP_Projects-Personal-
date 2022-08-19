<%@page import="board.FileBoardDAO"%>
<%@page import="board.FileBoardDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

// String name = request.getParameter("name");
// String pass = request.getParameter("pass");
// String subject = request.getParameter("subject");
// String content = request.getParameter("content");
// String file = request.getParameter("file");
// out.println(name + ", " + pass + ", " + subject + ", " + content + ", " + file);
// => 주의! form 태그에서 enctype="multipart/form-data" 로 지정했을 경우
//    모든 파라미터는 request.getParameter() 메서드로 접근 불가능해진다! => null 값 전달됨

// 파일 업로드를 위한 정보를 처리하기 위해 MultipartRequest 객체 활용
// 1. 업로드 할 파일이 저장되는 이클립스 프로젝트 상의 폴더(경로)를 변수에 저장(= 가상의 폴더)
String uploadPath = "/upload"; // 루트(webapp)에 생성한 upload 폴더 지정

// 2. 업로드 할 파일이 저장되는 서버(톰캣) 상의 폴더(경로)를 변수에 저장(= 실제 폴더)
// 2-1. 현재 프로젝트(서블릿)를 관리하는 객체를 서블릿 컨텍스트라고 하며
//      이 서블릿 컨텍스트를 객체 형태로 가져오기(request 객체의 getServletContext() 메서드 호출)
// ServletContext context = request.getServletContext();
// 2-2. ServletContext 객체로부터 가상 업로드 경로에 대한 실제 업로드 경로를 알아내기
//      => ServletContext 객체의 getRealPath() 메서드 호출(파라미터로 가상 업로드 경로 전달)
// String realPath = context.getRealPath(uploadPath);
// 위의 두 문장을 한 문장으로 결합할 경우
String realPath = request.getServletContext().getRealPath(uploadPath);
// D:\Shared\JSP\workspace_jsp2\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Funweb\ upload
// => 위의 폴더가 실제 이클립스 상의 톰캣 폴더에 생성된 진짜 업로드 폴더 경로이다!
// => 주의! 워크스페이스 내의 프로젝트 폴더에 존재하는 upload 폴더는 가상의 폴더이다!
// out.println(realPath);

// 3. 업로드 할 파일 크기를 정수 형태로 저장(바이트 단위)
// int fileSize = 10485760; // 만약, 10MB 가정 시 실제 크기를 직접 입력하는 경우(차후 용량 변경 불편)
// 파일 크기 등의 단위를 사용한 값 지정 시 기본 단위(파일의 경우 byte)부터 
// 계산 과정을 차례대로 활용 시, 차후 유지보수 시 편리함
int fileSize = 1024 * 1024 * 10; // byte(1) -> KB(1024 Byte) -> MB(1024 KB) -> 10MB 단위로 변환
// => 만약, 10MB 를 5MB 로 변경 시 * 10 을 * 5 로 변경하면 됨(10기가로 변경 시 * 1024 추가)

// 4. MultipartRequest 객체 생성
// => 생성자 파라미터로 파일 업로드에 필요한 각종 파라미터를 전달
//    (반드시 cos.jar 라이브러리를 등록(Build path 추가) 필수!)
MultipartRequest multi = new MultipartRequest(
	request, // 1) 실제 요청 정보가 포함된 request 객체
	realPath, // 2) 실제 업로드 폴더 경로
	fileSize, // 3) 업로드 파일 크기
	"UTF-8", // 4) 파일명에 대한 인코딩 방식(한글 처리 등이 필요하므로 UTF-8 지정)
	new DefaultFileRenamePolicy() // 5) 중복 파일명에 대한 처리를 담당하는 객체(파일명 뒤에 숫자 1 부터 차례대로 부여)
);
// => MultipartRequest 객체 생성 시점에서 업로드 파일에 대한 실제 업로드가 일어남

// 5. FileBoardDTO 객체를 생성하여 파라미터 데이터 저장
// => 주의! request 객체의 getParameter() 메서드가 아닌 MultipartRequest 객체의 getParameter() 사용
// out.println(multi.getParameter("name"));
FileBoardDTO fileBoard = new FileBoardDTO();
fileBoard.setName(multi.getParameter("name"));
fileBoard.setPass(multi.getParameter("pass"));
fileBoard.setSubject(multi.getParameter("subject"));
fileBoard.setContent(multi.getParameter("content"));
// 주의! 파일 정보를 가져올 때 getParameter() 메서드 사용 불가
fileBoard.setRealFile(multi.getFilesystemName("file")); // 실제 파일명(중복 파일 있을 경우 달라짐)
fileBoard.setOriginalFile(multi.getOriginalFileName("file")); // 원본 파일명
// out.println(fileBoard.getName() + ", " + fileBoard.getPass() + ", " + fileBoard.getSubject() + ", " + fileBoard.getContent());
// out.println(fileBoard.getRealFile() + ", " + fileBoard.getOriginalFile());

// FileBoardDAO 객체의 insertFileBoard() 메서드를 호출하여 글쓰기 작업 수행
// => 파라미터 : FileBoardDTO 객체, 리턴타입 : int(insertCount)
FileBoardDAO dao = new FileBoardDAO();
int insertCount = dao.insertFileBoard(fileBoard);

// 게시물 등록 작업 실패 시 자바스크립트 통해 "글쓰기 실패!' 출력 후 이전페이지로 돌아가기
// 아니면, driver.jsp 페이지로 포워딩
if(insertCount == 0) {
	%>
	<script>
		alert("글쓰기 실패!");
		history.back();
	</script>
	<%
} else {
	response.sendRedirect("driver.jsp");
}
%>














