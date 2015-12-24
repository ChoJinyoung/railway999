package com.dorothy.railway999.vo;

public class FreeboardVo {
	
	private long freeboardNo;
	private String freeboardTitle;
	private String freeboardContent;
	private long viewCnt;
	private String createdDate;
	private long memberNo;
	private String memberName;
	
	public long getFreeboardNo() {
		return freeboardNo;
	}
	public void setFreeboardNo(long freeboardNo) {
		this.freeboardNo = freeboardNo;
	}
	public String getFreeboardTitle() {
		return freeboardTitle;
	}
	public void setFreeboardTitle(String freeboardTitle) {
		this.freeboardTitle = freeboardTitle;
	}
	public String getFreeboardContent() {
		return freeboardContent;
	}
	public void setFreeboardContent(String freeboardContent) {
		this.freeboardContent = freeboardContent;
	}
	public long getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(long viewCnt) {
		this.viewCnt = viewCnt;
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
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	
	@Override
	public String toString() {
		return "FreeboardVo [freeboardNo=" + freeboardNo + ", freeboardTitle="
				+ freeboardTitle + ", freeboardContent=" + freeboardContent
				+ ", viewCnt=" + viewCnt + ", createdDate=" + createdDate
				+ ", memberNo=" + memberNo + ", memberName=" + memberName + "]";
	}

}
