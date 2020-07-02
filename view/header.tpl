<!DOCTYPE HTML>
<html lang="en-US">
<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title><?php echo $title; ?></title>
	<script src="/view/js/jquery-2.1.1.min.js" type="text/javascript"></script>
	<link href="/view/js/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
	<script src="/view/js/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
	<link href="/view/css/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="/view/css/style.css?v=<?php echo time(); ?>" />
	<script src="/view/js/script.js" type="text/javascript"></script>
</head>
<body>
	<header>
		<div class="container">
			<div class="row">
				<div class="col-sm-8">
					<div class="tsTitle">
						<a href="/"><?php echo $site_name; ?></a>
					</div>
				</div>
				<div class="col-sm-4 text-right userZone">
				<?php if($logged) { ?>
					<span><?php echo $user; ?></span>
					<a href="/?route=user/logout" class="btn btn-default"><?php echo $text_logout; ?></a>
				<?php } else { ?>
					<a href="" class="btn btn-default" data-toggle="modal" data-target="#loginForm"><?php echo $text_login; ?></a>

				<?php } ?>
				</div>
			</div>
		</div>
	</header>
<?php if(!$logged) { ?>
	<div class="modal fade" id="loginForm" tabindex="-1" role="dialog" aria-labelledby="loginFormLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close pull-right" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title pull-left" id="loginFormLabel"><?php echo $text_login; ?></h5>
					<div class="clearfix"></div>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label class="col-sm-3 control-label text-right" for="input-username"><?php echo $text_username; ?></label>
						<div class="col-sm-9">
							<input type="text" autocomplete="off" name="username" value="" placeholder="<?php echo $text_username; ?>" id="input-username" class="form-control" />
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label text-right" for="input-password"><?php echo $text_password; ?></label>
						<div class="col-sm-9">
							<input type="password" autocomplete="off" name="password" value="" placeholder="<?php echo $text_password; ?>" id="input-password" class="form-control" />
						</div>
						<div class="clearfix"></div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" id="logInBtt" class="btn btn-primary"><?php echo $button_login; ?></button>
				</div>
			</div>
		</div>
	</div>
<?php } ?>