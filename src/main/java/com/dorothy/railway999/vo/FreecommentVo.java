package com.dorothy.railway999.vo;

public class FreecommentVo {
	

	private long freecommentsNo;
	private String freeContent;
	private long freeboardNo;
	private String createdDate;
	private String memberName;
	private long memberNo;	
	
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public long getFreecommentsNo() {
		return freecommentsNo;
	}
	public void setFreecommentsNo(long freecommentsNo) {
		this.freecommentsNo = freecommentsNo;
	}
	public String getFreeContent() {
		return freeContent;
	}
	public void setFreeContent(String freeContent) {
		this.freeContent = freeContent;
	}
	public long getFreeboardNo() {
		return freeboardNo;
	}
	public void setFreeboardNo(long freeboardNo) {
		this.freeboardNo = freeboardNo;
	}

	public String getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}
	
	
	public long getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(long memberNo) {
		this.memberNo = memberNo;
	}
	@Override
	public String toString() {
		return "FreecommentVo [freecommentsNo=" + freecommentsNo
				+ ", freeContent=" + freeContent + ", freeboardNo="
				+ freeboardNo + ", createdDate=" + createdDate
				+ ", memberName=" + memberName + ", memberNo=" + memberNo + "]";
	}
	
	
	
	
}
