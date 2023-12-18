package officet.officet_dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import officet.officet_vo.Attendance;
import officet.officet_vo.Attendance_sch;

public interface A03_AttendanceDao {

	// 출격검색탭
	   @Select("SELECT * FROM attendance WHERE CHECK_IN_STATUS like '%'||#{check_in_status}||'%'"
	         + "and CHECK_OUT_STATUS like '%'||#{check_out_status}||'%' "
	         + "and to_char(today_date,'yyyy') like '%'||#{year}||'%' and to_char(today_date,'MM') like '%'||#{month}||'%'"
	         + "and WORKER_ID = #{worker_id} order by today_date desc")
	   public List<Attendance> getAttSch(@Param("worker_id") int worker_id, 
	                             @Param("check_in_status") String check_in_status,
	                             @Param("check_out_status") String check_out_status,
	                             @Param("year") int year,
	                             @Param("month") int month);
	   @Select("select \r\n"
		   		+ "			a.attendance_id AS ATTENDANCE_ID, \r\n"
		   		+ "			w.name AS name, \r\n"
		   		+ "			t.team_name AS team_name, \r\n"
		   		+ "			a.today_date AS today_date, \r\n"
		   		+ "			a.check_in_time AS CHECK_IN_TIME , \r\n"
		   		+ "			a.check_in_status AS CHECK_IN_STATUS , \r\n"
		   		+ "			a.CHECK_OUT_TIME AS CHECK_OUT_TIME , \r\n"
		   		+ "			a.check_out_status AS CHECK_OUT_STATUS \r\n"
		   		+ "		from attendance a\r\n"
		   		+ "		inner join worker w on w.worker_id=a.worker_id\r\n"
		   		+ "		left join team t on w.team_id=t.team_id\r\n"
		   		+ "		where t.team_name LIKE '%'||#{team_name}||'%'\r\n"
		   		+ "		and w.name like '%'||#{name}||'%' \r\n"
		   		+ "		and a.check_in_status LIKE '%'||#{check_in_status}||'%' \r\n"
		   		+ "		and a.check_out_status LIKE '%'||#{check_out_status}||'%'\r\n"
		   		+ "		ORDER BY ATTENDANCE_ID desc")
		   public List<Attendance_sch> getAttendanceSch(@Param("team_name") String team_name,
					@Param("name") String name, @Param("check_in_status") String check_in_status,
					@Param("check_out_status") String check_out_status);
		   @Select("select \r\n"
	               + "         a.attendance_id AS ATTENDANCE_ID, \r\n"
	               + "         w.name AS name, \r\n"
	               + "         t.team_name AS team_name, \r\n"
	               + "         a.today_date AS today_date, \r\n"
	               + "         a.check_in_time AS CHECK_IN_TIME , \r\n"
	               + "         a.check_in_status AS CHECK_IN_STATUS , \r\n"
	               + "         a.CHECK_OUT_TIME AS CHECK_OUT_TIME , \r\n"
	               + "         a.check_out_status AS CHECK_OUT_STATUS \r\n"
	               + "      from attendance a\r\n"
	               + "      inner join worker w on w.worker_id=a.worker_id\r\n"
	               + "      left join team t on w.team_id=t.team_id\r\n"
	               + "      where a.attendance_id = #{attendance_id}"
	               + "      ORDER BY ATTENDANCE_ID desc")
	      public Attendance_sch getAttendanceDetail(@Param("attendance_id") int attendance_id);
}
