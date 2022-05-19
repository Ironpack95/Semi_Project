package Controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.BoardDAO;
import DTO.BoardDTO;

@WebServlet("/BoardController")
public class BoardController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String uri = request.getRequestURI();
		BoardDAO dao = new BoardDAO();

		try {
			if(uri.equals("/list.board")) {
				// 게시판 리스트 가져오기
				int cpage = Integer.parseInt(request.getParameter("cpage"));

				HttpSession session = request.getSession();
				session.setAttribute("cpage", cpage);

				List<BoardDTO> list = dao.selectByPage(cpage);	// 한 페이지에 보여지는 게시글의 개수를 정하기 위해 새로운 메소드가 필요함.
				//List<BoardDTO> list = dao.selectAll();
				String pageNavi = dao.getPageNavi(cpage);

				request.setAttribute("list", list);
				request.setAttribute("navi", pageNavi);
				request.getRequestDispatcher("/board/boardList.jsp").forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}