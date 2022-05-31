package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import DTO.BoardDTO;
import DTO.ProductDTO;
import DTO.ReplyDTO;
import DAO.SearchDAO; 

public class BoardDAO {
	private static BoardDAO instance = null;

	public static synchronized BoardDAO getInstance() {
		if(instance == null) {
			instance = new BoardDAO();
		}
		return instance;
	}

	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds=(DataSource)ctx.lookup("java:comp/env/jdbc/orcl"); 
		return ds.getConnection();
	}

	// DB의 총 record 개수를 알아내기 위한 메소드
	private int getRecordTotalCount(String typeSql, String where) throws Exception{
		String sql = "select count(*) from board where board_status IN (0,2) "+ where + typeSql;
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();){
			rs.next();
			return rs.getInt(1);	// count(*)로 전체 record 수가 출력되는데, 1열만 나오기 때문에
		}
	}

	// Page Navigator
	public String getPageNavi(int currentPage,String typeSql, int type, String where, int selectType, String search) throws Exception{
		int recordTotalCount = this.getRecordTotalCount(typeSql,where);	// 총 게시글의 개수 -> 향후 실제 데이터베이스의 개수를 세어와야함

		int recordCountPerPage = 10;	// 한 페이지에 몇 개의 게시글을 보여줄 건지

		int naviCountPerPage = 10;		// 한 페이지에 몇 개의 네비를 보여 줄 건지

		int pageTotalCount = 0;			// 총 몇 개의 페이지가 필요한가?(우리가 정하는게 아니라 설정한 개수에 맞게 정해저야함)

		// 전체 페이지 수는 총 게시글에서 한 페이지에 보여지는 게시글의 개수를 나눈 값. 근데 나머지가 존재하면, +1 을 해줘야한다.
		if(recordTotalCount % recordCountPerPage > 0) {	// 전체 페이지 + 1 해야함(나머지가 존재할 때만)
			pageTotalCount = recordTotalCount / recordCountPerPage + 1;
		}else {
			pageTotalCount = recordTotalCount / recordCountPerPage;
		}

		// 현재 페이지가 비정상일 때 처리
		if(currentPage < 1) {
			currentPage = 1;
		}else if(currentPage > pageTotalCount) {
			currentPage = pageTotalCount;
		}

		// Page Navigator
		int startNavi = (currentPage-1) / naviCountPerPage * naviCountPerPage + 1;	// navi 시작의 공식 -> 현재 페이지의 십의 자리만 구해서 * naviPerPage +1 해주면 된다.
		int endNavi = startNavi + (naviCountPerPage - 1);

		if(endNavi > pageTotalCount) {	// 전체 페이지수 보다 endNavi 의 수가 클 수는 없다.
			endNavi = pageTotalCount;
		}

		boolean needNext = true;
		boolean needPrev = true;

		if(startNavi == 1) {
			needPrev = false;
		}
		if(endNavi == pageTotalCount) {
			needNext = false;
		}

		StringBuilder sb = new StringBuilder();

		if(needPrev) {
			sb.append("<a href='boardList.board?type="+type+"&cpage="+(startNavi-1)+"&selectType="+selectType+"&boardSearch="+search+"'> < </a>");
		}

		for(int i = startNavi; i <= endNavi; i++) {
			if(currentPage == i) {
				sb.append("<a href=\'boardList.board?type="+type+"&cpage="+i+"&selectType="+selectType+"&boardSearch="+search+"\'>[" + i + "] </a>");	// 페이지 당 10개씩 보이도록 해야하기 때문에 현재 페이지를 매개변수로 보냄으로써 페이지 네비를 클릭할 때 어디로 가야하는지 알아야한다.
			}else {
				sb.append("<a href=\'boardList.board?type="+type+"&cpage="+i+"&selectType="+selectType+"&boardSearch="+search+"\'>" + i + " </a>");
			}
		}

		if(needNext) {
			sb.append("<a href='boardList.board?type="+type+"&cpage="+(endNavi+1)+"&selectType="+selectType+"&boardSearch="+search+"'> > </a>");
		}

		return sb.toString();
	}

	// boradlist에서 보여지는 게시글 개수를 정하기 위한 메소드
	public List<BoardDTO> selectByPage(int cpage, String typeSql, String where) throws Exception{

		// 게시글의 번호를 세팅한다.
		int start = cpage * 10 - 9; // 1
		int end = cpage * 10; // 10

		// 한 페이지에 게시글이 10개씩 보여지도록 하기 위해서 row_number를 활용하는데, 서브 쿼리를 활용해서 select 해준다.
		String sql = "select * from (select row_number() over("+typeSql+") line, board.* from\n board where board_status IN (0,2) "+ where +") where line between ? and ?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, start);
			pstat.setInt(2, end);

			try(ResultSet rs = pstat.executeQuery();){
				List<BoardDTO> list = new ArrayList<BoardDTO>();

				while(rs.next()) {
					int seq = rs.getInt("board_num");
					int prductNum = rs.getInt("product_num");
					int score = rs.getInt("score");
					String writer = rs.getString("writer");
					String title = rs.getString("title");
					String boardExp = rs.getString("board_exp");
					int boardLike = rs.getInt("board_like");
					int boardCount = rs.getInt("view_count");
					Timestamp writeDate = rs.getTimestamp("write_date");
					int boardSatus = rs.getInt("board_status");

					BoardDTO dto = new BoardDTO(seq,prductNum,score, writer, title, boardExp, boardLike, boardCount, writeDate, boardSatus);
					list.add(dto);
				}
				return list;
			}
		}
	}

	public int getSeqNextVal() throws Exception{

		String sql = "select board_seq.nextval from dual";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();){
			rs.next();
			return rs.getInt(1);
		}
	}

	// 게시글 작성
	public int insert(BoardDTO dto) throws Exception{	
		String sql = "insert into board values(?, ?, ?, ?, ?, ?, 0, sysdate, 0, 0)";
		try(Connection con = this.getConnection();
			PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, dto.getBoardNum());
			pstat.setInt(2, dto.getProductNum());
			pstat.setInt(3, dto.getScore());
			pstat.setString(4, dto.getWriter());;
			pstat.setString(5, dto.getTitle());
			pstat.setString(6, dto.getBoardExp());
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	// 게시글 상세 보기
	public BoardDTO selectBoard(int num) throws Exception {
		String sql = "select * from board where board_num=?";

		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, num);

			try(ResultSet rs = pstat.executeQuery();){
				rs.next();
				int seq = rs.getInt("board_num");
				int prductNum = rs.getInt("product_num");
				int score = rs.getInt("score");
				String writer = rs.getString("writer");
				String title = rs.getString("title");
				String boardExp = rs.getString("board_exp");
				int boardLike = rs.getInt("board_like");
				int boardCount = rs.getInt("view_count");
				Timestamp writeDate = rs.getTimestamp("write_date");
				int boardSatus = rs.getInt("board_status");

				BoardDTO dto = new BoardDTO(seq,prductNum,score, writer, title, boardExp, boardLike, boardCount, writeDate, boardSatus);
				return dto;
			}
		}
	}

	// 게시글 조회수 증가
	public int boardUpdateCount(int num) throws Exception {
		String sql = "update board set view_count = view_count + 1 where board_num = ?";

		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, num);

			try(ResultSet rs = pstat.executeQuery();){
				con.commit();
				return 1;
			}
		}
	}

	// 추천하기 누르면 좋아요 증가
	public int boardLike(int num) throws Exception {
		String sql = "update board set board_like = board_like +1 where board_num = ?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, num);

			try(ResultSet rs = pstat.executeQuery();){
				con.commit();
				return 1;
			}
		}
	}

	// 게시판 삭제
	public int boardDelete(int num, int stat) throws Exception{
		String sql = "update board set board_status = ? where board_num = ?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, stat);
			pstat.setInt(2, num);
			try(ResultSet rs = pstat.executeQuery();){
				con.commit();
				return 1;
			}
		}
		
	}

	// 게시판 수정
	public int update(BoardDTO dto) throws Exception{
		String sql = "update board set title = ?, product_Num =?, board_exp = ?, score =? where board_num = ?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setString(1, dto.getTitle());
			pstat.setInt(2, dto.getProductNum());
			pstat.setString(3, dto.getBoardExp());
			pstat.setInt(4, dto.getScore());
			pstat.setInt(5, dto.getBoardNum());

			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}

	// 게시글 좋아요 누른 유저 정보 등록
	public void boardUserLike(int num, String id) throws Exception{
		String sql = "insert into Board_like values(?,?)";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, num);
			pstat.setString(2, id);

			int result = pstat.executeUpdate();
			con.commit();
		}
	}

	// 게시글 좋아요 누른 유저가 기존에 눌렀는지 체크
	public int boardLikeCheck(int num, String id) throws Exception{
		String sql = "select count(*) from board_like where board_num = ? and user_id = ?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, num);
			pstat.setString(2, id);

			ResultSet rs = pstat.executeQuery();{
				rs.next();
				return rs.getInt(1);
			}
		}
	}

	// 제품 목록 조회
	public List<ProductDTO> productSelect() throws Exception {
		String sql = "select * from product_info";

		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){

			try(ResultSet rs = pstat.executeQuery();){
				List<ProductDTO> list = new ArrayList<ProductDTO>();
				while(rs.next()) {
					int seq = rs.getInt("SEQ");
					String productName = rs.getString("PRODUCT_NAME");
					String smry = rs.getString("SMRY");
					String oriName = rs.getString("ORI_NAME");
	
					ProductDTO dto = new ProductDTO(productName, seq ,smry,oriName);
					list.add(dto);
				}
				return list;
			}
		}
	}

	// 수정 페이지 선택한 제품 조회
	public ProductDTO productOneSelect(int prodcutNum) throws Exception{
		String sql = "select * from product_info where seq = ?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, prodcutNum);

			try(ResultSet rs = pstat.executeQuery();){
				rs.next();
				int seq = rs.getInt("SEQ");
				String productName = rs.getString("PRODUCT_NAME");
				String smry = rs.getString("SMRY");
				String oriName = rs.getString("ORI_NAME");

				ProductDTO dto = new ProductDTO(productName, seq, smry, oriName);
				return dto;
			}
		}
	}

	// 게시글 좋아요 취소
	public int boardLikeDelete(int num) throws Exception{
		String sql = "update board set board_like = board_like - 1 where board_num = ?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, num);

			try(ResultSet rs = pstat.executeQuery();){
				con.commit();
				return 1;
			}
		}
	}

	// 게시글 좋아요 누른 유저 정보 삭제
	public void boardUserLikeDelete(int num, String id) throws Exception{
		String sql = "delete board_like where board_num = ? and user_id = ?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, num);
			pstat.setString(2, id);

			int result = pstat.executeUpdate();
			con.commit();
		}
	}
}