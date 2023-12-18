package officet.officet_dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import officet.officet_vo.Approval;
import officet.officet_vo.Approval_sch;
import officet.officet_vo.Approver;
import officet.officet_vo.Team;
import officet.officet_vo.Worker;
@Repository
public interface A02_ApprovalDao {
   public List<Approval> getApprovalList();
   public List<Approval> getApprovalList1(@Param("worker_id")int worker_id);
   public List<Approval> getApprovalList2(@Param("worker_id")int worker_id);
   public List<Approval> getApprovalList3();
   public void updateApprovalStatus(@Param("approvalId") int approvalId, @Param("status") int status);
   @Select("SELECT * FROM TEAM")
   public List<Team> getAllTeams();
   @Select("SELECT w.NAME\r\n"
         + "FROM TEAM t\r\n"
         + "JOIN WORKER w ON t.TEAM_ID = w.TEAM_ID\r\n"
         + "WHERE t.TEAM_NAME = #{team_Name}")
   public List<Worker> getWorkersByTeam(@Param("team_Name") String team_Name);
   @Select("SELECT\r\n"
         + "    a.approval_id,\r\n"
         + "    a.approval_step,\r\n"
         + "    a.approval_status,\r\n"
         + "    a.approval_request_time,\r\n"
         + "    w1.name AS worker_name,\r\n"
         + "    w2.name AS approver_name,\r\n"
         + "    t.team_name\r\n"
         + "FROM \r\n"
         + "    approval a\r\n"
         + "LEFT JOIN\r\n"
         + "    worker w1 ON a.worker_id = w1.worker_id\r\n"
         + "LEFT JOIN\r\n"
         + "    approver ap ON a.approver_id = ap.approver_id\r\n"
         + "LEFT JOIN\r\n"
         + "    worker w2 ON ap.worker_id = w2.worker_id\r\n"
         + "LEFT JOIN\r\n"
         + "    team t ON w1.team_id = t.team_id\r\n"
         + "WHERE\r\n"
         + "    w1.NAME =#{worker_name}")
   public List<Approval> getWorkersByTeamList(@Param("worker_name") String worker_name);
   // 내가 신청한 결재 - 사원명 가져오기
   @Select("SELECT w.name FROM worker w INNER JOIN team t ON w.TEAM_ID =t.TEAM_ID WHERE t.TEAM_NAME = #{team_name}")
   public List<String> getTeamWorkers(@Param("team_name") String team_name);
   
   @Select("SELECT w.name AS worker_name,\r\n"
	         + "      a.APPROVER_ID,\r\n"
	         + "      a.WORKER_ID \r\n"
	         + "            FROM approver a\r\n"
	         + "            JOIN WORKER w ON a.WORKER_ID = w.WORKER_ID")
	   public List<Approver> getApproverList();
	   @Insert("INSERT INTO APPROVAL values(approval_seq.nextval,#{worker_id},#{approver_id},0,0,sysdate,#{approval_type},#{approval_msg})")
	   public int getInsertReq(Approval ins);
	   // 내가 신청한 결재 - 사원명 가져오기
	   @Select("SELECT    MIN(a.approval_id) AS APPROVAL_ID, \r\n"
	         + "    MIN(A.APPROVAL_TYPE) AS APPROVAL_TYPE,\r\n"
	         + "    MIN(a.APPROVAL_MSG) AS APPROVAL_MSG, \r\n"
	         + "    MIN(apps.step_name) AS step_name, \r\n"
	         + "    MIN(APSN.APPROVAL_STATUS_NAME) AS status_name, \r\n"
	         + "    MIN(a.approval_request_time) AS approval_request_time,\r\n"
	         + "    MIN(t.TEAM_NAME) AS approver_team,\r\n"
	         + "    MIN(apprvr.worker_id) AS approver_num, \r\n"
	         + "    MIN(apprvr.name) AS approver,\r\n"
	         + "    MIN(t2.TEAM_NAME) AS requester_team, \r\n"
	         + "    MIN(w.WORKER_ID) AS requester_num, \r\n"
	         + "    MIN(w.name) AS requester \r\n"
	            + "FROM approval a\r\n"
	            + "INNER JOIN worker w ON w.worker_id = a.WORKER_ID \r\n"
	            + "INNER JOIN (SELECT a.approver_id, w.WORKER_ID, w.name, w.TEAM_ID \r\n"
	            + "FROM approver a INNER JOIN WORKER w ON a.WORKER_ID=w.WORKER_ID) apprvr \r\n"
	            + "ON apprvr.approver_id=a.APPROVER_ID \r\n"
	            + "LEFT JOIN approval_step apps ON apps.APPROVAL_STEP_ID =a.aPPROVAL_STEP\r\n"
	            + "LEFT JOIN APPROVAL_STATUS APSN ON APSN.APPROVAL_STATUS_ID =A.APPROVAL_STATUS \r\n"
	            + "LEFT JOIN team t ON apprvr.team_id=t.TEAM_ID\r\n"
	            + "LEFT JOIN team t2 ON w.TEAM_ID =t2.TEAM_ID \r\n"
	            + "WHERE w.name =#{requester} and t.team_name=#{approver_team} AND apprvr.name LIKE '%'||#{approver}||'%'\r\n"
	            + "GROUP BY apprvr.name")
	   public List<Approval_sch> getRequest(Approval_sch sch);
	   // 내가 신청한 결재 - 사원명 리스트 노출
	   @Select("SELECT \r\n"
	         + "     a.approval_id AS APPROVAL_ID , \r\n"
	         + "      A.APPROVAL_TYPE AS APPROVAL_TYPE ,\r\n"
	         + "      a.APPROVAL_MSG AS APPROVAL_MSG , \r\n"
	         + "      apps.step_name AS step_name, \r\n"
	         + "      APSN.APPROVAL_STATUS_NAME AS status_name, \r\n"
	         + "      a.approval_request_time AS approval_request_time,\r\n"
	         + "      t.TEAM_NAME AS approver_team,\r\n"
	         + "      apprvr.worker_id AS approver_num, \r\n"
	         + "      apprvr.name AS approver,\r\n"
	         + "      t2.TEAM_NAME as requester_team, \r\n"
	         + "      w.WORKER_ID AS requester_num, \r\n"
	         + "      w.name AS requester\r\n"
	         + "FROM approval a\r\n"
	         + "INNER JOIN worker w ON w.worker_id = a.WORKER_ID \r\n"
	         + "INNER JOIN (SELECT a.approver_id, w.WORKER_ID, w.name, w.TEAM_ID \r\n"
	         + "FROM approver a INNER JOIN WORKER w ON a.WORKER_ID=w.WORKER_ID) apprvr \r\n"
	         + "ON apprvr.approver_id=a.APPROVER_ID \r\n"
	         + "LEFT JOIN approval_step apps ON apps.APPROVAL_STEP_ID =a.aPPROVAL_STEP\r\n"
	         + "LEFT JOIN APPROVAL_STATUS APSN ON APSN.APPROVAL_STATUS_ID =A.APPROVAL_STATUS \r\n"
	         + "LEFT JOIN team t ON apprvr.team_id=t.TEAM_ID\r\n"
	         + "LEFT JOIN team t2 ON w.TEAM_ID =t2.TEAM_ID \r\n"
	         + "WHERE w.name = #{requester} AND t.team_name like '%'||#{approver_team}||'%' "
	         + "AND apprvr.name LIKE '%'||#{approver}||'%'")
	   public List<Approval_sch> getRequestList(@Param("requester") String requester,
	         @Param("approver_team")String approver_team,@Param("approver")String approver);
	   // 나에게 신청온 결재 - 사원명 가져오기
	   @Select("SELECT \r\n"
	         + "    MIN(a.approval_id) AS APPROVAL_ID, \r\n"
	         + "    MIN(A.APPROVAL_TYPE) AS APPROVAL_TYPE,\r\n"
	         + "    MIN(a.APPROVAL_MSG) AS APPROVAL_MSG, \r\n"
	         + "    MIN(apps.step_name) AS step_name, \r\n"
	         + "    MIN(APSN.APPROVAL_STATUS_NAME) AS status_name, \r\n"
	         + "    MIN(a.approval_request_time) AS approval_request_time,\r\n"
	         + "    MIN(t.TEAM_NAME) AS approver_team,\r\n"
	         + "    MIN(apprvr.worker_id) AS approver_num, \r\n"
	         + "    MIN(apprvr.name) AS approver,\r\n"
	         + "    MIN(t2.TEAM_NAME) AS requester_team, \r\n"
	         + "    MIN(w.WORKER_ID) AS requester_num, \r\n"
	         + "    MIN(w.name) AS requester\r\n"
	         + "FROM approval a\r\n"
	         + "INNER JOIN worker w ON w.worker_id = a.WORKER_ID \r\n"
	         + "INNER JOIN (\r\n"
	         + "    SELECT a.approver_id, w.WORKER_ID, w.name, w.TEAM_ID \r\n"
	         + "    FROM approver a \r\n"
	         + "    INNER JOIN WORKER w ON a.WORKER_ID = w.WORKER_ID\r\n"
	         + ") apprvr ON apprvr.approver_id = a.APPROVER_ID \r\n"
	         + "LEFT JOIN approval_step apps ON apps.APPROVAL_STEP_ID = a.APPROVAL_STEP\r\n"
	         + "LEFT JOIN APPROVAL_STATUS APSN ON APSN.APPROVAL_STATUS_ID = A.APPROVAL_STATUS \r\n"
	         + "LEFT JOIN team t ON apprvr.team_id = t.TEAM_ID\r\n"
	         + "LEFT JOIN team t2 ON w.TEAM_ID = t2.TEAM_ID \r\n"
	         + "WHERE w.name like'%'||#{requester}||'%' AND t2.team_name like'%'||#{requester_team}||'%' AND apprvr.name = #{approver}\r\n"
	         + "GROUP BY w.name")
	   public List<Approval_sch> getApprover(Approval_sch sch);
	   // 나에게 신청온 결재 - 사원명 리스트 노출
	   @Select("SELECT \r\n"
	         + "     a.approval_id AS APPROVAL_ID , \r\n"
	         + "      A.APPROVAL_TYPE AS APPROVAL_TYPE ,\r\n"
	         + "      a.APPROVAL_MSG AS APPROVAL_MSG , \r\n"
	         + "      apps.step_name AS step_name, \r\n"
	         + "      APSN.APPROVAL_STATUS_NAME AS status_name, \r\n"
	         + "      a.approval_request_time AS approval_request_time,\r\n"
	         + "      t.TEAM_NAME AS approver_team,\r\n"
	         + "      apprvr.worker_id AS approver_num, \r\n"
	         + "      apprvr.name AS approver,\r\n"
	         + "      t2.TEAM_NAME as requester_team, \r\n"
	         + "      w.WORKER_ID AS requester_num, \r\n"
	         + "      w.name AS requester\r\n"
	         + "FROM approval a\r\n"
	         + "INNER JOIN worker w ON w.worker_id = a.WORKER_ID \r\n"
	         + "INNER JOIN (SELECT a.approver_id, w.WORKER_ID, w.name, w.TEAM_ID \r\n"
	         + "FROM approver a INNER JOIN WORKER w ON a.WORKER_ID=w.WORKER_ID) apprvr \r\n"
	         + "ON apprvr.approver_id=a.APPROVER_ID \r\n"
	         + "LEFT JOIN approval_step apps ON apps.APPROVAL_STEP_ID =a.aPPROVAL_STEP\r\n"
	         + "LEFT JOIN APPROVAL_STATUS APSN ON APSN.APPROVAL_STATUS_ID =A.APPROVAL_STATUS \r\n"
	         + "LEFT JOIN team t ON apprvr.team_id=t.TEAM_ID\r\n"
	         + "LEFT JOIN team t2 ON w.TEAM_ID =t2.TEAM_ID \r\n"
	         + "WHERE w.name LIKE '%'||#{requester}||'%' "
	         + "AND t2.team_name like'%'||#{requester_team}||'%' AND apprvr.name = #{approver}")
	   public List<Approval_sch> getApproverList2(@Param("requester") String requester,
	         @Param("requester_team")String requester_team,@Param("approver")String approver);
}