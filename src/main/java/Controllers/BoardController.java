package Controllers;

import java.io.File;	
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import DAO.BoardDAO;
import DAO.FileDAO;
import DAO.MyPageDAO;
import DAO.ReplyDAO;
import DTO.BoardDTO;
import DTO.FileDTO;
import DTO.ManagerDTO;
import DTO.ProductDTO;
import DTO.ReplyDTO;

@WebServlet("*.board")
public class BoardController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String uri = request.getRequestURI();


		BoardDAO dao = BoardDAO.getInstance();
		MyPageDAO mdao = MyPageDAO.getInstance();
		FileDAO fdao = FileDAO.getInstance();
		ReplyDAO rdao = ReplyDAO.getInstance();
		
		try {
			// 게시판 목록 불러오기
			if(uri.equals("/boardList.board")) {

				int cpage = 1;
				int type = 0;
				int selectType = 0;
				String search = "";
				String where = "";
				String whereSub = "";
				// 게시판 리스트 가져오기
				if(request.getParameter("cpage") != null && request.getParameter("cpage") != "") {
					cpage = Integer.parseInt(request.getParameter("cpage"));
				}

				// 게시판 정렬 타입 가져오기 
				if(request.getParameter("type") != null && request.getParameter("type") != "") {
					type = Integer.parseInt(request.getParameter("type"));
				}

				// 검색 기능 파라미터 가져오기
				if(request.getParameter("selectType") != null && request.getParameter("selectType") != "") {
					selectType = Integer.parseInt(request.getParameter("selectType"));
				}

				// 검색 기능 파라미터 가져오기
				if(request.getParameter("boardSearch") != null && request.getParameter("boardSearch") != "") {
					search = request.getParameter("boardSearch");
				}

				if(selectType == 1) {
					where = " and title like '%"+search+"%'";
				}else if(selectType == 2) {
					where = " and writer like '%"+search+"%'";
				}			
				HttpSession session = request.getSession();
				session.setAttribute("cpage", cpage);
				String typeSql = "ORDER BY BOARD_NUM DESC";
				switch(type) {

				case 0 : typeSql = "ORDER BY BOARD_NUM DESC"; break;
				case 1 : typeSql = " ORDER BY VIEW_COUNT DESC"; break;
				case 2 : typeSql = " ORDER BY WRITE_DATE DESC"; break;
				case 3 : typeSql = " ORDER BY BOARD_LIKE DESC"; break;
				default : typeSql = "ORDER BY BOARD_NUM DESC";break;
				}

				List<BoardDTO> list = dao.selectByPage(cpage,typeSql,where);	// 한 페이지에 보여지는 게시글의 개수를 정하기 위해 새로운 메소드가 필요함.

				//List<BoardDTO> list = dao.selectAll();
				String pageNavi = dao.getPageNavi(cpage,typeSql,type,where,selectType,search);
				request.setAttribute("list", list);
				request.setAttribute("navi", pageNavi);
				request.getRequestDispatcher("/Board/boardList.jsp").forward(request, response);

			// 게시글 페이지 이동
			}else if(uri.equals("/boardAddPage.board")) {
				List<ProductDTO> product = dao.productSelect();
				request.setAttribute("product", product);
				request.getRequestDispatcher("/Board/boardAdd.jsp").forward(request, response);
			// 게시글 추가
			}else if(uri.equals("/boardAdd.board")) {
				String writer = (String)request.getSession().getAttribute("loginID");

				String path = request.getServletContext().getRealPath("files");
				File filePath = new File(path);

				if(!filePath.exists()) {

					filePath.mkdir();
				}
				MultipartRequest multi = new MultipartRequest(request, path, 1024*1024*10,"UTF8",new DefaultFileRenamePolicy());

				String title = multi.getParameter("title");
				int prodcutNum = Integer.parseInt(multi.getParameter("prodcutNum"));

				String editorTxt = multi.getParameter("editorTxt");

				String oriName = multi.getOriginalFileName("file");
				String sysName = multi.getFilesystemName("file");
				int score = Integer.parseInt(multi.getParameter("score"));
				int seq = dao.getSeqNextVal();
				int result = dao.insert(new BoardDTO(seq, prodcutNum, score,writer, title, editorTxt, 0, 0, null, 0));
				if(oriName != null) {
					fdao.insert(new FileDTO(0, oriName,sysName,seq));
				}
				//request.getRequestDispatcher("/boardList.board?cpage=1").forward(request, response);
				response.sendRedirect("/boardList.board?cpage=1");
				
				// 게시글 상세 조회
			}else if(uri.equals("/boardSelect.board")){

				int num = Integer.parseInt(request.getParameter("num"));
				String id = (String) (request.getSession().getAttribute("loginID"));
				int result = dao.boardUpdateCount(num);
				BoardDTO board = dao.selectBoard(num);
				List<ReplyDTO> reply = rdao.selectReply(num);
				int boardLike = dao.boardLikeCheck(num,id);
				ProductDTO product = dao.productOneSelect(board.getProductNum());
				request.setAttribute("board", board);
				request.setAttribute("reply", reply);
				request.setAttribute("boardLike", boardLike);
				request.setAttribute("product", product);

				request.getRequestDispatcher("/Board/reply.jsp").forward(request, response);


				// 게시글 좋아요
			}else if(uri.equals("/boardLike.board")) {

				int num = Integer.parseInt(request.getParameter("num"));

				String id = (String) (request.getSession().getAttribute("loginID"));
				int result = dao.boardLikeCheck(num,id); 
				if(result == 0) {
					// 게시글 좋아요 개수 업데이트 
					result = dao.boardLike(num);
					// 게시글 좋아요 누른 유저 정보 등록
					dao.boardUserLike(num,id);
				}
				request.getRequestDispatcher("/boardSelect.board?num="+num).forward(request, response);

				// 게시글 좋아요 취소
			}else if(uri.equals("/boardLikeDelete.board")) {
				int num = Integer.parseInt(request.getParameter("num"));

				String id = (String) (request.getSession().getAttribute("loginID"));
				int result = dao.boardLikeCheck(num,id); 
				if(result > 1) {
					// 게시글 좋아요 개수 업데이트 
					result = dao.boardLikeDelete(num);
					// 게시글 좋아요 누른 유저 정보 등록
					dao.boardUserLikeDelete(num,id);
				}
				request.getRequestDispatcher("/boardSelect.board?num="+num).forward(request, response);
			}else if(uri.equals("/boardSet.board")) {
				int num = Integer.parseInt(request.getParameter("num"));
				int stat = Integer.parseInt(request.getParameter("stat"));
				int result = dao.boardDelete(num,stat);

				if(stat == 1) {
					request.getRequestDispatcher("/boardList.board?cpage=1").forward(request, response);
				}else if(stat == 2) {
					request.getRequestDispatcher("/boardSelect.board?num="+num).forward(request, response);
				}

			// 게시글 수정 페이지 이동
			}else if(uri.equals("/boardUpdate.board")) {

				int num = Integer.parseInt(request.getParameter("num"));
				List<ProductDTO> product = dao.productSelect();
				BoardDTO board = dao.selectBoard(num);
				ProductDTO productOne = dao.productOneSelect(board.getProductNum());
				request.setAttribute("board", board);
				request.setAttribute("productOne", productOne);
				request.setAttribute("product", product);
				request.getRequestDispatcher("/Board/boardUpdate.jsp").forward(request, response);

				// 게시글 수정
			}else if(uri.equals("/boardUpdateAction.board")) {

				String writer = (String)request.getSession().getAttribute("loginID");

				String path = request.getServletContext().getRealPath("files");
				File filePath = new File(path);
				if(!filePath.exists()) {
					filePath.mkdir();

				}


				MultipartRequest multi = new MultipartRequest(request, path, 1024*1024*10,"UTF8",new DefaultFileRenamePolicy());

				int num = Integer.parseInt(multi.getParameter("num"));
				String title = multi.getParameter("title");
				
				
				int prodcutNum = Integer.parseInt(multi.getParameter("prodcutNum")); 

				
				String contents = multi.getParameter("editorTxt");

				String oriName = multi.getOriginalFileName("file");
				String sysName = multi.getFilesystemName("file");
				int score = Integer.parseInt(multi.getParameter("score"));
				int seq = num;
				int result = dao.update(new BoardDTO(seq,prodcutNum, score, writer, title, contents, 0, 0, null, 0));
				if(oriName != null) {
					fdao.insert(new FileDTO(0, oriName,sysName,seq));
				}
				
				request.getRequestDispatcher("/boardSelect.board?num="+num).forward(request, response);
			}

			// 댓글 추가
			else if (uri.equals("/add.board")) {

				request.setCharacterEncoding("utf-8");

				String writer = request.getParameter("writer");
				String content = request.getParameter("content");
				int parentSeq = 1;
				if(request.getParameter("parent_seq") != null && request.getParameter("parent_seq") != "") {
					parentSeq = Integer.parseInt(request.getParameter("parent_seq"));	
				}

				int result = rdao.addReply(writer, content, parentSeq);
				//request.getRequestDispatcher("/boardSelect.board?num="+parentSeq).forward(request, response);
				response.sendRedirect("boardSelect.board?num="+parentSeq);

				// 삭제	
			} else if (uri.equals("/del.board")) {

				int pseq = Integer.parseInt(request.getParameter("pseq"));
				int seq = Integer.parseInt(request.getParameter("seq"));

				int result = rdao.delReply(seq, pseq);

				PrintWriter pw = response.getWriter();

				pw.append("1");
				request.getRequestDispatcher("/boardSelect.board?num="+seq).forward(request, response);

				// 수정   
			} else if (uri.equals("/modify.board")) {

				request.setCharacterEncoding("utf-8");
				String path = request.getServletContext().getRealPath("files");
				File filePath = new File(path);
				if(!filePath.exists()) {
					filePath.mkdir();
				}

				MultipartRequest multi = new MultipartRequest(request, path, 1024*1024*10,"UTF8",new DefaultFileRenamePolicy());

				int pseq = Integer.parseInt(request.getParameter("pseq"));
				int seq = Integer.parseInt(request.getParameter("seq"));
				String content = multi.getParameter("contents");
				int result = rdao.updateReply(pseq, seq, content);

				request.getRequestDispatcher("/boardSelect.board?num="+pseq).forward(request, response);
				
			} else if(uri.equals("/myboard.board")) {
                String id = (String) (request.getSession().getAttribute("loginID"));
               int cpage = Integer.parseInt(request.getParameter("cpage"));
               request.getSession().setAttribute("cpage", cpage);
         
               List<ManagerDTO> list = mdao.selectByPage(cpage, id);
               String pageNavi = mdao.getPageNavi(cpage, id);
               
               
               request.setAttribute("list", list);
               request.setAttribute("navi", pageNavi);
               request.getRequestDispatcher("/Member/myBoardList.jsp").forward(request, response);
           }

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}