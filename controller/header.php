<?php
class ControllerHeader extends Controller {
	public function index() {
		$data = array();

		$data['site_name'] = $this->lang['site_name'];

		$data['title'] = $this->document->getTitle();
		if (isset($this->request->get['page'])) {
			$data['title'] .= ' - '. (int)$this->request->get['page']." ".$this->lang['text_page'];
		}
		if(empty($data['title'])) {
			$data['title'] = $this->lang['site_name'];
		}
		$data['user'] = '';
		if($data['logged'] = $this->user->isLogged()) {
			$data['user'] = $this->user->getUserName();
		}
		$data['text_login'] = $this->lang['text_login'];
		$data['text_logout'] = $this->lang['text_logout'];
		$data['text_username'] = $this->lang['text_username'];
		$data['text_password'] = $this->lang['text_password'];

		$data['button_login'] = $this->lang['button_login'];

		return $this->load->view('header.tpl', $data);
	}
}