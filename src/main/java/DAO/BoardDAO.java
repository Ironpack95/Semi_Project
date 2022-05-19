package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import DTO.BoardDTO;

public class BoardDAO {
	public BoardDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	private Connection getConnection() throws Exception{
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "semi";
		String pw = "semi";
		return DriverManager.getConnection(url, id, pw);
	}
	
	// DB의 총 record 개수를 알아내기 위한 메소드
		private int getRecordTotalCount() throws Exception{
			String sql = "select count(*) from board";
			
			try(Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);
					ResultSet rs = pstat.executeQuery();){
				rs.next();
				return rs.getInt(1);	// count(*)로 전체 record 수가 출력되는데, 1열만 나오기 때문에
			}
		}
	
	// Page Navigator
		public String getPageNavi(int currentPage) throws Exception{
			int recordTotalCount = this.getRecordTotalCount();	// 총 게시글의 개수 -> 향후 실제 데이터베이스의 개수를 세어와야함
			
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
				sb.append("<a href='list.board?cpage="+(startNavi-1)+"'> < </a>");
			}

			for(int i = startNavi; i <= endNavi; i++) {
				if(currentPage == i) {
					sb.append("<a href=\'list.board?cpage="+i+"\'>[" + i + "] </a>");	// 페이지 당 10개씩 보이도록 해야하기 때문에 현재 페이지를 매개변수로 보냄으로써 페이지 네비를 클릭할 때 어디로 가야하는지 알아야한다.
				}else {
					sb.append("<a href=\'list.board?cpage="+i+"\'>" + i + " </a>");
				}
			}

			if(needNext) {
				sb.append("<a href='list.board?cpage="+(endNavi+1)+"'> > </a>");
			}

			return sb.toString();
		}

	// boradlist에서 보여지는 게시글 개수를 정하기 위한 메소드
		public List<BoardDTO> selectByPage(int cpage) throws Exception{

			// 게시글의 번호를 세팅한다.
			int start = cpage * 10 - 9;
			int end = cpage * 10;

			// 한 페이지에 게시글이 10개씩 보여지도록 하기 위해서 row_number를 활용하는데, 서브 쿼리를 활용해서 select 해준다.
			String sql = "select * from (select row_number() over(order by seq desc) line, board.* from\n board) where line between ? and ?";

			try(Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql);){
				pstat.setInt(1, start);
				pstat.setInt(2, end);

				try(ResultSet rs = pstat.executeQuery();){
					List<BoardDTO> list = new ArrayList<BoardDTO>();

					while(rs.next()) {
						int seq = rs.getInt("seq");
						String writer = rs.getString("writer");
						String title = rs.getString("title");
						String boardExp = rs.getString("board_exp");
						int boardLike = rs.getInt("board_like");
						int boardCount = rs.getInt("board_count");
						Timestamp writeDate = rs.getTimestamp("write_date");
						int boardSatus = rs.getInt("board_satus");

						BoardDTO dto = new BoardDTO(boardSatus, writer, title, boardExp, boardLike, boardCount, writeDate, boardSatus);
						list.add(dto);
					}
					return list;
				}
			}
		}
}