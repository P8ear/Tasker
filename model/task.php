<?php
class ModelTask extends Model {
	
	public function addTask($data = array()) {
		
		$sql = "INSERT INTO task SET name='".$this->db->escape($data['name'])."', email='".$this->db->escape($data['email'])."', task='".$this->db->escape($data['task'])."'";
		
		$this->db->query($sql);
		
		return $this->db->getLastId();
	}
	public function editTask($data = array()) {
		
		$sql = "UPDATE task SET name='".$this->db->escape($data['name'])."', email='".$this->db->escape($data['email'])."', task='".$this->db->escape($data['task'])."', status='".(int)$data['status']."' ";
		
		$check = $this->db->query("SELECT edited, task FROM task WHERE task_id=".(int)$data['task_id']);
		if($check->row['edited'] == 0 && $check->row['task'] != $this->db->escape($data['task'])) {
			$sql .= ", edited='1' ";
		}
		
		$sql .= " WHERE task_id=".(int)$data['task_id'];
		
		$this->db->query($sql);
		
	}
	public function getTasksTotal() {
		$sql = "SELECT COUNT(*) AS total FROM task ";
		$query = $this->db->query($sql);
		
		return $query->row['total'];
	}
	
	public function getTasks($data = array()) {
		$sql = "SELECT * FROM task ";
		
		$sort_data = array(
			'name',
			'email',
			'status'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY task_id";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

		}
		
		$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		$query = $this->db->query($sql);
		
		return $query->rows;
		
	}
}