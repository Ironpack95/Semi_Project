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

import DTO.ManagerDTO;
import DTO.MemberDTO;

public class ManagerDAO {
	
	private static ManagerDAO instance = null;
	
	public synchronized static ManagerDAO getInstance() {
		if(instance ==  null) {
			instance = new ManagerDAO();
		} 
		return instance;
	}
	
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/orcl");
		
		return ds.getConnection();
	}
	
	
	// 총 데이터 가져오기
	private int totalData() throws Exception{
		String sql = "select count(*) from board where board_status=2";


		try(Connection conn = this.getConnection();
				PreparedStatement pstat = conn.prepareStatement(sql);){

			ResultSet rs = pstat.executeQuery();

			rs.next();

			return rs.getInt(1);
		}
	}
	
	public int dataCount() throws Exception{
		String sql = "select count(*) from board";


		try(Connection conn = this.getConnection();
				PreparedStatement pstat = conn.prepareStatement(sql);){

			ResultSet rs = pstat.executeQuery();

			rs.next();

			return rs.getInt(1);
		}
	}


	// navibar1
	public String getPageNavi(int cpage) throws Exception{
		
		// 0) 전체 기본 설정
		int recordTotalCount = this.totalData();
		
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
		} 
		// 제일 큰 실수
		if (endNavi == pageTotalCount) {
			nextNavi = false;
		}
		
		StringBuilder sbr = new StringBuilder();
		
		// 3) 출력 : StringBuilder
		if (preNavi) {
			sbr.append("<li class='page-item disabled'>"+"<a class='page-link' href='article.manager?cpage="+(startNavi-1) +"'>" + "&laquo;" + "</a></li>");
		}

		for (int i=startNavi; i<= endNavi; i++) {
			// 페이지 번호마다 링크 걸기
			if(i == currentPage) {
				sbr.append("<li class='page-item active'>"+"<a class='page-link' href='article.manager?cpage="+i+"'>" + i + "</a></li>");
			} else {
				sbr.append("<li class='page-item'>"+"<a class='page-link' href='article.manager?cpage="+i+"'> " + i + " </a></li>");
			}
		}

		if (nextNavi) {
			sbr.append("<li class='page-item'>"+"<a class='page-link' href='article.manager?cpage="+(endNavi+1) +"'>" + "&raquo;" + "</a></li>");
		}
		return sbr.toString();
	}

	// 4) 페이지별 출력
	public List<ManagerDTO> selectByPage(int cpage) throws Exception{

		String sql = "select * from (select row_number() over(order by title desc) line, board.* from board) where Board_Status=2 and line between ? and ?";

		int start = cpage*10 -9;
		int end = cpage*10;


		try(
				Connection con = this.getConnection();
				PreparedStatement pstat =  con.prepareStatement(sql);
				){
			pstat.setInt(1, start);
			pstat.setInt(2, end);

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
	
	// 신고글 삭제
	
	public int deleteArticle(int[] arr)  throws Exception {
		
		String sql = "delete from board where board_num in (?, ?, ?, ?, ?, ?, ?, ?, ? ,?)";
		
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			
			for(int i=0; i<arr.length; i++) {
				pstat.setInt(i+1, arr[i]);
			}
			
			int result = pstat.executeUpdate();
			con.commit();
			
			return result;
			
		}
		
		
	}
	
	// 회원목록 가져오기
	
	// 총 데이터 가져오기
	private int totalDataForMember() throws Exception{
		String sql = "select count(*) from member";


		try(Connection conn = this.getConnection();
				PreparedStatement pstat = conn.prepareStatement(sql);){

			ResultSet rs = pstat.executeQuery();

			rs.next();

			return rs.getInt(1);
		}
	}
	
	public int dataCountForMember() throws Exception{
		String sql = "select count(*) from member";

		try(Connection conn = this.getConnection();
				PreparedStatement pstat = conn.prepareStatement(sql);){

			ResultSet rs = pstat.executeQuery();

			rs.next();

			return rs.getInt(1);
		}
	}


	// navibar1
	public String getPageNaviForMember(int cpage) throws Exception{
		
		// 0) 전체 기본 설정
		int recordTotalCount = this.totalData();
		
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
			sbr.append("<li class='page-item disabled'>"+"<a class='page-link' href='member.manager?cpage="+(startNavi-1) +"'>" + "&laquo;" + "</a></li>");
		}

		for (int i=startNavi; i<= endNavi; i++) {
			// 페이지 번호마다 링크 걸기
			if(i == currentPage) {
				sbr.append("<li class='page-item active'>"+"<a class='page-link' href='member.manager?cpage="+i+"'>" + i + "</a></li>");
			} else {
				sbr.append("<li class='page-item'>"+"<a class='page-link' href='member.manager?cpage="+i+"'> " + i + " </a></li>");
			}
		}

		if (nextNavi) {
			sbr.append("<li class='page-item'>"+"<a class='page-link' href='member.manager?cpage="+(endNavi+1) +"'>" + "&raquo;" + "</a></li>");
		}
		return sbr.toString();
	}

	// 4) 페이지별 출력
	public List<MemberDTO> selectByPageForMember(int cpage) throws Exception{

		String sql = "select * from (select row_number() over(order by name desc) line, member.* from member) where line between ? and ?";

		int start = cpage*10 -9;
		int end = cpage*10;


		try(
				Connection con = this.getConnection();
				PreparedStatement pstat =  con.prepareStatement(sql);
				){
			pstat.setInt(1, start);
			pstat.setInt(2, end);

			try(
					ResultSet rs = pstat.executeQuery();
					){
				List<MemberDTO> list = new ArrayList<MemberDTO>();

				while (rs.next()) {
					String id = rs.getString("id");
					String pw = rs.getString("pw");
					String name = rs.getString("name");
					String phone = rs.getString("phone");
					String birthday = rs.getString("birthday");
					String zipcode = rs.getString("zipcode");
					String email = rs.getString("email");
					String adress1 = rs.getString("address1");
					String adress2 = rs.getString("address2");
					
					MemberDTO dto = new MemberDTO(id, pw, name, birthday, phone, email, zipcode, adress1, adress2);
					
					list.add(dto);
				}

				return list;

			}
		}
	}

}
