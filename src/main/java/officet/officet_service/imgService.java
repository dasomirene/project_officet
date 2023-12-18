package officet.officet_service;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import officet.officet_dao.A04_FileUploadDao;

@Service
public class imgService {
	@Autowired
	private A04_FileUploadDao dao;
	@Value("${upload.path}")
	private String path;
	public String uploadFile(MultipartFile mf, int worker_id) {
		String msg = "업로드 성공.";
//		MultipartFile mf = vo.getFileInfo();
			String fname = mf.getOriginalFilename();
			// 파일 객체 생성(path + fname)
			File f = new File(path+fname);
			try {
				mf.transferTo(f);
			} catch (IllegalStateException e) {
				System.out.println("파일 업로드 에러 1: " + e.getMessage());
				msg ="파일 업로드 에러 1: " + e.getMessage();
				System.out.println(msg);
			} catch (IOException e) {
				System.out.println("파일 업로드 에러 2: " + e.getMessage());
				msg ="파일 업로드 에러 2: " + e.getMessage();
				System.out.println(msg);
			}
			// 업로드 성공시 db에 저장
			if(msg.equals("업로드 성공.")) {
				dao.uptFileInfo(fname,worker_id);
				System.out.println(msg);
			}else{
				msg="파일이 첨부되지 않았습니다.";
			}
		return msg;
	}
}
