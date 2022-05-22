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
		MemberDAO dao = new MemberDAO();
		Gson g = new Gson();

		MyPageDAO mydao=new MyPageDAO();
		
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
			}else if (uri.equals("/login.member")) {
				String id = request.getParameter("id"); 
				String pw = EncryptUtils.SHA256(request.getParameter("pw"));
				
				boolean result = dao.login(id, pw); 
				System.out.println(result);
				if (result) {
					HttpSession session = request.getSession(); 
					session.setAttribute("loginID", id); 
					response.sendRedirect("index.jsp");	
			} else {
				response.sendRedirect("/Member/loginView.jsp");
			}
			//로그아웃
			}else if (uri.equals("/logout.member")) {
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
				//System.out.println("바뀐거: "+pwd);
				pw.append(g.toJson(pwd));
				dao.updatePw(new MemberDTO(id, pwd, null, null,null, null, null, null, null));
				//System.out.println("변경 성공");
				
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
				int result = mydao.memberout(id);
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
