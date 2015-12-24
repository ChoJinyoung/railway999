package com.dorothy.railway999.vo;

public class MyTravelTimeVo {
	private int id;
	private String title;
	private String start;
	private String end;
	private String allDay;
	private long travelNo;
	private String year;
	private String month;
	private String date;
	private String day;
	
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public String getAllDay() {
		return allDay;
	}
	public void setAllDay(String allDay) {
		this.allDay = allDay;
	}
	public long getTravelNo() {
		return travelNo;
	}
	public void setTravelNo(long travelNo) {
		this.travelNo = travelNo;
	}
	
	
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	@Override
	public String toString() {
		return "MyTravelTimeVo [id=" + id + ", title=" + title + ", start="
				+ start + ", end=" + end + ", allDay=" + allDay + ", travelNo="
				+ travelNo + ", year=" + year + ", month=" + month + ", date="
				+ date + ", day=" + day + "]";
	}
	
}
