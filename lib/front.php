<?php
final class Front {
	private $registry;
	private $error;

	public function __construct($registry) {
		$this->registry = $registry;
	}

	public function dispatch($action, $error) {
		$this->error = $error;

		while ($action) {
			$action = $this->execute($action);
		}
	}

	private function execute($action) {
		$result = $action->execute($this->registry);

		if (is_object($result)) {
			$action = $result;
		} elseif ($result === false) {
			$action = $this->error;

			$this->error = '';
		} else {
			$action = false;
		}

		return $action;
	}
}