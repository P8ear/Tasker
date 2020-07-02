<?php
class ControllerNotFound extends Controller {
	public function index() {

		$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

		$this->document->setTitle($this->lang['text_not_found']);

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->lang['text_home'],
			'href' => '/',
		);
		$data['breadcrumbs'][] = array(
			'text' => $this->lang['text_not_found'],
			'href' => '#',
		);

		$data['text_error'] = $this->lang['text_not_found'];

		$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');


		$data['footer'] = $this->load->controller('footer');
		$data['header'] = $this->load->controller('header');

		$this->response->setOutput($this->load->view('not_found.tpl', $data));
	}
}