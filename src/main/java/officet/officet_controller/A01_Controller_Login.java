package officet.officet_controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import officet.officet_service.A01_WorkerService;
import officet.officet_vo.Worker;

@Controller
public class A01_Controller_Login {
	// http://49.238.170.29:5070/officet/login.do
	
	@Autowired
	A01_WorkerService service;
	
	@RequestMapping("login.do")
	public String login() {
		System.out.println("로그인 페이지 접속");
		return "WEB-INF\\views\\officet\\login.jsp";
	}
	@RequestMapping(value="loginCheck.do")
	   @ResponseBody
	   public String loginCheck(HttpServletRequest request, Model d,
	                     @RequestParam("worker_id") int worker_id,
	                     @RequestParam("pass") String pass) {
	      System.out.println("아이디 : "+worker_id);
	      HttpSession session = request.getSession();
	      boolean result = true;
	      Worker w = service.loginCheck(worker_id, pass);
	      Worker w2 = service.getProfile(worker_id);
	      if(w==null) {
	         System.out.println("로그인 실패 >>>>");
	         result=false;
	      } else {
	         session.setAttribute("worker_id", w.getWorker_id());
	         session.setAttribute("auth", w.getAuth());
	         session.setAttribute("name", w.getName());
	         session.setAttribute("userInfo", w2);
	      }
	      String resultS = String.valueOf(result);
	      System.out.println("자바단 결과값>>>>>>>>>"+resultS);
	      return resultS;
	}
	// 사원 id찾기
	   @RequestMapping("/findId.do")
	   public ResponseEntity<String> findId(Worker worker) {
	      return ResponseEntity.ok(service.findId(worker));
	   }
	// 비밀번호 재설정 전 사원 유무 체크
	   @RequestMapping("/checkWorker.do")
	   public ResponseEntity<String> checkWorker(Worker worker){
	      return ResponseEntity.ok(service.checkWorker(worker));
	   }
	   
	// 비밀번호 재설정
	   @RequestMapping("/uptPass.do")
	   public ResponseEntity<String> uptPass(Worker worker){
	      return ResponseEntity.ok(service.uptPass(worker));
	   }

	
}
