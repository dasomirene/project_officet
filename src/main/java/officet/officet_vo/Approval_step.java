package officet.officet_vo;

public class Approval_step {
	private int approval_step_id;
	private String step_name;
	private String step_seq;
	public Approval_step() {
	}
	public Approval_step(int approval_step_id, String step_name, String step_seq) {
		super();
		this.approval_step_id = approval_step_id;
		this.step_name = step_name;
		this.step_seq = step_seq;
	}
	public int getApproval_step_id() {
		return approval_step_id;
	}
	public void setApproval_step_id(int approval_step_id) {
		this.approval_step_id = approval_step_id;
	}
	public String getStep_name() {
		return step_name;
	}
	public void setStep_name(String step_name) {
		this.step_name = step_name;
	}
	public String getStep_seq() {
		return step_seq;
	}
	public void setStep_seq(String step_seq) {
		this.step_seq = step_seq;
	}
	
	
}
