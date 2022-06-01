package DAO;import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import DTO.SearchDTO;


public class SearchDAO {

	private static SearchDAO instance = null;

	public static synchronized SearchDAO getInstance() {
		if(instance == null) {
			instance = new SearchDAO();
		}
		return instance;
	}

	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/orcl");

		return ds.getConnection();
	}

	// 텍스트 유효성 검사
	public String getWord(String search_text) {

		String word = "";

		if(!(search_text.equals(""))) {

			List<Character> checkList =  new ArrayList<Character>(); 

			for(int i=0; i<search_text.length(); i++) {

				checkList.add(search_text.charAt(i));

			}

			for(int i=0; i<checkList.size(); i++) {

				if(checkList.get(i) == ' ') {
					checkList.remove(i);
				}

			}


			for(int i=0; i<checkList.size(); i++) {
				word += checkList.get(i);
			}

		}
		return word;
	}


	// 일반 검색
	public List<SearchDTO> SearchByText(String product_name) throws Exception{

		String sql = "select row_number() over(order by product_name desc) num, product_name, seq, kind, price, abv, grade, smry, ori_name, sys_name from product_info where search_name like '%'||?||'%'";

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){

			pstat.setString(1, product_name);

			try(
					ResultSet rs = pstat.executeQuery();
					){

				List<SearchDTO> list = new ArrayList<SearchDTO>();

				while(rs.next()) {

					int index = rs.getInt("num");
					String pname = rs.getString("product_name");
					int seq = rs.getInt("seq");
					int price = rs.getInt("price");
					String kind = rs.getString("kind");
					float abv = rs.getFloat("abv");
					int grade = rs.getInt("grade");
					String smry = rs.getString("smry");
					String oriName = rs.getString("ori_name");
					String sysName = rs.getString("sys_name");

					SearchDTO dto = new SearchDTO(index,pname, seq, kind, price, abv, grade, smry, oriName, sysName);

					list.add(dto);
				}

				return list;

			}
		}
	}

	// 상세 검색 1
	public List<SearchDTO> searchDetail(boolean[] searchType, String[] alcholArr, String[] areaArr, int grade, float abv, String sql) throws Exception{

		boolean[] t = searchType;
		
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){


			// 조건 1 (1 2 3 4)
			if (t[1] && t[2] && t[3] && t[4]) {
				pstat.setString(1, alcholArr[0]);
				pstat.setString(2, alcholArr[1]);
				pstat.setString(3, alcholArr[2]);
				pstat.setString(4, alcholArr[3]);
				pstat.setString(5, alcholArr[4]);
				pstat.setString(6, areaArr[0]);
				pstat.setString(7, areaArr[1]);
				pstat.setString(8, areaArr[2]);
				pstat.setString(9, areaArr[3]);
				pstat.setString(10, areaArr[4]);
				pstat.setString(11, areaArr[5]);
				pstat.setInt(12, grade);
				pstat.setInt(13, grade);
				pstat.setFloat(14, abv);
			}
			// 조건 2 (1 2 3)
			else if(t[1] && t[2] && t[3]) {
				pstat.setString(1, alcholArr[0]);
				pstat.setString(2, alcholArr[1]);
				pstat.setString(3, alcholArr[2]);
				pstat.setString(4, alcholArr[3]);
				pstat.setString(5, alcholArr[4]);
				pstat.setString(6, areaArr[0]);
				pstat.setString(7, areaArr[1]);
				pstat.setString(8, areaArr[2]);
				pstat.setString(9, areaArr[3]);
				pstat.setString(10, areaArr[4]);
				pstat.setString(11, areaArr[5]);
				pstat.setInt(12, grade);
				pstat.setInt(13, grade);

			}
			// 조건 3 (1 2 4)
			else if(t[1] && t[2] && t[4]) { 
				pstat.setString(1, alcholArr[0]);
				pstat.setString(2, alcholArr[1]);
				pstat.setString(3, alcholArr[2]);
				pstat.setString(4, alcholArr[3]);
				pstat.setString(5, alcholArr[4]);
				pstat.setString(6, areaArr[0]);
				pstat.setString(7, areaArr[1]);
				pstat.setString(8, areaArr[2]);
				pstat.setString(9, areaArr[3]);
				pstat.setString(10, areaArr[4]);
				pstat.setString(11, areaArr[5]);
				pstat.setFloat(12, abv);

			}
			// 조건 4 (1 3 4)
			else if(t[1] && t[3] && t[4]) { 
				pstat.setString(1, alcholArr[0]);
				pstat.setString(2, alcholArr[1]);
				pstat.setString(3, alcholArr[2]);
				pstat.setString(4, alcholArr[3]);
				pstat.setString(5, alcholArr[4]);
				pstat.setString(6, areaArr[4]);
				pstat.setString(7, areaArr[5]);
				pstat.setFloat(8, abv);

			}
			// 조건 5 (2 3 4)
			else if(t[2] && t[3] && t[4]) {
				pstat.setString(1, areaArr[0]);
				pstat.setString(2, areaArr[1]);
				pstat.setString(3, areaArr[2]);
				pstat.setString(4, areaArr[3]);
				pstat.setString(5, areaArr[4]);
				pstat.setString(6, areaArr[5]);
				pstat.setInt(7, grade);
				pstat.setInt(8, grade);
				pstat.setFloat(9, abv);

			}
			// 조건 6 (1 2)
			else if( t[1] && t[2] ) { 
				pstat.setString(1, alcholArr[0]);
				pstat.setString(2, alcholArr[1]);
				pstat.setString(3, alcholArr[2]);
				pstat.setString(4, alcholArr[3]);
				pstat.setString(5, alcholArr[4]);
				pstat.setString(6, areaArr[0]);
				pstat.setString(7, areaArr[1]);
				pstat.setString(8, areaArr[2]);
				pstat.setString(9, areaArr[3]);
				pstat.setString(10, areaArr[4]);
				pstat.setString(11, areaArr[5]);

			}
			// 조건 7 (1 3)
			else if( t[1] && t[3] ) { 
				pstat.setString(1, alcholArr[0]);
				pstat.setString(2, alcholArr[1]);
				pstat.setString(3, alcholArr[2]);
				pstat.setString(4, alcholArr[3]);
				pstat.setString(5, alcholArr[4]);
				pstat.setInt(6, grade);
				pstat.setInt(7, grade);

			}
			// 조건 8 (1 4)
			else if( t[1] && t[4] ) { 
				pstat.setString(1, alcholArr[0]);
				pstat.setString(2, alcholArr[1]);
				pstat.setString(3, alcholArr[2]);
				pstat.setString(4, alcholArr[3]);
				pstat.setString(5, alcholArr[4]);
				pstat.setFloat(6, abv);

			}

			// 조건 9 (2 3)
			else if( t[2] && t[3]) {
				pstat.setString(1, areaArr[0]);
				pstat.setString(2, areaArr[1]);
				pstat.setString(3, areaArr[2]);
				pstat.setString(4, areaArr[3]);
				pstat.setString(5, areaArr[4]);
				pstat.setString(6, areaArr[5]);
				pstat.setInt(7, grade);
				pstat.setInt(8, grade);

			}
			// 조건 10 (2 4)
			else if(t[2] && t[4]) { // 조건 8
				pstat.setString(1, areaArr[0]);
				pstat.setString(2, areaArr[1]);
				pstat.setString(3, areaArr[2]);
				pstat.setString(4, areaArr[3]);
				pstat.setString(5, areaArr[4]);
				pstat.setString(6, areaArr[5]);
				pstat.setFloat(7, abv);

			}
			// 조건 11 (3 4)
			else if(t[3] && t[4]) { 
				pstat.setInt(1, grade);
				pstat.setInt(2, grade);
				pstat.setFloat(3, abv);

			}
			// 조건 12 (1)
			else if( t[1] ) {
				pstat.setString(1, alcholArr[0]);
				pstat.setString(2, alcholArr[1]);
				pstat.setString(3, alcholArr[2]);
				pstat.setString(4, alcholArr[3]);
				pstat.setString(5, alcholArr[4]);

			} 
			// 조건 13 (2)
			else if(t[2]) {
				pstat.setString(1, areaArr[0]);
				pstat.setString(2, areaArr[1]);
				pstat.setString(3, areaArr[2]);
				pstat.setString(4, areaArr[3]);
				pstat.setString(5, areaArr[4]);
				pstat.setString(6, areaArr[5]);

			}
			// 조건 14 (3)
			else if( t[3] ) {
				pstat.setInt(1, grade);
				pstat.setInt(2, grade);

			}
			// 조건 15 (4)
			else if( t[4] ) {
				pstat.setFloat(1, abv);
			}

			try(
					ResultSet rs = pstat.executeQuery();
					){

				List<SearchDTO> list = new ArrayList<SearchDTO>();

				while(rs.next()) {

					int index = rs.getInt("num");
					String pname = rs.getString("product_name");
					int seq = rs.getInt("seq");
					int price = rs.getInt("price");
					String kind = rs.getString("kind");
					float rAbv = rs.getFloat("abv");
					int rGrade = rs.getInt("grade");
					String smry = rs.getString("smry");
					String oriName = rs.getString("ori_name");
					String sysName = rs.getString("sys_name");

					SearchDTO dto = new SearchDTO(index, pname, seq, kind, price, rAbv, rGrade, smry, oriName, sysName);

					list.add(dto);
				}

				return list;

			}
		}
	}


	// 상세 검색 2

	public List<SearchDTO> searchDetailHasPname(boolean[] searchType, String product_name, String[] alcholArr, String[] areaArr, int grade, float abv, String sql) throws Exception{

		boolean[] t = searchType;

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){

			// 조건 1 (0 1 2 3 4)
			if (t[0] && t[1] && t[2] && t[3] && t[4]) {
				pstat.setString(1, product_name);
				pstat.setString(2, alcholArr[0]);
				pstat.setString(3, alcholArr[1]);
				pstat.setString(4, alcholArr[2]);
				pstat.setString(5, alcholArr[3]);
				pstat.setString(6, alcholArr[4]);
				pstat.setString(7, areaArr[0]);
				pstat.setString(8, areaArr[1]);
				pstat.setString(9, areaArr[2]);
				pstat.setString(10, areaArr[3]);
				pstat.setString(11, areaArr[4]);
				pstat.setString(12, areaArr[5]);
				pstat.setInt(13, grade);
				pstat.setInt(14, grade);
				pstat.setFloat(15, abv);

			}
			// 조건 2 (0 1 2 3)
			else if(t[0] && t[1] && t[2] && t[3]) { 
				pstat.setString(1, product_name);
				pstat.setString(2, alcholArr[0]);
				pstat.setString(3, alcholArr[1]);
				pstat.setString(4, alcholArr[2]);
				pstat.setString(5, alcholArr[3]);
				pstat.setString(6, alcholArr[4]);
				pstat.setString(7, areaArr[0]);
				pstat.setString(8, areaArr[1]);
				pstat.setString(9, areaArr[2]);
				pstat.setString(10, areaArr[3]);
				pstat.setString(11, areaArr[4]);
				pstat.setString(12, areaArr[5]);
				pstat.setInt(13, grade);
				pstat.setInt(14, grade);
			}
			// 조건 3 (0 1 2 4)
			else if(t[0] && t[1] && t[2] && t[4]) {
				pstat.setString(1, product_name);
				pstat.setString(2, alcholArr[0]);
				pstat.setString(3, alcholArr[1]);
				pstat.setString(4, alcholArr[2]);
				pstat.setString(5, alcholArr[3]);
				pstat.setString(6, alcholArr[4]);
				pstat.setString(7, areaArr[0]);
				pstat.setString(8, areaArr[1]);
				pstat.setString(9, areaArr[2]);
				pstat.setString(10, areaArr[3]);
				pstat.setString(11, areaArr[4]);
				pstat.setString(12, areaArr[5]);
				pstat.setFloat(13, abv);
			}

			// 조건 4 (0 1 3 4)
			else if (t[0] && t[1] && t[3] && t[4]) {
				pstat.setString(1, product_name);
				pstat.setString(2, alcholArr[0]);
				pstat.setString(3, alcholArr[1]);
				pstat.setString(4, alcholArr[2]);
				pstat.setString(5, alcholArr[3]);
				pstat.setString(6, alcholArr[4]);
				pstat.setInt(7, grade);
				pstat.setInt(8, grade);
				pstat.setFloat(9, abv);

			}

			// 조건 5 (0 2 3 4)
			else if (t[0] && t[2] && t[3] && t[4]) {
				pstat.setString(1, product_name);
				pstat.setString(2, areaArr[0]);
				pstat.setString(3, areaArr[1]);
				pstat.setString(4, areaArr[2]);
				pstat.setString(5, areaArr[3]);
				pstat.setString(6, areaArr[4]);
				pstat.setString(7, areaArr[5]);
				pstat.setInt(8, grade);
				pstat.setInt(9, grade);
				pstat.setFloat(10, abv);

			}
			// 조건 6 (0 1 2)
			else if(t[0] && t[1] && t[2] ) { 
				pstat.setString(1, product_name);
				pstat.setString(2, alcholArr[0]);
				pstat.setString(3, alcholArr[1]);
				pstat.setString(4, alcholArr[2]);
				pstat.setString(5, alcholArr[3]);
				pstat.setString(6, alcholArr[4]);
				pstat.setString(7, areaArr[0]);
				pstat.setString(8, areaArr[1]);
				pstat.setString(9, areaArr[2]);
				pstat.setString(10, areaArr[3]);
				pstat.setString(11, areaArr[4]);
				pstat.setString(12, areaArr[5]);

			}
			// 조건 7 (0 1 3)
			else if(t[0] && t[1] && t[3] ) { 
				pstat.setString(1, product_name);
				pstat.setString(2, alcholArr[0]);
				pstat.setString(3, alcholArr[1]);
				pstat.setString(4, alcholArr[2]);
				pstat.setString(5, alcholArr[3]);
				pstat.setString(6, alcholArr[4]);
				pstat.setInt(7, grade);
				pstat.setInt(8, grade);

			}
			// 조건 8 (0 1 4)
			else if(t[0] && t[1] && t[4] ) { 
				pstat.setString(1, product_name);
				pstat.setString(2, alcholArr[0]);
				pstat.setString(3, alcholArr[1]);
				pstat.setString(4, alcholArr[2]);
				pstat.setString(5, alcholArr[3]);
				pstat.setString(6, alcholArr[4]);
				pstat.setFloat(7, abv);
	
			}
			// 조건 9 (0 2 3)
			else if(t[0] && t[2] && t[3]) {
				pstat.setString(1, product_name);
				pstat.setString(2, areaArr[0]);
				pstat.setString(3, areaArr[1]);
				pstat.setString(4, areaArr[2]);
				pstat.setString(5, areaArr[3]);
				pstat.setString(6, areaArr[4]);
				pstat.setString(7, areaArr[5]);
				pstat.setInt(8, grade);
				pstat.setInt(9, grade);

			}
			// 조건 10 (0 2 4)
			else if(t[0] && t[2] && t[4]) { // 조건 8
				pstat.setString(1, product_name);
				pstat.setString(2, areaArr[0]);
				pstat.setString(3, areaArr[1]);
				pstat.setString(4, areaArr[2]);
				pstat.setString(5, areaArr[3]);
				pstat.setString(6, areaArr[4]);
				pstat.setString(7, areaArr[5]);
				pstat.setFloat(8, abv);

			}
			// 조건 11 (0 3 4)
			else if(t[0] && t[3] && t[4]) {
				pstat.setString(1, product_name);
				pstat.setInt(2, grade);
				pstat.setInt(3, grade);
				pstat.setFloat(4, abv);

			}
			// 조건 12 (0 1)
			else if(t[0] && t[1]) {
				pstat.setString(1, product_name);
				pstat.setString(2, alcholArr[0]);
				pstat.setString(3, alcholArr[1]);
				pstat.setString(4, alcholArr[2]);
				pstat.setString(5, alcholArr[3]);
				pstat.setString(6, alcholArr[4]);

			}
			// 조건 13 (0 2)
			else if(t[0] && t[2]) {
				pstat.setString(1, product_name);
				pstat.setString(2, areaArr[0]);
				pstat.setString(3, areaArr[1]);
				pstat.setString(4, areaArr[2]);
				pstat.setString(5, areaArr[3]);
				pstat.setString(6, areaArr[4]);
				pstat.setString(7, areaArr[5]);

			}
			// 조건 14 (0 3)
			else if( t[0] && t[3] ) { // 조건 11
				pstat.setString(1, product_name);
				pstat.setInt(2, grade);
				pstat.setInt(3, grade);

			}
			// 조건 15 (0 4)
			else if( t[0] && t[4] ) { // 조건 12
				pstat.setString(1, product_name);
				pstat.setFloat(2, abv);;

			} 

			try(
					ResultSet rs = pstat.executeQuery();
					){

				List<SearchDTO> list = new ArrayList<SearchDTO>();

				while(rs.next()) {

					int index = rs.getInt("num");
					String pname = rs.getString("product_name");
					int seq = rs.getInt("seq");
					int price = rs.getInt("price");
					String kind = rs.getString("kind");
					float rAbv = rs.getFloat("abv");
					int rGrade = rs.getInt("grade");
					String smry = rs.getString("smry");
					String oriName = rs.getString("ori_name");
					String sysName = rs.getString("sys_name");

					SearchDTO dto = new SearchDTO(index, pname, seq, kind, price, rAbv, rGrade, smry, oriName, sysName);
					list.add(dto);
				}

				return list;

			}
		}
	}
	
	public List<SearchDTO> SearchAll() throws Exception{

		String sql = "select row_number() over(order by product_name desc) num, product_name, seq, kind, price, abv, grade, smry, ori_name, sys_name from product_info";

		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();
				){

				List<SearchDTO> list = new ArrayList<SearchDTO>();

				while(rs.next()) {

					int index = rs.getInt("num");
					String pname = rs.getString("product_name");
					int seq = rs.getInt("seq");
					int price = rs.getInt("price");
					String kind = rs.getString("kind");
					float abv = rs.getFloat("abv");
					int grade = rs.getInt("grade");
					String smry = rs.getString("smry");
					String oriName = rs.getString("ori_name");
					String sysName = rs.getString("sys_name");

					SearchDTO dto = new SearchDTO(index, pname, seq, kind, price, abv, grade, smry, oriName, sysName);
 
					list.add(dto);
				}

				return list;

		}
	}






}
