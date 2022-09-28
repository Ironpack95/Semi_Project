package SearchApp;

public class Search {

	// 쿼리문 변수
	private String defaultSql = "select row_number() over(order by product_name desc) num, product_name, seq, kind, price, abv, grade, smry, ori_name, sys_name from product_info where"; // index추가

	private String pname = " product_name like '%'||?||'%' ";

	private String achType = " (kind like ? or kind like ? or kind like ? or kind like ? or kind like ?) ";

	private String area = " (product_area like ? or product_area like ? or product_area like ? or product_area like ? or product_area like ? or product_area like ?) ";
	
	private String gradeStr = " (grade between ? and ? + 0.9) ";
	
	private String abvStr = " (abv >= ?)";

	// 대치 쿼리문
	private String[] sqlArr = new String[] {pname, achType, area, gradeStr, abvStr};

	//	boolean[] searchType = new boolean[] {true, false, false, true, true};

	// 쿼리문 반환 
	public String getSql(boolean[] searchType) {

		// 쿼리문 연결
		for (int i=0; i<searchType.length; i++) {

			if(searchType[i]) {

				defaultSql += sqlArr[i];
				
				if(i != 4) {

					if(searchType[i+1]) {

						defaultSql += "and";

					}
				}
			} else {
				
				if(i != 0 && i != 4) {

					if(searchType[i+1]) {

						defaultSql += "and";

					}
				}
			}
		}
		
		if (defaultSql.contains("whereand")) {
			
			String sql = defaultSql.replace("whereand", "where");
			
			return sql;
		}
		
		return defaultSql;
	}



}
