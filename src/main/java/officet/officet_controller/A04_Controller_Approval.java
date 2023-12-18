package officet.officet_controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import officet.officet_service.A02_ApprovalService;
import officet.officet_vo.Approval;
import officet.officet_vo.Approval_sch;
import officet.officet_vo.Approver;
import officet.officet_vo.Team;
import officet.officet_vo.Worker;



@Controller
public class A04_Controller_Approval {
   // http://49.238.170.29:5070/officet/approval_req.do
@Autowired
   A02_ApprovalService apservice;

	@GetMapping("approval_req.do")
	public String approval_req() {
	   System.out.println("결재요청 페이지 접속");
	   return"WEB-INF\\views\\officet\\approval_req.jsp";
	}
	@RequestMapping("selectApprover.do")
	@ResponseBody
	public ResponseEntity<List<Approver>> getApproverList(){
	   return ResponseEntity.ok(apservice.getApproverList());
	}
	@RequestMapping("getInsertReq.do")
	@ResponseBody
	public ResponseEntity<String> getInsertReq(Approval ins){
	   return ResponseEntity.ok(apservice.getInsertreq(ins));
	}
   @RequestMapping("approval_app.do")
   public String approval_app(int worker_id, Model d) {
      System.out.println("결재승인 페이지 접속");
      List<Approval> approvalInfo = apservice.getApprovalList();
      List<Approval> approvalInfo1 = apservice.getApprovalList1(worker_id);
      List<Approval> approvalInfo2 = apservice.getApprovalList2(worker_id);
      d.addAttribute("approvalInfo",approvalInfo);
      d.addAttribute("approvalInfo1",approvalInfo1);
      d.addAttribute("approvalInfo2",approvalInfo2);
      return"WEB-INF\\views\\officet\\approval_app.jsp";
   }
   @PostMapping("updateApprovalStatus.do")
   @ResponseBody
   public String updateApprovalStatus(@RequestParam("approvalId") int approvalId,
           @RequestParam("status") int status) {
       apservice.updateApprovalStatus(approvalId, status);
       return "success";
   }
   @RequestMapping("approval_status.do")
   public String approval_status(Model d) {
      System.out.println("결재현황 페이지 접속");
      List<Approval> approvalInfo3 = apservice.getApprovalList3();
      d.addAttribute("approvalInfo3",approvalInfo3);
      return"WEB-INF\\views\\officet\\approval_status.jsp";
   }
   @RequestMapping("getTeamList.do")
   @ResponseBody
   public ResponseEntity<List<Team>> getTeamList() {
       return ResponseEntity.ok(apservice.getAllTeams());
   }

   @RequestMapping("getWorkerListByTeam.do")
   @ResponseBody
   public ResponseEntity<List<Worker>> getWorkerListByTeam(@RequestParam("team_Name") String team_Name) {
       return ResponseEntity.ok(apservice.getWorkersByTeam(team_Name));
   }
   @RequestMapping("getWorkersByTeamList.do")
   @ResponseBody
   public ResponseEntity<List<Approval>> getWorkersByTeamList(@RequestParam("worker_Name") String worker_Name) {
      return ResponseEntity.ok(apservice.getWorkersByTeamList(worker_Name));
   }
   // 내가 신청한 결재
   @RequestMapping("getTeamWorker.do")
   @ResponseBody
   public ResponseEntity<List<String>> getTeamWorkers(@RequestParam("team_name") String team_name){
      System.out.println("컨트롤단 >>>>"+team_name);
      return ResponseEntity.ok(apservice.getTeamWorkers(team_name));
   }
   @RequestMapping("getRequest.do")
   @ResponseBody
   public ResponseEntity<List<Approval_sch>> getRequest(Approval_sch sch){
      System.out.println("컨트롤단 요청 결재 리스트 >>>>"+sch);
      return ResponseEntity.ok(apservice.getRequest(sch));
      
   }
   @RequestMapping("getRequestList.do")
   public ResponseEntity<List<Approval_sch>> getRequestList(
         @RequestParam("requester")String requester,
         @RequestParam("approver_team")String approver_team,
         @RequestParam("approver")String approver){
      
      return ResponseEntity.ok(apservice.getRequestList(requester, approver_team, approver));
   }
   @RequestMapping("getApprover.do")
   @ResponseBody
   public ResponseEntity<List<Approval_sch>> getApprover(Approval_sch sch){
      System.out.println("컨트롤단 요청 결재 리스트 >>>>"+sch);
      return ResponseEntity.ok(apservice.getApprover(sch));
      
   }
   @RequestMapping("getApproverList2.do")
   public ResponseEntity<List<Approval_sch>> getApproverList2(
         @RequestParam("requester")String requester,
         @RequestParam("requester_team")String requester_team,
         @RequestParam("approver")String approver){
      
      return ResponseEntity.ok(apservice.getApproverList2(requester, requester_team, approver));
   }
   
}