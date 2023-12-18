package officet.officet_controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import officet.officet_service.A01_WorkerService;
import officet.officet_service.imgService;
import officet.officet_vo.Worker;

@Controller
public class A03_Controller_Profile {
	// http://49.238.170.29:5070/officet/profile.do
	@Autowired
	private A01_WorkerService service;
	@Autowired
	private imgService imgService;

	// 프로필 조회
	   @RequestMapping("profile.do")
	   public String profile(HttpServletRequest request, Model model) {
	      HttpSession session = request.getSession();
	      int worker_id = (int) session.getAttribute("worker_id");
	      Worker w = service.getProfile(worker_id);
	      w.setHire_dateS(service.getHireDate(worker_id));
	      System.out.println(w.getHire_dateS());
	      model.addAttribute("userInfo", w);
	      System.out.println("프로필 페이지 접속");
	      return "WEB-INF\\views\\officet\\profile.jsp";
	   }



	// sidebar, topbar 등 마이페이지 이동 시, session객체 id 넘기도록

	// 정보 수정 페이지
	   @RequestMapping("profile_edit.do")
	   public String profile_edit(HttpServletRequest request, Model model) {
	      System.out.println("정보 수정 페이지 접속");
	      HttpSession session = request.getSession();
	      int worker_id = (int) session.getAttribute("worker_id");
	      Worker w = service.getProfile(worker_id);
	      w.setHire_dateS(service.getHireDate(worker_id));
	      System.out.println(w.getHire_dateS());
	      model.addAttribute("worker", w);
	      return "WEB-INF\\views\\officet\\profile_edit.jsp";
	   }
	// 프로필 수정 controller
       @PostMapping("try/profile_edit.do")
       @ResponseBody
       public String try_profile_edit(
                               Worker worker,
                               @RequestPart("report") MultipartFile mf,
                               Model model) {
         System.out.println("프로필 수정 시도");
          // 이미지 업로드(이미지 수정)
         System.out.println(imgService.uploadFile(mf, worker.getWorker_id()));
         // 프로필 수정(닉네임, 전화번호, 지역)
         String msg = "";
         msg = service.uptProfile(worker);
         System.out.println(msg);
         return msg;
       }

}
