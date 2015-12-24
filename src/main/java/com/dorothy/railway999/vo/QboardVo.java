package com.dorothy.railway999.vo;

public class QboardVo {

	private Long qboardno;
	private String title;
	private String content;
	private Long viewcnt;
	private String createdDate;
	private Long memberno;
	private String name;
	
	public Long getQboardno() {
		return qboardno;
	}
	
	public void setQboardno(Long qboardno) {
		this.qboardno = qboardno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Long getViewcnt() {
		return viewcnt;
	}
	public void setViewcnt(Long viewcnt) {
		this.viewcnt = viewcnt;
	}

	public String getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}
	public Long getMemberno() {
		return memberno;
	}
	public void setMemberno(Long memberno) {
		this.memberno = memberno;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@Override
	public String toString() {
		return "QboardVo [qboardno=" + qboardno + ", title=" + title
				+ ", content=" + content + ", viewcnt=" + viewcnt + ", createdDate="
				+ createdDate + ", memberno=" + memberno + ", name=" + name + "]";
	}
}