<?php
class ControllerUser extends Controller {
	
	public function login() {
		$json = array();
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
			if (!isset($this->request->post['username']) || !isset($this->request->post['password']) || !$this->user->login($this->request->post['username'], html_entity_decode($this->request->post['password'], ENT_QUOTES, 'UTF-8'))) {
				$json['error'] = $this->lang['error_login'];
			} else {
				$json['success'] = $this->lang['success_login'];
			}
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function logout() {
		$this->user->logout();

		$this->response->redirect('/');
	}
}