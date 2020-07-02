<?php
class ControllerFooter extends Controller {
	public function index() {
		$data = array();
		return $this->load->view('footer.tpl', $data);
	}
}