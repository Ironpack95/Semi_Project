package Controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import DAO.MemberDAO;
import DAO.MyPageDAO;
import DTO.MemberDTO;
import utils.EncryptUtils;

@WebServlet("*.member")
public class MemberController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf8");//post 한글깨짐 방지
	
		String uri = request.getRequestURI();
		MemberDAO dao = MemberDAO.getInstance();
		Gson g = new Gson();

		MyPageDAO mydao= MyPageDAO.getInstance();
		
		try {
			//회원가입시 joinView.jsp이동
			if (uri.equals("/join.member")){
				response.sendRedirect("/Member/joinView.jsp");
				
				//계정 loginView.jsp 이동
			} else if (uri.equals("/account.member")) {
				String id = request.getParameter("id");
				String pw = EncryptUtils.SHA256(request.getParameter("pw"));
				String name = request.getParameter("name");
				String birthday = request.getParameter("birthday");	
				String phone = request.getParameter("phone");
				String email = request.getParameter("email");
				String zipcode = request.getParameter("zipcode");
				String address1 = request.getParameter("address1");
				String address2 = request.getParameter("address2");
				
				dao.insert(new MemberDTO(id, pw, name, birthday, phone, email, zipcode, address1, address2));
				response.sendRedirect("/index.jsp");
				
			//아이디 중복체크
			} else if (uri.equals("/duplCheck.member")){
				String id = request.getParameter("id");
				boolean result = dao.isIdExist(id); 
				
				response.getWriter().append(String.valueOf(result));
				
				
//-------------------- 로그인-----------------------------
			//로그인
			}else if (uri.equals("/login.member")) {
				String id = request.getParameter("id"); 
				String pw = EncryptUtils.SHA256(request.getParameter("pw"));
				
				boolean result = dao.login(id, pw); 
				System.out.println("아디:"+id+" 비번:"+pw+" 결과:"+result);
				if (result) {
					HttpSession session = request.getSession(); 
					session.setAttribute("loginID", id);
					response.sendRedirect("index.jsp");	
				} else if(!result){
					response.sendRedirect("/Member/loginView.jsp");
				}
			//아이디or비번 유효성은 맞는데 입력을 잘못했을 때
			} else if(uri.equals("/logincheck.member")) {
				String id = request.getParameter("id"); 
				String pw = EncryptUtils.SHA256(request.getParameter("pw"));
				boolean result = dao.login(id, pw); 
				if (result) {
					HttpSession session = request.getSession(); 
					session.setAttribute("loginID", id);
					response.sendRedirect("index.jsp");	
				} else if(!result){
					response.getWriter().append(String.valueOf(result));
				}
				
			//카카오 로그인-이메일 확인 후 없다면 DB,session 저장
			} else if (uri.equals("/kakaologin.member")){
				response.setCharacterEncoding("UTF-8");
				HttpSession session = request.getSession(); 
				String id = request.getParameter("id"); //임의숫자값 할당(변동없는 듯)
				String name = request.getParameter("name"); //닉네임
				String email = request.getParameter("email");
				String birthday = request.getParameter("birthday"); //(생년없이)월일
				
				if (email == null || birthday == null) {
					request.getSession().invalidate();
					response.sendRedirect("/index.jsp");
				}
				
				
				
				//String token = request.getParameter("token");
				System.out.println("임의id:"+id+" 닉:"+name+" 메일:"+email+" 생일:"+birthday);
				PrintWriter pw = response.getWriter();
				pw.append(g.toJson(id));
				String result = dao.kakaoLogin(email);
				
				if(result == null) {
					dao.insert(new MemberDTO(id, " ", name, birthday, " ", email, " ", " ", " ")); // 마이페이지 데이터 입력용  0530 종호
					dao.kakaoInsert(new MemberDTO(id, name, birthday, email));
					session.setAttribute("kakaoemail", email); 
					session.setAttribute("loginID", id);  // 로그인 아이디 0530 종호
					//System.out.println("신규 카카오 이메일: "+email);
					System.out.println("이곳 1");
					response.sendRedirect("index.jsp");
				} else {
					session.setAttribute("kakaoemail", email); 
					session.setAttribute("loginID", id);  // 로그인 아이디 0530 종호
					//System.out.println("이미 있는 카카오 이메일: "+email);
					System.out.println("이곳 2");
					response.sendRedirect("index.jsp");
				}
				
			//로그아웃
			} else if (uri.equals("/logout.member")) {
				request.getSession().invalidate();
				response.sendRedirect("/index.jsp");
				
				
			//아이디 찾기
			} else if (uri.equals("/searchId.member")) {
				String name = request.getParameter("name");
				String phone = request.getParameter("phone");
				System.out.println(name+"<<이름 폰>>"+phone);
				
				MemberDTO dto = new MemberDTO(name, phone);
				String id = dao.searchId(dto);
				PrintWriter pw = response.getWriter();
				pw.append(g.toJson(id));

				
			//비번 재설정 위한 정보 확인
			} else if (uri.equals("/searchPw.member")) {
				String id = request.getParameter("id");
				String name = request.getParameter("name");
				String phone = request.getParameter("phone");
				//System.out.println("아이디:"+id+" 이름:"+name+" 폰:"+phone);
				
				MemberDTO dto = new MemberDTO(id, name, phone);
				String pwd = dao.searchPw(dto);
				PrintWriter pw = response.getWriter();
				pw.append(g.toJson(pwd));
				//System.out.println("바뀌기 전: "+pwd);
			
			//비번 재설정
			} else if (uri.equals("/updatePw.member")) {
				String id = request.getParameter("id");
				String pwd = EncryptUtils.SHA256(request.getParameter("pw"));
				PrintWriter pw = response.getWriter();
				System.out.println("아이디: "+id+"바뀐거: "+pwd);
				pw.append(g.toJson(pwd));
				dao.updatePw(new MemberDTO(id, pwd,null,null,null,null,null,null,null));
				System.out.println("변경 성공");
				
				
//--------------------마이페이지------------------------------------
		}else if(uri.equals("/mypage.member")) {
			String id = (String) (request.getSession().getAttribute("loginID"));
			List<MemberDTO> list = mydao.mypage(id);
			request.setAttribute("list", list);
			request.getRequestDispatcher("/Member/myPage.jsp").forward(request, response);
				
//-------------------마이페이지 수정------------------------------------------
			}else if(uri.equals("/updList.member")) {
				String id = (String) (request.getSession().getAttribute("loginID"));
				List<MemberDTO> list = mydao.mypage(id);
				request.setAttribute("list", list);

				request.getRequestDispatcher("/Member/memberUpdate.jsp").forward(request, response);
		
		
			}else if(uri.equals("/update.member")){
				String id = (String) (request.getSession().getAttribute("loginID"));
				
				
				String phone =request.getParameter("phone");
				String email= request.getParameter("email");
				String zipcode=request.getParameter("zipcode");
				String address1= request.getParameter("address1");
				String address2= request.getParameter("address2");
				
				int result = mydao.update(new MemberDTO(id,null,null,null,phone,email,zipcode,address1,address2));

				response.sendRedirect("/mypage.member");
				
//--------------------회원탈퇴--------------------------------------				
			}else if(uri.equals("/memberout.member")) {
				String id= (String) (request.getSession().getAttribute("loginID"));
				String email=(String) (request.getSession().getAttribute("kakaoemail"));
				int result = mydao.memberout(id);
				int result2 = dao.kakaoOut(email); // 카카오테이블 삭제도 함께 삭제됨 0530 종호
				request.getSession().invalidate();
				System.out.println((String)request.getSession().getAttribute("kakaoemail"));
				System.out.println((String)request.getSession().getAttribute("loginID"));
				response.sendRedirect("index.jsp");
				
			//카카오 탈퇴
			}else if(uri.equals("/kakaoout.member")) {
				String id= (String) (request.getSession().getAttribute("loginID"));
				String email=(String) (request.getSession().getAttribute("kakaoemail"));
				int result = mydao.memberout(id);
				int result2 = dao.kakaoOut(email);
				request.getSession().invalidate();
				response.sendRedirect("index.jsp");
			}
				
			
		}catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp");
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
