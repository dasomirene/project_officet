package officet.officet_service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import officet.officet_dao.A03_AttendanceDao;
import officet.officet_vo.Attendance;
import officet.officet_vo.Attendance_sch;

@Service
public class A03_AttendanceService {

	@Autowired
	private A03_AttendanceDao dao;

	// 출결정보가져오기
	public List<Attendance> getAttSch(@Param("worker_id") int worker_id,
			@Param("check_in_status") String check_in_status, @Param("check_out_status") String check_out_status,
			@Param("year") int year, @Param("month") int month) {
		System.out.println("서비스단 도착했다>>>>>" + check_in_status);
		System.out.println("서비스단 도착했다>>>>>" + check_out_status);
		System.out.println("서비스단 도착했다>>>>>" + worker_id);
		List<Attendance> attList = dao.getAttSch(worker_id, check_in_status, check_out_status, year, month);
		return attList;
	}

	// 어드민-출결조회
	public List<Attendance_sch> getAttendanceSch(@Param("team_name") String team_name, @Param("name") String name,
			@Param("check_in_status") String check_in_status, @Param("check_out_status") String check_out_status) {
		if (team_name == null)
			team_name = "";
		if (name == null)
			name = "";
		if (check_in_status == null)
			check_in_status = "";
		if (check_out_status == null)
			check_out_status = "";
		return dao.getAttendanceSch(team_name, name, check_in_status, check_out_status);
	}

	// 어드민-출결-상세정보
	public Attendance_sch getAttendanceDetail(@Param("attendance_id") int attendance_id) {
		return dao.getAttendanceDetail(attendance_id);
	}
}
