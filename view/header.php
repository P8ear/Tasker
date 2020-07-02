<?php
class ControllerHeader extends Controller {
	public function index() {
		$data = array();
		return $this->load->view('header.tpl', $data);
	}
}