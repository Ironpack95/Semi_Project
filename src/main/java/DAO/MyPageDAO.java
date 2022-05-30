package DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import DTO.BoardDTO;
import DTO.ManagerDTO;
import DTO.MemberDTO;


public class MyPageDAO {
	private BasicDataSource ds = new BasicDataSource();

	private static MyPageDAO instance = null;

	public synchronized static MyPageDAO getInstance() {

		if(instance == null) {
			instance = new MyPageDAO();
		}
		return instance;
	}
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();

	}
	//------------------------내 정보 출력-------------------------------
	public List<MemberDTO> mypage(String id)throws Exception{
		String sql = "select id,name,birthday,phone,email,zipcode,address1,address2 from member where id=?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, id);
			try(ResultSet rs = pstat.executeQuery();){
				List<MemberDTO> list = new ArrayList<>();
				while(rs.next()) {
					MemberDTO dto = new MemberDTO();

					dto.setId(rs.getString("id"));
					dto.setName(rs.getString("name"));
					dto.setBirthday(rs.getString("birthday"));
					dto.setPhone(rs.getString("phone"));
					dto.setEmail(rs.getString("email"));
					dto.setZipcode(rs.getString("zipcode"));
					dto.setAddress1(rs.getString("address1"));
					dto.setAddress2(rs.getString("address2"));


					list.add(dto);
				}
				return list;

			}

		}

	}
	//-------------------회원탈퇴-----------------------------------------
	public int memberout(String id)throws Exception {
		String sql = "delete from member where id=?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql)) {
			pstat.setString(1, id);
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	//-------------------회원정보 수정-----------------------------------
	public int update(MemberDTO dto) throws Exception {
		String sql = "update member set phone=?,email=?,zipcode=?,address1=?,address2=? where id=?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1,dto.getPhone());
			pstat.setString(2, dto.getEmail());
			pstat.setString(3,dto.getZipcode());
			pstat.setString(4,dto.getAddress1());
			pstat.setString(5,dto.getAddress2());
			pstat.setString(6,dto.getId());
			int result=pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	//---------------게시글 모아보기---------------------------------
	private int totalData(String id) throws Exception{
		String sql = "select count(*) from board where writer=?";
		
		
		
		try(Connection conn = this.getConnection();
				PreparedStatement pstat = conn.prepareStatement(sql);){
			pstat.setString(1,id);
			ResultSet rs = pstat.executeQuery();

			rs.next();

			return rs.getInt(1);
		}
	}
	// navibar
		public String getPageNavi(int cpage,String id) throws Exception{
			
			// 0) 전체 기본 설정
			int recordTotalCount = this.totalData(id);
			
			int recordCountPerPage = 10;

			int naviCountPerPage = 10;

			int pageTotalCount = 0;

			// 0-1) 페이지 계산 조건

			if(recordTotalCount % recordCountPerPage > 0) {

				pageTotalCount = recordTotalCount / recordCountPerPage +1;

			} else {

				pageTotalCount = recordCountPerPage / recordCountPerPage;
			}


			// navi 기본 설정

			// 1-1) 현재 페이지 설정
			int currentPage = cpage;

			if (currentPage < 1) {
				currentPage = 1;
			} else if (currentPage > pageTotalCount) { // 2 > 3
				currentPage = pageTotalCount;
			}

			// 1-2) 시작-끝 페이지 설정
			int startNavi = (currentPage-1)/naviCountPerPage*naviCountPerPage+1;
			int endNavi = startNavi + (naviCountPerPage -1);

			if (startNavi < 0) {
				startNavi = 1;
			} else if(endNavi > pageTotalCount) { 
				endNavi = pageTotalCount;
			}
			
			// 2) 페이지 넘기는 기능
			boolean preNavi = true;
			boolean nextNavi = true;

			if (startNavi == 1) {
				preNavi = false; // 시작이 1이 되면 안보여야 됨
			} else if (endNavi >= pageTotalCount) {
				nextNavi = false;
			}
			
			StringBuilder sbr = new StringBuilder();
			
			// 3) 출력 : StringBuilder
			if (preNavi) {
				sbr.append("<li class='page-item disabled'>"+"<a class='page-link' href='myboard.board?cpage="+(startNavi-1) +"'>" + "&laquo;" + "</a></li>");
			}                                                         

			for (int i=startNavi; i<= endNavi; i++) {
				// 페이지 번호마다 링크 걸기
				if(i == currentPage) {
					sbr.append("<li class='page-item active'>"+"<a class='page-link' href='article.manager?cpage="+i+"'>" + i + "</a></li>");
				} else {
					sbr.append("<li class='page-item'>"+"<a class='page-link' href='myboard.board?cpage="+i+"'> " + i + " </a></li>");
				}
			}

			if (nextNavi) {
				sbr.append("<li class='page-item'>"+"<a class='page-link' href='article.manager?cpage="+(endNavi+1) +"'>" + "&raquo;" + "</a></li>");
			}
			return sbr.toString();
		}

		// 4) 페이지별 출력
		public List<ManagerDTO> selectByPage(int cpage,String id) throws Exception{

			String sql = "select * from (select row_number() over(order by title desc) line, board.* from board) where writer=? and board_status IN (0,2) and line between ? and ?";

			int start = cpage*10 -9;
			int end = cpage*10;


			try(
					Connection con = this.getConnection();
					PreparedStatement pstat =  con.prepareStatement(sql);
					){
				pstat.setString(1,id);
				pstat.setInt(2, start);
				pstat.setInt(3, end);

				try(
						ResultSet rs = pstat.executeQuery();
						){
					List<ManagerDTO> list = new ArrayList<ManagerDTO>();

					while (rs.next()) {
						int board_num = rs.getInt("board_num");
						String title = rs.getString("title");
						String writer = rs.getString("writer");
						Date writerDate = rs.getDate("write_date");

						ManagerDTO dto = new ManagerDTO(board_num, title, writer, writerDate);

						list.add(dto);
					}

					return list;

				}
			}
		}
}
