<?php
class ControllerMain extends Controller {
	private $error = '';
	
	public function index() {
		$data = array();

		$this->document->setTitle($this->lang['title_task']);
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->lang['text_home'],
			'href' => '#',
		);
		
		
		$data['text_sort'] = $this->lang['text_sort'];
		$data['text_task_name'] = $this->lang['text_task_name'];
		$data['text_task_email'] = $this->lang['text_task_email'];
		$data['text_task_text'] = $this->lang['text_task_text'];
		$data['text_task_status'] = $this->lang['text_task_status'];
		$data['error_task_empty'] = $this->lang['error_task_empty'];
		
		$data['text_add_task'] = $this->lang['text_add_task'];
		$data['text_edit_task'] = $this->lang['text_edit_task'];
		$data['text_yes'] = $this->lang['text_yes'];
		$data['text_no'] = $this->lang['text_no'];
		$data['button_add'] = $this->lang['button_add'];
		$data['button_save'] = $this->lang['button_save'];
		$data['logged'] = $this->user->isLogged();
		
		$url = '/?route=main';
		if (isset($this->request->get['page'])) {
			$url = '&page='.(int)$this->request->get['page'];
		}
		
		$data['sorts'] = array();
		$data['sorts'][] = array(
			'text'  => $this->lang['text_sort_default'],
			'value' => 'task_id-DESC',
			'href'  => $url. '&sort=task_id&order=DESC',
		);
		$data['sorts'][] = array(
			'text'  => $this->lang['text_sort_name_a'],
			'value' => 'name-ASC',
			'href'  => $url. '&sort=name&order=ASC',
		);
		$data['sorts'][] = array(
			'text'  => $this->lang['text_sort_name_d'],
			'value' => 'name-DESC',
			'href'  => $url. '&sort=name&order=DESC',
		);
		$data['sorts'][] = array(
			'text'  => $this->lang['text_sort_email_a'],
			'value' => 'email-ASC',
			'href'  => $url. '&sort=email&order=ASC',
		);
		$data['sorts'][] = array(
			'text'  => $this->lang['text_sort_email_d'],
			'value' => 'email-DESC',
			'href'  => $url. '&sort=email&order=DESC',
		);
		$data['sorts'][] = array(
			'text'  => $this->lang['text_sort_status_a'],
			'value' => 'status-DESC',
			'href'  => $url. '&sort=status&order=DESC',
		);
		$data['sorts'][] = array(
			'text'  => $this->lang['text_sort_status_d'],
			'value' => 'status-ASC',
			'href'  => $url. '&sort=status&order=ASC',
		);

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$limit = 3;
		
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'task_id';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'DESC';
		}
		
		$data['sort'] = $sort;
		$data['order'] = $order;

		$data['tasks'] = array();

		$this->load->model('task');
		$filter_data = array(
			'sort' => $sort,
			'order'  => $order,
			'start' => ($page - 1) * $limit,
			'limit' => $limit,
		);
		$tasks_total = $this->model_task->getTasksTotal();
		$data['tasks'] = $this->model_task->getTasks($filter_data);

		$url = '/?route=main';
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $tasks_total;
		$pagination->page = $page;
		$pagination->limit = $limit;
		$pagination->url =  $url . '&page={page}';

		$data['pagination'] = $pagination->render();

		$data['footer'] = $this->load->controller('footer');
		$data['header'] = $this->load->controller('header');

		$this->response->setOutput($this->load->view('main.tpl', $data));
	}
	
	public function addTask() {
		$json = array();
		if($this->validate()) {
			$this->load->model('task');
			$this->model_task->addTask($this->request->post);
			$json['success'] = true;
		} else {
			$json['error'] = $this->error;
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	public function editTask() {
		$json = array();
		if($this->user->isLogged()) {
			if($this->validate()) {
				$this->load->model('task');
				$this->model_task->editTask($this->request->post);
				$json['success'] = $this->lang['success_task_edit'];
			} else {
				$json['error'] = $this->error;
			}
		} else {
			$json['error'] = $this->lang['error_not_logged'];
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	private function validate() {
		if(!isset($this->request->post['name']) || empty($this->request->post['name'])) {
			$this->error .= $this->lang['error_task_name'].'<br>';
		}
		if(!isset($this->request->post['email']) || empty($this->request->post['email'])) {
			$this->error .= $this->lang['error_task_email'].'<br>';
		} elseif(!filter_var($this->request->post['email'], FILTER_VALIDATE_EMAIL)) {
			$this->error .= $this->lang['error_task_email_fail'].'<br>';
		}
		if(!isset($this->request->post['task']) || empty($this->request->post['task'])) {
			$this->error .= $this->lang['error_task_task'].'<br>';
		}
		if(isset($this->request->post['task_id']) && (int)$this->request->post['task_id'] == 0) {
			$this->error .= $this->lang['error_task_task_id'].'<br>';
		} elseif(isset($this->request->post['task_id']) && (int)$this->request->post['task_id'] > 0) {
			if(!isset($this->request->post['status'])) {
				$this->error .= $this->lang['error_task_status'].'<br>';
			}			
		}
		
		return empty($this->error);
	}
}