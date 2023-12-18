package officet.officet_dao;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

public interface A04_FileUploadDao {
	@Update("UPDATE worker_img\r\n"
			+ "SET fname=#{fname}\r\n"
			+ "WHERE WORKER_ID = #{worker_id}")
	public void uptFileInfo(@Param("fname") String fname,
							@Param("worker_id") int worker_id);
}
