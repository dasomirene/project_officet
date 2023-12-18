package officet.officet_service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import officet.officet_dao.A02_ApprovalDao;
import officet.officet_vo.Approval;
import officet.officet_vo.Approval_sch;
import officet.officet_vo.Approver;
import officet.officet_vo.Team;
import officet.officet_vo.Worker;
@Service
public class A02_ApprovalService {
   @Autowired
   private A02_ApprovalDao dao;
   
   public List<Approval> getApprovalList(){      
      System.out.println("getApprovalList 불러오기");
      return dao.getApprovalList(); 
   }
   public List<Approval> getApprovalList1(int worker_id){      
	      System.out.println("getApprovalList1 불러오기");
	      return dao.getApprovalList1(worker_id); 
	   }
	   public List<Approval> getApprovalList2(int worker_id){      
	      System.out.println("getApprovalList2 불러오기");
	      return dao.getApprovalList2(worker_id); 
	   }
   public List<Approval> getApprovalList3(){      
	      System.out.println("getApprovalList3 불러오기");
	      return dao.getApprovalList3(); 
	   }

   public void updateApprovalStatus(int approvalId, int status) {
       dao.updateApprovalStatus(approvalId, status);
   }
   public List<Team> getAllTeams() {
       return dao.getAllTeams();
   }

   public List<Worker> getWorkersByTeam(String team_Name) {
       return dao.getWorkersByTeam(team_Name);
   }
   public List<Approval> getWorkersByTeamList(String worker_Name) {
      return dao.getWorkersByTeamList(worker_Name);
   }
   // 내가 신청한 결재 - 팀원 이름 가져오기
   public List<String> getTeamWorkers(String team_name){
      List<String> workers = dao.getTeamWorkers(team_name);
      System.out.println("서비스단 >?>>>:>>>>");
      for(int cnt = 0; cnt<workers.size(); cnt++) {
         System.out.println(workers.get(cnt));
      }
      return dao.getTeamWorkers(team_name);
   }
   public List<Approver> getApproverList(){
	      return dao.getApproverList();
	   }
	   public String getInsertreq(Approval ins) {
	      return dao.getInsertReq(ins)>0?"등록성공":"등록실패";
	      
	   }
	   public List<Approval_sch> getRequest(Approval_sch sch){
	         if(sch.getRequester()==null) sch.setRequester("");
	         if(sch.getApprover_team()==null) sch.setApprover_team("");
	         if(sch.getApprover()==null)sch.setApprover("");
	         System.out.println("서비스단 요청자 >>>>"+sch);
	      return dao.getRequest(sch);
	   }
	   public List<Approval_sch> getRequestList(String requester,String approver_team,String approver){
	      if(requester==null) requester="";
	      if(approver_team==null) approver_team="";
	      if(approver==null) approver="";
	      return dao.getRequestList(requester,approver_team,approver);
	   }
	   public List<Approval_sch> getApprover(Approval_sch sch){
	      if(sch.getRequester()==null) sch.setRequester("");
	      if(sch.getRequester_team()==null) sch.setRequester_team("");
	      if(sch.getApprover()==null)sch.setApprover("");
	      System.out.println("서비스단 요청자 >>>>"+sch);
	      return dao.getApprover(sch);
	   }
	   public List<Approval_sch> getApproverList2(String requester,String requester_team,String approver){
	      System.out.println("서비스단 요청자 >>>>");
	      if(requester==null) requester="";
	      if(requester_team==null) requester_team="";
	      if(approver==null) approver="";
	      return dao.getApproverList2(requester,requester_team,approver);
	   }

}