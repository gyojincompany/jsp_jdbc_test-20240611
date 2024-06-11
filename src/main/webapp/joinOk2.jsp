<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입확인</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");//파라미터 값->utf-8로 인코딩(한글깨짐 방지)
		
		String mname = request.getParameter("memberName");//회원가입시 입력한 회원이름 가져오기
		String memail = request.getParameter("memberEmail");//회원가입시 입력한 회원이메일 가져오기
		
		String sql = "INSERT INTO member_tbl(member_name, member_email) VALUES(?,?)";
		
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/member_db";
		String username = "root";
		String password = "12345";
		
		Connection conn = null;
		//Statement stmt = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driverName);//jdbc 드라이버 불러오기
			conn = DriverManager.getConnection(url, username, password);//DB 연동 커넥션 생성
			
			//stmt = conn.createStatement();
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, mname);//sql내의 첫번째 ?에 mname을 셋팅
			pstmt.setString(2, memail);//sql내의 두번째 ?에 memail을 셋팅
			
			int success = pstmt.executeUpdate();//sql문 실행->1이 반환되면 sql문 실행 성공
			
			if(success == 1) {//참이면 sql문 성공적으로 실행
				out.println(mname + "님 회원 가입을 축하드립니다!!");
			} else {
				out.println("회원 가입 실패!! 다시 확인해주세요");
			}
			
		} catch(Exception e) {
			out.println("DB연동 에러 발생!!");
			e.printStackTrace();//에러발생시 에러내용 출력
		} finally {
			try {
				if(pstmt != null) {
					pstmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		}		
		
	%>
	<hr>
	<a href="list.jsp">회원리스트 보기</a>
	
</body>
</html>