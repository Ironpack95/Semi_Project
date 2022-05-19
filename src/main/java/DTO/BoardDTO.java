package DTO;

import java.sql.Date;
import java.sql.Timestamp;

public class BoardDTO {
	private int boardNum; // 게시판 번호
	private String writer; // 작성자이름
	private String title; // 제목
	private String boardExp; // 내용
	private int boardLike; // 좋아여 개수
	private int boardCount; // 조회수
	private Timestamp writeDate; // 작성 날짜
	private int boardSatus; // 상태
	
	public BoardDTO() {
	}

	public BoardDTO(int boardNum, String writer, String title, String boardExp, int boardLike, int boardCount,
			Timestamp writeDate, int boardSatus) {
		super();
		this.boardNum = boardNum;
		this.writer = writer;
		this.title = title;
		this.boardExp = boardExp;
		this.boardLike = boardLike;
		this.boardCount = boardCount;
		this.writeDate = writeDate;
		this.boardSatus = boardSatus;
	}

	public int getBoardNum() {
		return boardNum;
	}

	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getBoardExp() {
		return boardExp;
	}

	public void setBoardExp(String boardExp) {
		this.boardExp = boardExp;
	}

	public int getBoardLike() {
		return boardLike;
	}

	public void setBoardLike(int boardLike) {
		this.boardLike = boardLike;
	}

	public int getBoardCount() {
		return boardCount;
	}

	public void setBoardCount(int boardCount) {
		this.boardCount = boardCount;
	}

	public Timestamp getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Timestamp writeDate) {
		this.writeDate = writeDate;
	}

	public int getBoardSatus() {
		return boardSatus;
	}

	public void setBoardSatus(int boardSatus) {
		this.boardSatus = boardSatus;
	}
}