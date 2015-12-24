package com.dorothy.railway999.vo;

public class QcommentsVo {

	private Long qcommentsno;
	private String qcontent;
	private Long qboardno;
	private String createdDate;
	private String name;
	private Long memberno;
	
	public Long getQcommentsno() {
		return qcommentsno;
	}
	public void setQcommentsno(Long qcommentsno) {
		this.qcommentsno = qcommentsno;
	}
	public String getQcontent() {
		return qcontent;
	}
	public void setQcontent(String qcontent) {
		this.qcontent = qcontent;
	}
	public Long getQboardno() {
		return qboardno;
	}
	public void setQboardno(Long qboardno) {
		this.qboardno = qboardno;
	}
	public String getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Long getMemberno() {
		return memberno;
	}
	public void setMemberno(Long memberno) {
		this.memberno = memberno;
	}
	@Override
	public String toString() {
		return "QcommentsVo [qcommentsno=" + qcommentsno + ", qcontent="
				+ qcontent + ", qboardno=" + qboardno + ", createdDate="
				+ createdDate + ", name=" + name + ", memberno=" + memberno
				+ "]";
	}
}