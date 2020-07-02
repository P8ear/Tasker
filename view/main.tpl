<?php echo $header; ?>
<content>
	<div class="container">
		<ul class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		<?php } ?>
		</ul>
		<div class="row">
			<div class="col-md-2 text-right">
				<label class="control-label" for="input-sort"><?php echo $text_sort; ?></label>
			</div>
			<div class="col-md-4 text-right">
				<select id="input-sort" class="form-control" onchange="location = this.value;">
			<?php foreach ($sorts as $srt) { ?>
				<?php if ($srt['value'] == $sort . '-' . $order) { ?>
					<option value="<?php echo $srt['href']; ?>" selected="selected"><?php echo $srt['text']; ?></option>
				<?php } else { ?>
					<option value="<?php echo $srt['href']; ?>"><?php echo $srt['text']; ?></option>
				<?php } ?>
			<?php } ?>
			  </select>
			</div>
			<div class="col-md-6 text-right">
				<button class="btn btn-success"  data-toggle="modal" data-target="#addTaskForm"><i class="fa fa-plus" aria-hidden="true"></i> <?php echo $text_add_task; ?></button>
			</div>
		</div>
		<hr>
		<div class="row">
			<div class="col-sm-12">
				<table class="table">
					<thead>
						<td scope="col" class="text-center"><?php echo $text_task_name; ?></td>
						<td scope="col" class="text-center"><?php echo $text_task_email; ?></td>
						<td scope="col" class="text-center"><?php echo $text_task_text; ?></td>
						<td scope="col" class="text-center"><?php echo $text_task_status; ?></td>
					</thead>
					<tbody>
					<?php if($tasks) { ?>
						<?php foreach($tasks AS $task) { ?>
						<tr class="rowts_<?php echo $task['task_id']; ?>">
							<td  class="text-center col-sm-2 name"><?php echo $task['name']; ?></td>
							<td class="text-center col-sm-2 email"><?php echo $task['email']; ?></td>
							<td class="text-center <?php if($logged) { ?>col-sm-5<?php } else { ?>col-sm-6<?php } ?> task"><?php echo $task['task']; ?></td>
							<td class="text-center col-sm-2 status" rel="<?php echo $task['status']; ?>">
								<span>
							<?php if($task['status']) { ?>
								<i class="fa fa-check-circle-o text-success fa-2x" aria-hidden="true" data-toggle="tooltip" title="Выполнено"></i>
							<?php } else { ?>
								<i class="fa fa-clock-o text-danger fa-2x" data-toggle="tooltip" title="Ждет выполнения" aria-hidden="true"></i>
							<?php } ?>
								</span>
								<?php if($task['edited']) { ?>
									<i class="fa fa-pencil-square-o text-warning fa-2x" data-toggle="tooltip" title="Задача отредактирована администратором"></i>
								<?php } ?>
							</td>
						<?php if($logged) { ?>
							<td class="text-right col-sm-1">
								<button type="button" data-toggle="tooltip" title="<?php echo $text_edit_task; ?>" onclick="editTask(<?php echo $task['task_id']; ?>);"  class="btn btn-primary" ><i class="fa fa-pencil-square-o"></i></button>
							</td>
						<?php } ?>
						</tr>
						<?php } ?>
					<?php } else { ?>
						<tr>
							<td colspan="4" class="text-center"><strong><?php echo $error_task_empty; ?></strong></td>
						</tr>
					<?php } ?>
					</tbody>
				</table>
			</div>
			<div class="row">
				<div class="col-sm-12 text-center"><?php echo $pagination; ?></div>
			</div>
		</div>
	</div>
</content>
	<div class="modal fade" id="addTaskForm" tabindex="-1" role="dialog" aria-labelledby="addTaskFormLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close pull-right" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title pull-left" id="addTaskFormLabel"><?php echo $text_add_task; ?></h5>
					<div class="clearfix"></div>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label class="col-sm-3 control-label text-right" for="input-name"><?php echo $text_task_name; ?></label>
						<div class="col-sm-9">
							<input type="text" autocomplete="off" name="name" value="" placeholder="<?php echo $text_task_name; ?>" id="input-name" class="form-control" />
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label text-right" for="input-email"><?php echo $text_task_email; ?></label>
						<div class="col-sm-9">
							<input type="email" autocomplete="off" name="email" value="" placeholder="<?php echo $text_task_email; ?>" id="input-email" class="form-control" />
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label text-right" for="input-task_text"><?php echo $text_task_text; ?></label>
						<div class="col-sm-9">
							<textarea class="form-control" autocomplete="off"  placeholder="<?php echo $text_task_text; ?>" id="input-task_text"></textarea>
						</div>
						<div class="clearfix"></div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" id="addTaskBtt" class="btn btn-primary"><?php echo $button_add; ?></button>
				</div>
			</div>
		</div>
	</div>
	
<script type="text/javascript">
$(document).delegate('#addTaskBtt', 'click', function(){
	let error = '';
	let t_name = $('#addTaskForm #input-name').val();
	let t_email = $('#addTaskForm #input-email').val();
	let t_task = $('#addTaskForm #input-task_text').val();
	$('#addTaskForm .alert').fadeOut(100, function(){
		$(this).remove();
	});
	
	if(typeof t_name == 'undefined' || t_name === "") {
		error += 'Укажите имя<br>';
	}
	if(typeof t_email == 'undefined' || t_email === "") {
		error += 'Укажите Email<br>';
	}
	if(typeof t_task == 'undefined' || t_task === "") {
		error += 'Укажите текст задачи<br>';
	}
	if(error != '') {
		$('#addTaskForm .modal-body').append('<div class="alert alert-danger " style="display:none;">'+error+'</div>');
		$('#addTaskForm .alert').fadeIn(50);
	} else {
		$.ajax({
			url: '/?route=main/addTask',
			data: {name: t_name, email: t_email, task: t_task},
			type: 'POST',
			dataType: 'JSON',
			beforeSend: function() {
				$('#addTaskBtt').prepend('<i class="fa fa-cog fa-spin  fa-fw"></i>');
			},
			complete: function(){
				$('#addTaskBtt .fa').fadeOut(100, function(){
					$(this).remove();
				});
			},
			error: function(xhr, ajaxOptions, thrownError) {
	            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	        },
			success: function(json) {
				if(json.success) {
					window.location = '/';
				}
				if(json.error) {
					$('#addTaskForm .modal-body').append('<div class="alert alert-danger  " style="display:none;">'+json.error+'</div>');
					$('#addTaskForm .alert').fadeIn(100);
				}
			}
		});
	}
});
$(window).load(function(){
	$('[data-toggle="tooltip"]').tooltip();
});
</script>
<?php if($logged) { ?>
	<button class="btn hidden showEF"  data-toggle="modal" data-target="#editTaskForm"></button>
	<div class="modal fade" id="editTaskForm" tabindex="-2" role="dialog" aria-labelledby="editTaskFormLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close pull-right" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title pull-left" id="editTaskFormLabel"><?php echo $text_edit_task; ?></h5>
					<div class="clearfix"></div>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label class="col-sm-3 control-label text-right" for="edit-name"><?php echo $text_task_name; ?></label>
						<div class="col-sm-9">
							<input type="text" autocomplete="off" name="name" value="" placeholder="<?php echo $text_task_name; ?>" id="edit-name" class="form-control" />
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label text-right" for="edit-email"><?php echo $text_task_email; ?></label>
						<div class="col-sm-9">
							<input type="email" autocomplete="off" name="email" value="" placeholder="<?php echo $text_task_email; ?>" id="edit-email" class="form-control" />
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label text-right" for="edit-task_text"><?php echo $text_task_text; ?></label>
						<div class="col-sm-9">
							<textarea class="form-control" autocomplete="off"  placeholder="<?php echo $text_task_text; ?>" id="edit-task_text"></textarea>
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label text-right" ><?php echo $text_task_status; ?></label>
						<div class="col-sm-9">
							<label class="radio-inline">
								<input name="status" class="status" value="1" type="radio"  >
								<?php echo $text_yes; ?>
							</label>
							<label class="radio-inline">
								<input name="status" class="status" value="0" type="radio"  checked="checked" >
								<?php echo $text_no; ?>			
							</label>
						</div>
						<div class="clearfix"></div>
					</div>
				</div>
				<div class="modal-footer">
					<input type="hidden" name="task_id" id="task_id" value="0" />
					<button type="button" id="editTaskBtt" class="btn btn-primary"><?php echo $button_save; ?></button>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
var edited_task = '';
function editTask(task_id) {
	$('#editTaskForm #edit-name').val($('.rowts_'+task_id+' .name').text());
	$('#editTaskForm #edit-email').val($('.rowts_'+task_id+' .email').text());
	$('#editTaskForm #edit-task_text').val($('.rowts_'+task_id+' .task').text());
	edited_task = $('.rowts_'+task_id+' .task').text();
	let stat = $('.rowts_'+task_id+' .status').attr('rel');
	$('#editTaskForm input.status[value="'+stat+'"]').prop({checked:true});
	$('#editTaskForm #task_id').val(task_id);
	$('button.showEF').click();
}

$(document).delegate('#editTaskBtt', 'click', function(){
	let error = '';
	let t_name = $('#editTaskForm #edit-name').val();
	let t_email = $('#editTaskForm #edit-email').val();
	let t_task = $('#editTaskForm #edit-task_text').val();
	let t_status = $('#editTaskForm input.status[name="status"]:checked').val();
	let t_task_id = $('#editTaskForm #task_id').val();
	
	$('#editTaskForm .alert').fadeOut(100, function(){
		$(this).remove();
	});
	
	if(typeof t_task_id == 'undefined' || t_name == 0) {
		error += 'Ошибка формы редактирования. Обновите страницу<br>';
	}
	if(typeof t_name == 'undefined' || t_name === "") {
		error += 'Укажите имя<br>';
	}
	if(typeof t_email == 'undefined' || t_email === "") {
		error += 'Укажите Email<br>';
	}
	if(typeof t_task == 'undefined' || t_task === "") {
		error += 'Укажите текст задачи<br>';
	}
	if(typeof t_status == 'undefined' || t_status === "") {
		error += 'Укажите статус выполнения<br>';
	}
	if(error != '') {
		$('#editTaskForm .modal-body').append('<div class="alert alert-danger " style="display:none;">'+error+'</div>');
		$('#editTaskForm .alert').fadeIn(50);
	} else {
		$.ajax({
			url: '/?route=main/editTask',
			data: {name: t_name, email: t_email, task: t_task, status: t_status, task_id: t_task_id},
			type: 'POST',
			dataType: 'JSON',
			beforeSend: function() {
				$('#addTaskBtt').prepend('<i class="fa fa-cog fa-spin  fa-fw"></i>');
			},
			complete: function(){
				$('#addTaskBtt .fa').fadeOut(100, function(){
					$(this).remove();
				});
			},
			error: function(xhr, ajaxOptions, thrownError) {
	            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	        },
			success: function(json) {
				if(json.success) {
					$('#editTaskForm .modal-body').append('<div class="alert alert-success  " style="display:none;">'+json.success+'</div>');
					$('#editTaskForm .alert').fadeIn(100);
					
					$('.rowts_'+t_task_id+' .name').text(t_name);
					$('.rowts_'+t_task_id+' .email').text(t_email);
					$('.rowts_'+t_task_id+' .task').text(t_task);
					
					if(edited_task != t_task) {
						if($('.rowts_'+t_task_id+' .status span').next('i.fa').length == 0) {
							$('.rowts_'+t_task_id+' .status span').after('&nbsp;<i class="fa fa-pencil-square-o text-warning fa-2x"></i>');
						}
						edited_task = t_task;
					}
					
					
					$('.rowts_'+t_task_id+' .status').attr('rel', t_status);
					if(t_status > 0) {
						$('.rowts_'+t_task_id+' .status span').html('<i class="fa fa-check-circle-o text-success fa-2x"  data-toggle="tooltip" title="Выполнено" aria-hidden="true"></i>');
					} else {
						$('.rowts_'+t_task_id+' .status span').html('<i class="fa fa-clock-o text-danger fa-2x" data-toggle="tooltip" title="Ждет выполнения" aria-hidden="true"></i>');
					}
					$('[data-toggle="tooltip"]').tooltip();
				}
				if(json.error) {
					$('#editTaskForm .modal-body').append('<div class="alert alert-danger  " style="display:none;">'+json.error+'</div>');
					$('#editTaskForm .alert').fadeIn(100);
				}
			}
		});
	}
	
});
</script>
<?php } ?>
<?php echo $footer; ?>