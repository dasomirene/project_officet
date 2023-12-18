package officet.officet_vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Attendance_sch {
   private int attendance_id;
   private String name;
   private String team_name;
   @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy년 MM월 dd일", timezone = "Asia/Seoul")
   private String today_date;
   @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="HH:mm:ss", timezone = "Asia/Seoul")
   private Date check_in_time;
   private String check_in_status;
   @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="HH:mm:ss", timezone = "Asia/Seoul")
   private Date check_out_time;
   private String check_out_status;
   public Attendance_sch() {
      super();
      // TODO Auto-generated constructor stub
   }
   
   public Attendance_sch(int attendance_id, String name, String team_name, String today_date, Date check_in_time,
         String check_in_status, Date check_out_time, String check_out_status) {
      this.attendance_id = attendance_id;
      this.name = name;
      this.team_name = team_name;
      this.today_date = today_date;
      this.check_in_time = check_in_time;
      this.check_in_status = check_in_status;
      this.check_out_time = check_out_time;
      this.check_out_status = check_out_status;
   }

   public Attendance_sch(int attendance_id, String name, String team_name, Date check_in_time, String check_in_status,
         Date check_out_time, String check_out_status) {
      super();
      this.attendance_id = attendance_id;
      this.name = name;
      this.team_name = team_name;
      this.check_in_time = check_in_time;
      this.check_in_status = check_in_status;
      this.check_out_time = check_out_time;
      this.check_out_status = check_out_status;
   }
   
   public String getToday_date() {
      return today_date;
   }

   public void setToday_date(String today_date) {
      this.today_date = today_date;
   }

   public int getAttendance_id() {
      return attendance_id;
   }
   public void setAttendance_id(int attendance_id) {
      this.attendance_id = attendance_id;
   }
   public String getName() {
      return name;
   }
   public void setName(String name) {
      this.name = name;
   }
   public String getTeam_name() {
      return team_name;
   }
   public void setTeam_name(String team_name) {
      this.team_name = team_name;
   }
   public Date getCheck_in_time() {
      return check_in_time;
   }
   public void setCheck_in_time(Date check_in_time) {
      this.check_in_time = check_in_time;
   }
   public String getCheck_in_status() {
      return check_in_status;
   }
   public void setCheck_in_status(String check_in_status) {
      this.check_in_status = check_in_status;
   }
   public Date getCheck_out_time() {
      return check_out_time;
   }
   public void setCheck_out_time(Date check_out_time) {
      this.check_out_time = check_out_time;
   }
   public String getCheck_out_status() {
      return check_out_status;
   }
   public void setCheck_out_status(String check_out_status) {
      this.check_out_status = check_out_status;
   }
   
}