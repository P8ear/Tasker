<?php

require_once('config.php');

function clean($data) {
	if (is_array($data)) {
		foreach ($data as $key => $value) {
   			$data[clean($key)] = clean($value);
		}
	} else {
		$data = stripslashes($data);
	}
	return $data;
}

$_GET = clean($_GET);
$_POST = clean($_POST);
$_COOKIE = clean($_COOKIE);

function lib($class) {
	$file = ROOTDIR . 'lib/' . str_replace('\\', '/', strtolower($class)) . '.php';

	if (is_file($file)) {
		include_once($file);

		return true;
	} else {
		return false;
	}
}
spl_autoload_register('lib');
spl_autoload_extensions('.php');

require_once(ROOTDIR . 'lib/controller.php');
require_once(ROOTDIR . 'lib/model.php');

$registry = new Registry();

$language = 'russian';
require_once(ROOTDIR.'language/'.$language.'.php'); // $lang = array();
$registry->set('lang', $lang);

// Loader
$loader = new Loader($registry);
$registry->set('load', $loader);
// Database
$db = new DB(DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE, DB_PORT);
$registry->set('db', $db);
// Log
$log = new Log('error.log');

function error_handler($code, $message, $file, $line) {
	global $log;

	// error suppressed with @
	if (error_reporting() === 0) {
		return false;
	}

	switch ($code) {
		case E_NOTICE:
		case E_USER_NOTICE:
			$error = 'Notice';
			break;
		case E_WARNING:
		case E_USER_WARNING:
			$error = 'Warning';
			break;
		case E_ERROR:
		case E_USER_ERROR:
			$error = 'Fatal Error';
			break;
		default:
			$error = 'Unknown';
			break;
	}

	$log->write('PHP ' . $error . ':  ' . $message . ' in ' . $file . ' on line ' . $line);

	return true;
}
// Error Handler
set_error_handler('error_handler');

// Request
$request = new Request();
$registry->set('request', $request);


// Response
$response = new Response();
$response->addHeader('Content-Type: text/html; charset=utf-8');
$registry->set('response', $response);

$session = new Session();
$registry->set('session', $session);

// Document
$registry->set('document', new Document());

// User
$user = new User($registry);
$registry->set('user', $user);

// Front Controller
$controller = new Front($registry);

// Router
if (isset($request->get['route'])) {
	$action = new Action($request->get['route']);
} else {
	$action = new Action('main');
}

// Dispatch
$controller->dispatch($action, new Action('not_found'));

// Output
$response->output();